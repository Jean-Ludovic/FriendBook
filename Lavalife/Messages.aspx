<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Messages.aspx.cs"
    Inherits="Lavalife.Messages" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <title>FriendBook - Messagerie</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@300;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet" />

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="./Poseify-1.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="./Poseify-1.0.0/css/style.css" rel="stylesheet" />

    <style type="text/css">
        body { margin: 0; font-family: 'Work Sans', sans-serif; background-color: #0a0a0a; overflow: hidden; }
        .top-header { position: fixed; top: 0; left: 0; right: 0; height: 70px; background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%); border-bottom: 2px solid rgba(255, 20, 147, 0.3); display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; box-shadow: 0 2px 20px rgba(255, 20, 147, 0.2); }
        .logo { display: flex; align-items: center; gap: 10px; color: var(--bs-primary); font-size: 1.8rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; }
        .header-user { display: flex; align-items: center; gap: 20px; }
        .user-info { display: flex; align-items: center; gap: 12px; padding: 8px 20px; background: rgba(255, 20, 147, 0.1); border-radius: 30px; border: 1px solid rgba(255, 20, 147, 0.3); }
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; background: linear-gradient(135deg, var(--bs-primary) 0%, #ff6b9d 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: 700; font-size: 1.1rem; }
        .user-name { color: var(--bs-white); font-weight: 600; font-size: 0.95rem; }
        .btn-logout { padding: 10px 25px; background-color: transparent; border: 2px solid var(--bs-primary); color: var(--bs-primary); border-radius: 30px; cursor: pointer; font-weight: 600; text-transform: uppercase; font-size: 0.85rem; letter-spacing: 1px; transition: all 0.3s ease; text-decoration: none; display: inline-block; }
        .btn-logout:hover { background-color: var(--bs-primary); color: var(--bs-white); transform: translateY(-2px); box-shadow: 0 5px 15px rgba(255, 20, 147, 0.4); }
        .dashboard-container { display: flex; height: calc(100vh - 70px); margin-top: 70px; }
        .sidebar { width: 280px; background: linear-gradient(180deg, #1a1a1a 0%, #0a0a0a 100%); border-right: 2px solid rgba(255, 20, 147, 0.2); display: flex; flex-direction: column; }
        .sidebar-nav { padding: 20px 0; }
        .nav-item { padding: 15px 25px; color: rgba(255, 255, 255, 0.7); cursor: pointer; transition: all 0.3s ease; display: flex; align-items: center; gap: 15px; font-weight: 600; font-size: 0.95rem; border-left: 3px solid transparent; }
        .nav-item:hover { background: rgba(255, 20, 147, 0.1); color: var(--bs-white); border-left-color: var(--bs-primary); }
        .nav-item.active { background: rgba(255, 20, 147, 0.15); color: var(--bs-primary); border-left-color: var(--bs-primary); }
        .nav-item i { font-size: 1.2rem; width: 25px; }
        .main-content { flex: 1; display: flex; flex-direction: column; background: #0a0a0a; }
        .content-header { padding: 25px 30px; background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%); border-bottom: 2px solid rgba(255, 20, 147, 0.2); }
        .content-title { color: var(--bs-white); font-size: 1.8rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 15px; }
        .search-form { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-bottom: 20px; }
        .form-group { display: flex; flex-direction: column; }
        .form-group label { color: rgba(255, 255, 255, 0.8); font-size: 0.85rem; font-weight: 600; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.5px; }
        .form-control, .form-select { padding: 10px 15px; background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 8px; color: var(--bs-white); font-size: 0.9rem; transition: all 0.3s ease; }
        .form-control:focus, .form-select:focus { outline: none; border-color: var(--bs-primary); background: rgba(255, 255, 255, 0.08); box-shadow: 0 0 15px rgba(255, 20, 147, 0.2); }
        .form-select option { background: #1a1a1a; color: var(--bs-white); }
        .btn-search { padding: 12px 40px; background: linear-gradient(135deg, var(--bs-primary) 0%, #ff6b9d 100%); border: none; border-radius: 30px; color: white; font-weight: 600; text-transform: uppercase; cursor: pointer; transition: all 0.3s ease; font-size: 0.95rem; letter-spacing: 1px; }
        .btn-search:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(255, 20, 147, 0.4); }
        .results-container { flex: 1; overflow-y: auto; padding: 30px; }
        .results-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; }
        .member-card { background: linear-gradient(135deg, rgba(26, 26, 26, 0.9) 0%, rgba(10, 10, 10, 0.9) 100%); border: 2px solid rgba(255, 255, 255, 0.05); border-radius: 15px; overflow: hidden; transition: all 0.4s ease; cursor: pointer; }
        .member-card:hover { transform: translateY(-5px); border-color: var(--bs-primary); box-shadow: 0 10px 30px rgba(255, 20, 147, 0.3); }
        .member-image { width: 100%; height: 250px; background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%); display: flex; align-items: center; justify-content: center; font-size: 4rem; color: var(--bs-primary); position: relative; overflow: hidden; }
        .member-image::after { content: ''; position: absolute; top: 0; left: 0; right: 0; bottom: 0; background: linear-gradient(180deg, transparent 0%, rgba(0, 0, 0, 0.7) 100%); }
        .member-info { padding: 20px; }
        .member-name { color: var(--bs-white); font-size: 1.3rem; font-weight: 700; margin-bottom: 10px; }
        .member-details { color: rgba(255, 255, 255, 0.7); font-size: 0.85rem; margin-bottom: 5px; display: flex; align-items: center; gap: 8px; }
        .member-details i { color: var(--bs-primary); width: 16px; }
        .member-actions { display: flex; gap: 10px; margin-top: 15px; }
        .btn-message { flex: 1; padding: 10px; background: var(--bs-primary); border: none; border-radius: 8px; color: white; font-weight: 600; cursor: pointer; transition: all 0.3s ease; font-size: 0.85rem; }
        .btn-message:hover { background: #ff6b9d; transform: translateY(-2px); }
        .btn-profile { flex: 1; padding: 10px; background: transparent; border: 2px solid var(--bs-primary); border-radius: 8px; color: var(--bs-primary); font-weight: 600; cursor: pointer; transition: all 0.3s ease; font-size: 0.85rem; }
        .btn-profile:hover { background: rgba(255, 20, 147, 0.1); }
        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-track { background: #0a0a0a; }
        ::-webkit-scrollbar-thumb { background: rgba(255, 20, 147, 0.3); border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: rgba(255, 20, 147, 0.5); }
        @media (max-width: 768px) {
            .sidebar { width: 100%; border-right: none; border-bottom: 2px solid rgba(255, 20, 147, 0.2); }
            .sidebar-nav { display: flex; justify-content: space-around; padding: 10px 0; }
            .results-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="top-header">
            <div class="logo">
                <i class="fa-regular fa-face-smile"></i>
                FriendBook
            </div>
            <div class="header-user">
                <div class="user-info">
                    <div class="user-avatar">
                        <asp:Label ID="lblUserInitial" runat="server" Text="U" />
                    </div>
                    <div class="user-name">
                        <asp:Label ID="lblWelcome" runat="server" Text="Utilisateur" />
                    </div>
                </div>
                <a href="Logout.aspx" class="btn-logout">
                    <i class="fas fa-sign-out-alt me-2"></i>Déconnexion
                </a>
            </div>
        </div>

        <div class="dashboard-container">
            <div class="sidebar">
                <div class="sidebar-nav">
                    <div class="nav-item active">
                        <i class="fas fa-search"></i>
                        <span>Recherche</span>
                    </div>
                    <div class="nav-item">
                        <i class="fas fa-comments"></i>
                        <span>Messages</span>
                    </div>
                    <div class="nav-item">
                        <i class="fas fa-heart"></i>
                        <span>Favoris</span>
                    </div>
                    <div class="nav-item">
                        <i class="fas fa-user"></i>
                        <span>Mon Profil</span>
                    </div>
                </div>
            </div>

            <div class="main-content">
                <div class="content-header">
                    <h1 class="content-title">
                        <i class="fas fa-users me-3"></i>Rechercher des membres
                    </h1>
                    
                    <div class="search-form">
                        <div class="form-group">
                            <label>Genre</label>
                            <select class="form-select">
                                <option value="">Tous</option>
                                <option value="Female">Femme</option>
                                <option value="Male">Homme</option>
                                <option value="Other">Autre</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Âge (min)</label>
                            <input type="number" class="form-control" placeholder="18" min="18" max="100" />
                        </div>
                        <div class="form-group">
                            <label>Âge (max)</label>
                            <input type="number" class="form-control" placeholder="99" min="18" max="100" />
                        </div>
                        <div class="form-group">
                            <label>Groupe ethnique</label>
                            <select class="form-select">
                                <option value="">Tous</option>
                                <option value="African">Africaine</option>
                                <option value="European">Européenne</option>
                                <option value="Asian">Asiatique</option>
                                <option value="Latin">Latino</option>
                                <option value="Other">Autre</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Raison</label>
                            <select class="form-select">
                                <option value="">Tous</option>
                                <option value="Love">Amour</option>
                                <option value="Friendship">Amitié</option>
                                <option value="Networking">Réseau pro</option>
                                <option value="Other">Autre</option>
                            </select>
                        </div>
                        <div class="form-group" style="display: flex; align-items: flex-end;">
                            <button type="button" class="btn-search" style="width: 100%;">
                                <i class="fas fa-search me-2"></i>Rechercher
                            </button>
                        </div>
                    </div>
                </div>

                <div class="results-container">
                    <div class="results-grid">
                        <div class="member-card">
                            <div class="member-image">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="member-info">
                                <h3 class="member-name">Sophie Martin</h3>
                                <div class="member-details">
                                    <i class="fas fa-venus"></i>
                                    <span>Femme, 28 ans</span>
                                </div>
                                <div class="member-details">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>Montréal, QC</span>
                                </div>
                                <div class="member-details">
                                    <i class="fas fa-heart"></i>
                                    <span>Amour</span>
                                </div>
                                <div class="member-actions">
                                    <button class="btn-message">
                                        <i class="fas fa-paper-plane me-2"></i>Message
                                    </button>
                                    <button class="btn-profile">
                                        <i class="fas fa-user me-2"></i>Profil
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="member-card">
                            <div class="member-image">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="member-info">
                                <h3 class="member-name">Marc Dubois</h3>
                                <div class="member-details">
                                    <i class="fas fa-mars"></i>
                                    <span>Homme, 32 ans</span>
                                </div>
                                <div class="member-details">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>Québec, QC</span>
                                </div>
                                <div class="member-details">
                                    <i class="fas fa-users"></i>
                                    <span>Amitié</span>
                                </div>
                                <div class="member-actions">
                                    <button class="btn-message">
                                        <i class="fas fa-paper-plane me-2"></i>Message
                                    </button>
                                    <button class="btn-profile">
                                        <i class="fas fa-user me-2"></i>Profil
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="member-card">
                            <div class="member-image">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="member-info">
                                <h3 class="member-name">Julie Leroy</h3>
                                <div class="member-details">
                                    <i class="fas fa-venus"></i>
                                    <span>Femme, 25 ans</span>
                                </div>
                                <div class="member-details">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>Montréal, QC</span>
                                </div>
                                <div class="member-details">
                                    <i class="fas fa-briefcase"></i>
                                    <span>Réseau professionnel</span>
                                </div>
                                <div class="member-actions">
                                    <button class="btn-message">
                                        <i class="fas fa-paper-plane me-2"></i>Message
                                    </button>
                                    <button class="btn-profile">
                                        <i class="fas fa-user me-2"></i>Profil
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="member-card">
                            <div class="member-image">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="member-info">
                                <h3 class="member-name">Thomas Gagnon</h3>
                                <div class="member-details">
                                    <i class="fas fa-mars"></i>
                                    <span>Homme, 29 ans</span>
                                </div>
                                <div class="member-details">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>Laval, QC</span>
                                </div>
                                <div class="member-details">
                                    <i class="fas fa-heart"></i>
                                    <span>Amour</span>
                                </div>
                                <div class="member-actions">
                                    <button class="btn-message">
                                        <i class="fas fa-paper-plane me-2"></i>Message
                                    </button>
                                    <button class="btn-profile">
                                        <i class="fas fa-user me-2"></i>Profil
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>