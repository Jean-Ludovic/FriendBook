using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Drawing;

namespace Lavalife
{
    public partial class Inscription : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Vide - événement automatiquement branché via le .aspx
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Validation côté serveur
            if (!Page.IsValid)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Formulaire invalide : remplis tous les champs obligatoires.";
                return;
            }

            // Récupération des valeurs
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string birthDateStr = txtBirthDate.Text.Trim();
            string gender = ddlGender.SelectedValue;
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string ethnicity = ddlEthnicity.SelectedValue;
            string reason = ddlReason.SelectedValue;

            // Conversion de la date
            if (!DateTime.TryParse(birthDateStr, out DateTime birthDate))
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Date de naissance invalide (format: YYYY-MM-DD).";
                return;
            }

            // Validation de l'âge (18+)
            int age = DateTime.Today.Year - birthDate.Year;
            if (birthDate.Date > DateTime.Today.AddYears(-age)) age--;

            if (age < 18)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Tu dois avoir au moins 18 ans pour t'inscrire.";
                return;
            }

            // Récupération de la ConnectionString
            var cs = ConfigurationManager.ConnectionStrings["LavalifeConnectionString"];
            if (cs == null)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Erreur de configuration : ConnectionString introuvable.";
                return;
            }

            string connectionString = cs.ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Requête SQL paramétrée (protection contre l'injection SQL)
                    string query = @"
                        INSERT INTO [Users]
                            (FirstName, LastName, BirthDate, Gender, Email, Password, EthnicGroup, Reason)
                        VALUES
                            (@FirstName, @LastName, @BirthDate, @Gender, @Email, @Password, @EthnicGroup, @Reason)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // 🔒 IMPORTANT: En production, hash le mot de passe avec BCrypt!
                        cmd.Parameters.AddWithValue("@FirstName", firstName);
                        cmd.Parameters.AddWithValue("@LastName", lastName);
                        cmd.Parameters.AddWithValue("@BirthDate", birthDate);
                        cmd.Parameters.AddWithValue("@Gender", gender);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", password); // À hasher en prod!
                        cmd.Parameters.AddWithValue("@EthnicGroup", ethnicity);
                        cmd.Parameters.AddWithValue("@Reason", reason);

                        int rows = cmd.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            // ✅ SUCCÈS: Effacer le message et déclencher l'animation
                            lblMessage.Text = string.Empty;

                            // Appel de la fonction JavaScript pour l'animation + redirection
                            ClientScript.RegisterStartupScript(
                                this.GetType(),
                                "SuccessAnim",
                                "showSuccessAndRedirect();",
                                true
                            );
                        }
                        else
                        {
                            lblMessage.ForeColor = Color.Red;
                            lblMessage.Text = "Erreur: Aucune ligne insérée dans la base de données.";
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                lblMessage.ForeColor = Color.Red;

                // Gestion des erreurs SQL spécifiques
                if (ex.Number == 2627 || ex.Number == 2601) // Clé dupliquée
                {
                    lblMessage.Text = "Cette adresse courriel est déjà utilisée.";
                }
                else
                {
                    lblMessage.Text = "Erreur SQL (" + ex.Number + "): " + ex.Message;
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Erreur inattendue: " + ex.Message;
            }
        }
    }
}