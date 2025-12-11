<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs"
    Inherits="Lavalife.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <title>FriendBook - Connexion</title>
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
        /* Login wrapper */
        .login-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(rgba(0, 0, 0, .9), rgba(0, 0, 0, .9)), url(img/carousel-1.jpg) center center no-repeat;
            background-size: cover;
            padding: 120px 20px 80px;
        }

        .login-container {
            max-width: 500px;
            width: 100%;
            background-color: rgba(20, 20, 20, 0.95);
            padding: 50px 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(255, 20, 147, 0.4);
            border: 2px solid rgba(255, 20, 147, 0.3);
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-icon {
            font-size: 3.5rem;
            color: var(--bs-primary);
            margin-bottom: 1rem;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
        }

        .login-title {
            color: var(--bs-white);
            font-size: 2rem;
            font-weight: 700;
            text-transform: uppercase;
            margin-bottom: 0.5rem;
            letter-spacing: 2px;
        }

        .login-subtitle {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.95rem;
        }

        /* Form styling */
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

        .textbox {
            width: 100%;
            padding: 14px 18px;
            background-color: rgba(40, 40, 40, 0.9);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            color: var(--bs-white);
            font-size: 1rem;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        .textbox:focus {
            outline: none;
            border-color: var(--bs-primary);
            background-color: rgba(50, 50, 50, 0.9);
            box-shadow: 0 0 20px rgba(255, 20, 147, 0.4);
        }

        .textbox::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }

        /* Validation */
        .validation {
            color: #ff6b6b;
            font-size: 0.85rem;
            margin-top: 6px;
            display: block;
            animation: shake 0.3s ease;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        /* Login button */
        .btn-login {
            width: 100%;
            background-color: var(--bs-primary);
            color: var(--bs-white);
            border: 2px solid var(--bs-primary);
            padding: 16px 30px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            cursor: pointer;
            margin-top: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.4s ease;
        }

        .btn-login:hover {
            background-color: transparent;
            border-color: var(--bs-primary);
            color: var(--bs-primary);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 20, 147, 0.5);
        }

        /* Messages */
        .message {
            margin-top: 20px;
            padding: 12px;
            text-align: center;
            font-weight: 600;
            border-radius: 10px;
            background-color: rgba(255, 20, 147, 0.1);
            color: var(--bs-primary);
            border: 1px solid var(--bs-primary);
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Links */
        .login-links {
            margin-top: 25px;
            text-align: center;
        }

        .login-links a {
            color: var(--bs-primary);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }

        .login-links a:hover {
            color: var(--bs-white);
            text-decoration: underline;
        }

        .divider {
            margin: 20px 0;
            text-align: center;
            color: rgba(255, 255, 255, 0.5);
            font-size: 0.9rem;
        }

        /* Input icons */
        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.4);
            font-size: 1rem;
            pointer-events: none;
        }

        .input-group .textbox {
            padding-left: 48px;
        }

        @media (max-width: 768px) {
            .login-container {
                padding: 40px 25px;
            }

            .login-title {
                font-size: 1.8rem;
            }
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

        <!-- Login Wrapper Start -->
        <div class="login-wrapper">
            <div class="login-container">
                <div class="login-header">
                    <div class="login-icon">
                        <i class="fas fa-heart"></i>
                    </div>
                    <h1 class="login-title">Connexion</h1>
                    <p class="login-subtitle">Ravi de te revoir sur FriendBook</p>
                </div>

                <div class="form-row">
                    <label for="txtFirstName">Prénom</label>
                    <div class="input-group">
                        <i class="fas fa-user input-icon"></i>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="textbox" placeholder="Ton prénom" />
                    </div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorFirstName" runat="server"
                        ControlToValidate="txtFirstName" CssClass="validation"
                        ErrorMessage="Le prénom est requis." Display="Dynamic" />
                </div>

                <div class="form-row">
                    <label for="txtLastName">Nom</label>
                    <div class="input-group">
                        <i class="fas fa-user input-icon"></i>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="textbox" placeholder="Ton nom" />
                    </div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorLastName" runat="server"
                        ControlToValidate="txtLastName" CssClass="validation"
                        ErrorMessage="Le nom est requis." Display="Dynamic" />
                </div>

                <div class="form-row">
                    <label for="txtEmail">Email</label>
                    <div class="input-group">
                        <i class="fas fa-envelope input-icon"></i>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox" placeholder="ton.email@exemple.com" />
                    </div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server"
                        ControlToValidate="txtEmail" CssClass="validation"
                        ErrorMessage="L'email est requis." Display="Dynamic" />
                </div>

                <div class="form-row">
                    <label for="txtPassword">Mot de passe</label>
                    <div class="input-group">
                        <i class="fas fa-lock input-icon"></i>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="textbox" placeholder="********" />
                    </div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server"
                        ControlToValidate="txtPassword" CssClass="validation"
                        ErrorMessage="Le mot de passe est requis." Display="Dynamic" />
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Se connecter"
                    CssClass="btn-login" OnClick="btnLogin_Click" />

                <asp:Label ID="lblMessage" runat="server" CssClass="message" />

                <div class="divider">━━━━━━━━ ou ━━━━━━━━</div>

                <div class="login-links">
                    <p style="color: rgba(255,255,255,0.7); margin-bottom: 10px;">Pas encore de compte ?</p>
                    <a href="Inscription.aspx">
                        <i class="fas fa-user-plus me-2"></i>Créer un compte
                    </a>
                </div>

                <div class="login-links" style="margin-top: 20px;">
                    <a href="Default.aspx">
                        <i class="fas fa-arrow-left me-2"></i>Retour à l'accueil
                    </a>
                </div>
            </div>
        </div>
        <!-- Login Wrapper End -->

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
</body>
</html>