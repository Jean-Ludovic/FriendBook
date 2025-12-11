<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Inscription.aspx.cs"
    Inherits="Lavalife.Inscription" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <title>FriendBook - Inscription</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="keywords" />
    <meta content="" name="description" />

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon" />

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@300;700&family=Work+Sans:wght@400;600&display=swap"
          rel="stylesheet" />

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="./Poseify-1.0.0/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Template Stylesheet -->
    <link href="./Poseify-1.0.0/css/style.css" rel="stylesheet" />

    <style type="text/css">
        /* Form container */
        .form-wrapper {
            min-height: 100vh;
            background: linear-gradient(rgba(0, 0, 0, .9), rgba(0, 0, 0, .9)), url(img/carousel-1.jpg) center center no-repeat;
            background-size: cover;
            padding: 120px 20px 80px;
        }

        .form-container {
            max-width: 700px;
            margin: 0 auto;
            background-color: rgba(20, 20, 20, 0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(255, 20, 147, 0.3);
            border: 2px solid rgba(255, 20, 147, 0.3);
        }

        .form-title {
            text-align: center;
            color: var(--bs-white);
            font-size: 2.5rem;
            font-weight: 700;
            text-transform: uppercase;
            margin-bottom: 0.5rem;
            letter-spacing: 2px;
        }

        .form-subtitle {
            text-align: center;
            color: rgba(255, 255, 255, 0.7);
            font-size: 1rem;
            margin-bottom: 2rem;
        }

        /* Form rows */
        .form-row {
            margin-bottom: 20px;
        }

        .form-row label {
            display: block;
            color: var(--bs-white);
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .textbox, .dropdown {
            width: 100%;
            padding: 12px 15px;
            background-color: rgba(40, 40, 40, 0.9);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            color: var(--bs-white);
            font-size: 1rem;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        .textbox:focus, .dropdown:focus {
            outline: none;
            border-color: var(--bs-primary);
            background-color: rgba(50, 50, 50, 0.9);
            box-shadow: 0 0 15px rgba(255, 20, 147, 0.3);
        }

        .dropdown option {
            background-color: #222;
            color: var(--bs-white);
        }

        /* Validation */
        .validation {
            color: #ff6b6b;
            font-size: 0.85rem;
            margin-top: 5px;
            display: block;
        }

        /* Submit button */
        .btn-submit {
            width: 100%;
            background-color: var(--bs-primary);
            color: var(--bs-white);
            border: 2px solid var(--bs-primary);
            padding: 15px 30px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            cursor: pointer;
            margin-top: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.4s ease;
        }

        .btn-submit:hover {
            background-color: transparent;
            border-color: var(--bs-primary);
            color: var(--bs-primary);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 20, 147, 0.4);
        }

        /* Messages */
        .message {
            margin-top: 20px;
            padding: 12px;
            text-align: center;
            font-weight: 600;
            border-radius: 8px;
            background-color: rgba(255, 20, 147, 0.1);
            color: var(--bs-primary);
            border: 1px solid var(--bs-primary);
        }

        /* Back link */
        .back-link {
            margin-top: 25px;
            text-align: center;
        }

        .back-link a {
            color: var(--bs-primary);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 1rem;
        }

        .back-link a:hover {
            color: var(--bs-white);
            text-decoration: underline;
        }

        /* Two columns for form fields */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-container {
                padding: 30px 20px;
            }

            .form-title {
                font-size: 2rem;
            }
        }

        /* Success Overlay */
        #successOverlay {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.85);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            backdrop-filter: blur(10px);
        }

        #successModal {
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
            border-radius: 20px;
            padding: 40px 50px;
            text-align: center;
            max-width: 450px;
            box-shadow: 0 20px 60px rgba(255, 20, 147, 0.5);
            border: 2px solid var(--bs-primary);
            animation: modalSlideIn 0.5s ease-out;
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        #successModal p {
            margin-top: 20px;
            font-weight: bold;
            font-size: 1.2rem;
            color: var(--bs-white);
        }

        #successModal p span {
            color: var(--bs-primary);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header Start -->
        <div class="container-fluid p-0">
            <nav class="navbar navbar-expand-lg navbar-dark px-lg-5 bg-dark" style="position: fixed; width: 100%; top: 0; z-index: 999;">
                <a href="Default.aspx" class="navbar-brand ms-4 ms-lg-0">
                    <h2 class="mb-0 text-primary text-uppercase">
                        <i class="fa-regular fa-face-smile me-1"></i>FriendBook
                    </h2>
                </a>
            </nav>
        </div>
        <!-- Header End -->

        <!-- Form Wrapper Start -->
        <div class="form-wrapper">
            <div class="form-container">
                <h1 class="form-title">
                    <i class="fas fa-user-plus me-2"></i>Créer ton profil
                </h1>
                <p class="form-subtitle">Rejoins FriendBook et commence ton aventure</p>

                <div class="form-grid">
                    <div class="form-row">
                        <label for="txtFirstName">Prénom</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="textbox" placeholder="Ton prénom" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                            ControlToValidate="txtFirstName" CssClass="validation"
                            ErrorMessage="Le prénom est requis." Display="Dynamic" />
                    </div>

                    <div class="form-row">
                        <label for="txtLastName">Nom</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="textbox" placeholder="Ton nom" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                            ControlToValidate="txtLastName" CssClass="validation"
                            ErrorMessage="Le nom est requis." Display="Dynamic" />
                    </div>
                </div>

                <div class="form-grid">
                    <div class="form-row">
                        <label for="txtBirthDate">Date de naissance</label>
                        <asp:TextBox ID="txtBirthDate" runat="server" CssClass="textbox" Placeholder="AAAA-MM-JJ" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                            ControlToValidate="txtBirthDate" CssClass="validation"
                            ErrorMessage="La date de naissance est requise." Display="Dynamic" />
                    </div>

                    <div class="form-row">
                        <label for="ddlGender">Genre</label>
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="dropdown">
                            <asp:ListItem Text="-- Sélectionne --" Value="" />
                            <asp:ListItem Text="Femme" Value="Female" />
                            <asp:ListItem Text="Homme" Value="Male" />
                            <asp:ListItem Text="Autre" Value="Other" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                            ControlToValidate="ddlGender" InitialValue="" CssClass="validation"
                            ErrorMessage="Le genre est requis." Display="Dynamic" />
                    </div>
                </div>

                <div class="form-row">
                    <label for="txtEmail">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox" placeholder="ton.email@exemple.com" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                        ControlToValidate="txtEmail" CssClass="validation"
                        ErrorMessage="L'email est requis." Display="Dynamic" />
                </div>

                <div class="form-row">
                    <label for="txtPassword">Mot de passe</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="textbox" placeholder="********" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                        ControlToValidate="txtPassword" CssClass="validation"
                        ErrorMessage="Le mot de passe est requis." Display="Dynamic" />
                </div>

                <div class="form-grid">
                    <div class="form-row">
                        <label for="ddlEthnicity">Origine ethnique</label>
                        <asp:DropDownList ID="ddlEthnicity" runat="server" CssClass="dropdown">
                            <asp:ListItem Text="-- Sélectionne --" Value="" />
                            <asp:ListItem Text="Africaine" Value="African" />
                            <asp:ListItem Text="Européenne" Value="European" />
                            <asp:ListItem Text="Asiatique" Value="Asian" />
                            <asp:ListItem Text="Latino" Value="Latin" />
                            <asp:ListItem Text="Autre" Value="Other" />
                        </asp:DropDownList>
                    </div>

                    <div class="form-row">
                        <label for="ddlReason">Raison d'inscription</label>
                        <asp:DropDownList ID="ddlReason" runat="server" CssClass="dropdown">
                            <asp:ListItem Text="-- Sélectionne --" Value="" />
                            <asp:ListItem Text="Amour" Value="Love" />
                            <asp:ListItem Text="Amitié" Value="Friendship" />
                            <asp:ListItem Text="Réseau professionnel" Value="Networking" />
                            <asp:ListItem Text="Autres intérêts" Value="Other" />
                        </asp:DropDownList>
                    </div>
                </div>

                <asp:Button ID="btnRegister" runat="server" Text="Créer mon compte"
                    CssClass="btn-submit" OnClick="btnRegister_Click" />

                <asp:Label ID="lblMessage" runat="server" CssClass="message" />
                
                <div class="back-link">
                    <a href="Default.aspx">
                        <i class="fas fa-arrow-left me-2"></i>Retour à l'accueil
                    </a>
                </div>
            </div>
        </div>
        <!-- Form Wrapper End -->

        <!-- Success Overlay -->
        <div id="successOverlay">
            <div id="successModal">
                <div id="lottieContainer" style="width:250px;height:250px;margin:0 auto;"></div>
                <p>
                    <span>Profil créé avec succès !</span><br />
                    Redirection vers la connexion...
                </p>
            </div>
        </div>

        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-light footer py-5" style="margin-top: 0;">
            <div class="container text-center py-5">
                <a href="Default.aspx">
                    <h1 class="display-4 mb-3 text-white text-uppercase">
                        <i class="fa-regular fa-face-smile me-1"></i>FriendBook
                    </h1>
                </a>
                <div class="d-flex justify-content-center mb-4">
                    <a class="btn btn-lg-square btn-outline-primary border-2 m-1" href="#!">
                        <i class="fab fa-x-twitter"></i>
                    </a>
                    <a class="btn btn-lg-square btn-outline-primary border-2 m-1" href="#!">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a class="btn btn-lg-square btn-outline-primary border-2 m-1" href="#!">
                        <i class="fab fa-youtube"></i>
                    </a>
                    <a class="btn btn-lg-square btn-outline-primary border-2 m-1" href="#!">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                </div>
                <p>&copy; <a class="border-bottom" href="#">FriendBook</a>, Tous droits réservés.</p>
                <p class="mb-0">Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a>. Distributed by <a href="https://themewagon.com" target="_blank">ThemeWagon</a>.</p>
            </div>
        </div>
        <!-- Footer End -->
    </form>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- CDN Lottie -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bodymovin/5.12.2/lottie.min.js"></script>

    <script type="text/javascript">
        function showSuccessAndRedirect() {
            // Afficher l'overlay
            var overlay = document.getElementById('successOverlay');
            overlay.style.display = 'flex';

            // Lancer l'animation Lottie
            var anim = lottie.loadAnimation({
                container: document.getElementById('lottieContainer'),
                renderer: 'svg',
                loop: false,
                autoplay: true,
                path: '<%= ResolveUrl("~/Lottie/Love_is_blind.json") %>'
            });

            // Redirection après l'animation
            anim.addEventListener('complete', function () {
                setTimeout(function () {
                    window.location.href = '<%= ResolveUrl("~/Login.aspx") %>';
                }, 1000);
            });
        }
    </script>
</body>
</html>