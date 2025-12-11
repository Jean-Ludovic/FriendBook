using System;
using System.Web.UI;

namespace Lavalife
{
    public partial class Messages : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Si l’utilisateur n’est pas connecté → retour au Login
            if (Session["UserFirstName"] == null || Session["UserLastName"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string first = Session["UserFirstName"].ToString();
                string last = Session["UserLastName"].ToString();

                lblWelcome.Text = $"Logged in as {first} {last}";
            }
        }
    }
}
