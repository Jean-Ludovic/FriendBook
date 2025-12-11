using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Drawing;

namespace Lavalife
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.Text = string.Empty;

            if (!Page.IsValid)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Please fill all required fields.";
                return;
            }

            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();   // même format que celui enregistré

            // Récupération de la connection string
            var cs = ConfigurationManager.ConnectionStrings["LavalifeConnectionString"];
            if (cs == null)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Connection string 'LavalifeConnectionString' not found.";
                return;
            }

            string connectionString = cs.ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string query = @"
                        SELECT COUNT(*) 
                        FROM Users
                        WHERE FirstName = @FirstName
                          AND LastName  = @LastName
                          AND Email     = @Email
                          AND Password  = @Password;";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@FirstName", firstName);
                        cmd.Parameters.AddWithValue("@LastName", lastName);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", password); // adapter si tu hashes plus tard

                        int count = (int)cmd.ExecuteScalar();

                        if (count > 0)
                        {
                            // Optionnel : stocker des infos en session
                            Session["UserFirstName"] = firstName;
                            Session["UserLastName"] = lastName;
                            Session["UserEmail"] = email;

                            // Message + redirection
                            lblMessage.ForeColor = Color.Green;
                            lblMessage.Text = "Login successful. Redirecting...";

                            // Redirection vers la page membre (change si tu veux autre chose)
                            Response.Redirect("Messages.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                        }
                        else
                        {
                            lblMessage.ForeColor = Color.Red;
                            lblMessage.Text = "Invalid name, email or password.";
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "SQL Error: " + ex.Message;
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }
    }
}
