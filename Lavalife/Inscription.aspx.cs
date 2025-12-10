using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;

namespace Lavalife
{
    public partial class Inscription : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblMessage.Text = string.Empty;
            lblMessage.ForeColor = Color.Red;

            // 1) Validation serveur
            if (!Page.IsValid)
            {
                lblMessage.Text = "Form is not valid.";
                return;
            }

            // 2) Récupération des valeurs
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string birthDateStr = txtBirthDate.Text.Trim();
            string gender = ddlGender.SelectedValue;
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string ethnicity = ddlEthnicity.SelectedValue;
            string reason = ddlReason.SelectedValue;

            // 3) Date
            if (!DateTime.TryParse(birthDateStr, out DateTime birthDate))
            {
                lblMessage.Text = "Invalid birth date.";
                return;
            }

            // 4) ConnectionString
            var cs = ConfigurationManager.ConnectionStrings["LavalifeConnectionString"];
            if (cs == null)
            {
                lblMessage.Text = "ConnectionString 'LavalifeConnectionString' not found in Web.config.";
                return;
            }
            string connectionString = cs.ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // ⚠️ TABLE : Users
                    string query = @"
                        INSERT INTO Users
                            (FirstName, LastName, BirthDate, Gender, Email, Password, EthnicGroup, Reason)
                        VALUES
                            (@FirstName, @LastName, @BirthDate, @Gender, @Email, @Password, @EthnicGroup, @Reason)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@FirstName", firstName);
                        cmd.Parameters.AddWithValue("@LastName", lastName);
                        cmd.Parameters.AddWithValue("@BirthDate", birthDate);
                        cmd.Parameters.AddWithValue("@Gender", gender);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", password); // à hasher plus tard
                        cmd.Parameters.AddWithValue("@EthnicGroup", ethnicity);
                        cmd.Parameters.AddWithValue("@Reason", reason);

                        int rows = cmd.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            lblMessage.ForeColor = Color.Green;
                            lblMessage.Text = "Profile inserted in database.";

                            // 🔥 Script complet : alert + Lottie + redirection
                            string script = @"
                                (function() {
                                    // 1) Alert immédiat
                                    alert('Profile created successfully!');

                                    // 2) Affiche l’overlay
                                    var overlay = document.getElementById('successOverlay');
                                    if (overlay) {
                                        overlay.style.display = 'flex';
                                    }

                                    // 3) Si Lottie est chargé, on joue l’animation
                                    if (window.lottie) {
                                        var anim = lottie.loadAnimation({
                                            container: document.getElementById('lottieContainer'),
                                            renderer: 'svg',
                                            loop: false,
                                            autoplay: true,
                                            path: '" + ResolveUrl("~/Lottie/Love is blind.json") + @"'
                                        });

                                        anim.addEventListener('complete', function () {
                                            setTimeout(function () {
                                                window.location.href = '" + ResolveUrl("~/Login.aspx") + @"';
                                            }, 1000);
                                        });
                                    } else {
                                        // Si Lottie n’est pas dispo, on redirige direct
                                        window.location.href = '" + ResolveUrl("~/Login.aspx") + @"';
                                    }
                                })();";

                            ClientScript.RegisterStartupScript(
                                this.GetType(),
                                "SuccessAnim",
                                script,
                                true
                            );
                        }
                        else
                        {
                            lblMessage.Text = "No row inserted (rows = 0).";
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                lblMessage.Text = $"SQL ERROR ({ex.Number}) : {ex.Message}";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "ERROR : " + ex.Message;
            }
        }
    }
}
