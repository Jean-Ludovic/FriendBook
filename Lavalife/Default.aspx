<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs"
    Inherits="Lavalife._Default" %>
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
    <link href="./Poseify-1.0.0/css/style.css rel="stylesheet" />

    <style type="text/css">
        /* Hero section centrée */
        .hero-section {
            min-height: 70vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(rgba(0, 0, 0, .85), rgba(0, 0, 0, .85)), url(img/carousel-2.jpg) center center no-repeat;
            background-size: cover;
            padding: 100px 20px 80px;
        }

        .hero-content {
            text-align: center;
            max-width: 700px;
            animation: fadeInUp 1s ease-out;
        }

        .hero-content .icon-heart {
            font-size: 4rem;
            color: var(--bs-primary);
            margin-bottom: 1.5rem;
            animation: heartbeat 2s ease-in-out infinite;
        }

        .hero-content h1 {
            font-size: 3.5rem;
            font-weight: 700;
            color: var(--bs-white);
            text-transform: uppercase;
            margin-bottom: 1rem;
            letter-spacing: 2px;
        }

        .hero-content .tagline {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2.5rem;
            font-weight: 300;
            line-height: 1.8;
        }

        .action-buttons {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-hero {
            padding: 18px 50px;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 50px;
            border: 2px solid;
            transition: all 0.4s ease;
            letter-spacing: 1px;
            min-width: 200px;
        }

        .btn-hero-primary {
            background-color: var(--bs-primary);
            border-color: var(--bs-primary);
            color: var(--bs-white);
        }

        .btn-hero-primary:hover {
            background-color: transparent;
            border-color: var(--bs-primary);
            color: var(--bs-primary);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 20, 147, 0.3);
        }

        .btn-hero-outline {
            background-color: transparent;
            border-color: var(--bs-white);
            color: var(--bs-white);
        }

        .btn-hero-outline:hover {
            background-color: var(--bs-white);
            border-color: var(--bs-white);
            color: var(--bs-dark);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 255, 255, 0.3);
        }

        /* Info section */
        .info-section {
            padding: 4rem 0;
            background-color: var(--bs-dark);
        }

        .info-content {
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
            padding: 0 20px;
        }

        .info-content h2 {
            font-size: 2.5rem;
            color: var(--bs-white);
            margin-bottom: 1.5rem;
            text-transform: uppercase;
        }

        .info-content p {
            font-size: 1.1rem;
            color: rgba(255, 255, 255, 0.8);
            line-height: 1.8;
            margin-bottom: 1rem;
        }

        .features-list {
            display: flex;
            justify-content: center;
            gap: 3rem;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .feature-item {
            text-align: center;
            max-width: 200px;
        }

        .feature-item i {
            font-size: 2.5rem;
            color: var(--bs-primary);
            margin-bottom: 1rem;
        }

        .feature-item p {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.9);
        }

        /* Animations */
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

        @keyframes heartbeat {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-content h1 {
                font-size: 2.5rem;
            }

            .hero-content .tagline {
                font-size: 1.1rem;
            }

            .btn-hero {
                padding: 15px 40px;
                font-size: 1rem;
                min-width: 180px;
            }

            .action-buttons {
                flex-direction: column;
                align-items: center;
            }

            .features-list {
                gap: 2rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header Start -->
        <div class="container-fluid p-0">
            <nav class="navbar navbar-expand-lg navbar-dark px-lg-5 bg-dark">
                <a href="index.html" class="navbar-brand ms-4 ms-lg-0">
                    <h2 class="mb-0 text-primary text-uppercase">
                        <i class="fa-regular fa-face-smile me-1"></i>FriendBook
                    </h2>
                </a>
            </nav>
        </div>
        <!-- Header End -->

        <!-- Hero Section Start -->
        <div class="hero-section">
            <div class="hero-content">
                <div class="icon-heart">
                    <i class="fas fa-heart"></i>
                </div>
                <h1>Bienvenue sur FriendBook</h1>
                <p class="tagline">
                    Découvre des connexions authentiques, crée des liens sincères et commence ton aventure dès maintenant.
                </p>
                <div class="action-buttons">
                    <asp:Button ID="btnGoToSignUp" runat="server" Text="Créer un compte"
                        CssClass="btn-hero btn-hero-primary"
                        PostBackUrl="~/Inscription.aspx" />
                    <asp:Button ID="btnGoToLogin" runat="server" Text="Se connecter"
                        CssClass="btn-hero btn-hero-outline"
                        PostBackUrl="~/Login.aspx" />
                </div>
            </div>
        </div>
        <!-- Hero Section End -->

        <!-- Info Section Start -->
        <div class="info-section">
            <div class="info-content">
                <h2>Pourquoi FriendBook ?</h2>
                <p>
                    FriendBook te permet de rencontrer des personnes qui partagent tes passions et tes valeurs.
                    Inscription rapide, messagerie sécurisée et profils vérifiés pour des rencontres en toute confiance.
                </p>
                <div class="features-list">
                    <div class="feature-item">
                        <i class="fas fa-shield-alt"></i>
                        <p>Sécurisé et vérifié</p>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-comments"></i>
                        <p>Messagerie privée</p>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-heart"></i>
                        <p>Connexions authentiques</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Info Section End -->

        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-light footer py-5">
            <div class="container text-center py-5">
                <a href="index.html">
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

        <!-- Back to Top -->
        <a href="#" class="btn btn-outline-primary border-2 btn-lg-square back-to-top" style="position: fixed; display: none; right: 45px; bottom: 45px; z-index: 99;">
            <i class="bi bi-arrow-up"></i>
        </a>
    </form>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Back to top button
        $(window).scroll(function () {
            if ($(this).scrollTop() > 300) {
                $('.back-to-top').fadeIn('slow');
            } else {
                $('.back-to-top').fadeOut('slow');
            }
        });
        $('.back-to-top').click(function () {
            $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
            return false;
        });
    </script>
</body>
</html>