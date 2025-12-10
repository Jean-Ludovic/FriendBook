using System;
using System.Web.UI;

namespace Lavalife
{
    public partial class Default2 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // rien de spécial ici pour l'instant
        }

        protected void btnGoToSignUp_Click(object sender, EventArgs e)
        {
            Response.Redirect("Inscription.aspx");
        }

        protected void btnGoToLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}
