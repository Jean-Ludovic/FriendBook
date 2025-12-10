using System;
using System.Web.UI;

namespace Lavalife
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Page d'accueil — pour l'instant, rien de spécial à faire ici
        }

        // Bouton SIGN UP
        protected void btnGoToSignUp_Click(object sender, EventArgs e)
        {
            Response.Redirect("Inscription.aspx");
        }

        // Bouton LOGIN
        protected void btnGoToLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}
