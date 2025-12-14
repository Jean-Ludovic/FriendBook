using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace Lavalife
{
    public partial class Messages : Page
    {
        private const bool ENABLE_DEBUG = true;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserFirstName"] == null || Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                string firstName = (Session["UserFirstName"]?.ToString() ?? "").Trim();
                string email = (Session["UserEmail"]?.ToString() ?? "").Trim();

                lblWelcome.Text = firstName;
                lblUserEmail.Text = email;
                lblProfileFirstName.Text = firstName;
                lblProfileEmail.Text = email;

                lblUserInitial.Text = string.IsNullOrWhiteSpace(firstName) ? "?" : firstName.Substring(0, 1).ToUpper();

                LoadMembers();
            }
        }

        private static string CleanFilter(string value)
        {
            string v = (value ?? "").Trim();
            if (v.Equals("Tous", StringComparison.OrdinalIgnoreCase)) return "";
            if (v.Equals("Toutes", StringComparison.OrdinalIgnoreCase)) return "";
            return v;
        }

        private static string NormalizeGender(string value)
        {
            string v = CleanFilter(value);
            if (string.IsNullOrEmpty(v)) return "";

            if (v.Equals("Femme", StringComparison.OrdinalIgnoreCase)) return "Female";
            if (v.Equals("Homme", StringComparison.OrdinalIgnoreCase)) return "Male";
            if (v.Equals("Autre", StringComparison.OrdinalIgnoreCase)) return "Other";

            if (v.Equals("Female", StringComparison.OrdinalIgnoreCase)) return "Female";
            if (v.Equals("Male", StringComparison.OrdinalIgnoreCase)) return "Male";
            if (v.Equals("Other", StringComparison.OrdinalIgnoreCase)) return "Other";

            return v;
        }

        private static string NormalizeReason(string value)
        {
            string v = CleanFilter(value);
            if (string.IsNullOrEmpty(v)) return "";

            if (v.Equals("Amour", StringComparison.OrdinalIgnoreCase)) return "Love";
            if (v.Equals("Amitié", StringComparison.OrdinalIgnoreCase)) return "Friendship";
            if (v.Equals("Réseau professionnel", StringComparison.OrdinalIgnoreCase)) return "Networking";

            if (v.Equals("Love", StringComparison.OrdinalIgnoreCase)) return "Love";
            if (v.Equals("Friendship", StringComparison.OrdinalIgnoreCase)) return "Friendship";
            if (v.Equals("Networking", StringComparison.OrdinalIgnoreCase)) return "Networking";

            return v;
        }

        private void LoadMembers(string searchName = "", string gender = "",
            int ageMin = 0, int ageMax = 999, string ethnicity = "", string reason = "")
        {
            var cs = ConfigurationManager.ConnectionStrings["LavalifeConnectionString"];
            if (cs == null) { ShowError("ConnectionString introuvable."); return; }

            string connectionString = cs.ConnectionString;
            string currentUserEmail = (Session["UserEmail"]?.ToString() ?? "").Trim();

            searchName = CleanFilter(searchName);
            gender = NormalizeGender(gender);
            ethnicity = CleanFilter(ethnicity);
            reason = NormalizeReason(reason);

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var qb = new StringBuilder();
                    qb.Append(@"
SELECT 
    Id,
    FirstName,
    LastName,
    BirthDate,
    Gender,
    Email,
    EthnicGroup,
    Reason,
    DATEDIFF(YEAR, BirthDate, GETDATE())
      - CASE 
          WHEN DATEADD(YEAR, DATEDIFF(YEAR, BirthDate, GETDATE()), BirthDate) > GETDATE() 
          THEN 1 ELSE 0 
        END AS Age
FROM Users
WHERE LTRIM(RTRIM(ISNULL(Email,''))) <> @CurrentUserEmail
");

                    if (!string.IsNullOrEmpty(searchName))
                    {
                        qb.Append(@"
AND (
    FirstName LIKE @SearchName
    OR LastName LIKE @SearchName
    OR (FirstName + ' ' + LastName) LIKE @SearchName
    OR (LastName + ' ' + FirstName) LIKE @SearchName
)");
                    }

                    if (!string.IsNullOrEmpty(gender))
                    {
                        qb.Append(@"
AND (
    LTRIM(RTRIM(ISNULL(Gender,''))) = @Gender
    OR (@Gender = 'Other'  AND LTRIM(RTRIM(ISNULL(Gender,''))) IN ('Autre','Other'))
    OR (@Gender = 'Male'   AND LTRIM(RTRIM(ISNULL(Gender,''))) IN ('Homme','Male'))
    OR (@Gender = 'Female' AND LTRIM(RTRIM(ISNULL(Gender,''))) IN ('Femme','Female'))
)");
                    }

                    // Age exact
                    if (ageMin > 0)
                    {
                        qb.Append(@"
AND (
    DATEDIFF(YEAR, BirthDate, GETDATE())
      - CASE 
          WHEN DATEADD(YEAR, DATEDIFF(YEAR, BirthDate, GETDATE()), BirthDate) > GETDATE() 
          THEN 1 ELSE 0 
        END
) >= @AgeMin
");
                    }
                    if (ageMax < 999)
                    {
                        qb.Append(@"
AND (
    DATEDIFF(YEAR, BirthDate, GETDATE())
      - CASE 
          WHEN DATEADD(YEAR, DATEDIFF(YEAR, BirthDate, GETDATE()), BirthDate) > GETDATE() 
          THEN 1 ELSE 0 
        END
) <= @AgeMax
");
                    }

                    if (!string.IsNullOrEmpty(ethnicity))
                        qb.Append(" AND LTRIM(RTRIM(ISNULL(EthnicGroup,''))) = @Ethnicity");

                    if (!string.IsNullOrEmpty(reason))
                    {
                        qb.Append(@"
AND (
    LTRIM(RTRIM(ISNULL(Reason,''))) = @Reason
    OR (@Reason = 'Love'       AND LTRIM(RTRIM(ISNULL(Reason,''))) IN ('Amour','Love'))
    OR (@Reason = 'Friendship' AND LTRIM(RTRIM(ISNULL(Reason,''))) IN ('Amitié','Friendship'))
    OR (@Reason = 'Networking' AND LTRIM(RTRIM(ISNULL(Reason,''))) IN ('Réseau professionnel','Networking'))
)");
                    }

                    qb.Append(" ORDER BY FirstName;");

                    using (SqlCommand cmd = new SqlCommand(qb.ToString(), conn))
                    {
                        cmd.Parameters.AddWithValue("@CurrentUserEmail", currentUserEmail);

                        if (!string.IsNullOrEmpty(searchName))
                            cmd.Parameters.AddWithValue("@SearchName", "%" + searchName + "%");

                        if (!string.IsNullOrEmpty(gender))
                            cmd.Parameters.AddWithValue("@Gender", gender);

                        if (ageMin > 0)
                            cmd.Parameters.AddWithValue("@AgeMin", ageMin);

                        if (ageMax < 999)
                            cmd.Parameters.AddWithValue("@AgeMax", ageMax);

                        if (!string.IsNullOrEmpty(ethnicity))
                            cmd.Parameters.AddWithValue("@Ethnicity", ethnicity);

                        if (!string.IsNullOrEmpty(reason))
                            cmd.Parameters.AddWithValue("@Reason", reason);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            DataTable dt = new DataTable();
                            dt.Load(reader);

                            rptMembers.DataSource = dt;
                            rptMembers.DataBind();

                            lblNoResults.Visible = (dt.Rows.Count == 0);
                            if (dt.Rows.Count == 0) lblNoResults.Text = "Aucun membre trouvé selon vos critères.";

                            if (ENABLE_DEBUG)
                            {
                                lblDebug.Text =
                                    $"DEBUG | search='{searchName}' gender='{gender}' ageMin={ageMin} ageMax={ageMax} ethnic='{ethnicity}' reason='{reason}' | results={dt.Rows.Count}";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Erreur : " + ex.Message);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchName = CleanFilter(txtSearchName.Text);
            string gender = CleanFilter(ddlSearchGender.SelectedValue);
            string ethnicity = CleanFilter(ddlSearchEthnicity.SelectedValue);
            string reason = CleanFilter(ddlSearchReason.SelectedValue);

            int ageMin = ParseAgeMin(txtAgeMin.Text);
            int ageMax = ParseAgeMax(txtAgeMax.Text);

            // si l'utilisateur se trompe (min > max), on corrige
            if (ageMin > ageMax)
            {
                int tmp = ageMin;
                ageMin = ageMax;
                ageMax = tmp;
            }

            LoadMembers(searchName, gender, ageMin, ageMax, ethnicity, reason);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        protected string GetGenderIcon(object gender)
        {
            if (gender == null) return "fa-user";
            string g = NormalizeGender(gender.ToString());
            if (g == "Female") return "fa-venus";
            if (g == "Male") return "fa-mars";
            return "fa-genderless";
        }

        protected string GetReasonIcon(object reason)
        {
            if (reason == null) return "fa-question";
            string r = NormalizeReason(reason.ToString());
            switch (r)
            {
                case "Love": return "fa-heart";
                case "Friendship": return "fa-users";
                case "Networking": return "fa-briefcase";
                default: return "fa-star";
            }
        }

        protected string GetReasonText(object reason)
        {
            if (reason == null) return "Autre";
            string r = NormalizeReason(reason.ToString());
            switch (r)
            {
                case "Love": return "Amour";
                case "Friendship": return "Amitié";
                case "Networking": return "Réseau professionnel";
                default: return "Autre";
            }
        }

        protected string GetGenderText(object gender)
        {
            if (gender == null) return "Non spécifié";
            string g = NormalizeGender(gender.ToString());
            switch (g)
            {
                case "Female": return "Femme";
                case "Male": return "Homme";
                case "Other": return "Autre";
                default: return "Non spécifié";
            }
        }

        protected string GetInitial(object firstName)
        {
            string f = (firstName?.ToString() ?? "").Trim();
            if (string.IsNullOrEmpty(f)) return "?";
            return f.Substring(0, 1).ToUpper();
        }

        private void ShowError(string msg)
        {
            lblNoResults.Visible = true;
            lblNoResults.Text = msg;
        }
        private static int ParseAgeMin(string raw)
        {
            raw = (raw ?? "").Trim();
            if (string.IsNullOrEmpty(raw)) return 0;      // vide => pas de filtre
            if (!int.TryParse(raw, out int v)) return 0;  // invalide => pas de filtre
            if (v < 0) v = 0;
            if (v > 150) v = 150;
            return v;
        }

        private static int ParseAgeMax(string raw)
        {
            raw = (raw ?? "").Trim();
            if (string.IsNullOrEmpty(raw)) return 999;       // vide => pas de filtre
            if (!int.TryParse(raw, out int v)) return 999;   // invalide => pas de filtre
            if (v < 0) v = 0;
            if (v > 999) v = 999;
            return v;
        }

    }
}
