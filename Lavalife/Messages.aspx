<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Messages.aspx.cs"
    Inherits="Lavalife.Messages" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <title>FriendBook - Messagerie</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@300;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet" />

    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />

    <!-- Poseify -->
    <link href="./Poseify-1.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="./Poseify-1.0.0/css/style.css" rel="stylesheet" />

    <style>
        body { margin: 0; font-family: 'Work Sans', sans-serif; background-color: #0a0a0a; overflow: hidden; }

        .top-header {
            position: fixed; top: 0; left: 0; right: 0; height: 70px;
            background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
            border-bottom: 2px solid rgba(255, 20, 147, 0.3);
            display: flex; align-items: center; justify-content: space-between;
            padding: 0 30px; z-index: 1000;
            box-shadow: 0 2px 20px rgba(255, 20, 147, 0.2);
        }

        .logo { display:flex; align-items:center; gap:10px; color: var(--bs-primary); font-size:1.8rem; font-weight:700; text-transform:uppercase; letter-spacing:2px; }

        .header-user { display:flex; align-items:center; gap:20px; }
        .user-info {
            display:flex; align-items:center; gap:12px;
            padding:8px 20px;
            background: rgba(255, 20, 147, 0.1);
            border-radius:30px;
            border:1px solid rgba(255, 20, 147, 0.3);
        }
        .user-avatar {
            width:40px; height:40px; border-radius:50%;
            background: linear-gradient(135deg, var(--bs-primary) 0%, #ff6b9d 100%);
            display:flex; align-items:center; justify-content:center;
            color:white; font-weight:700; font-size:1.1rem;
        }
        .user-name { color: var(--bs-white); font-weight:600; font-size:.95rem; line-height:1.05; }
        .user-email { color: rgba(255,255,255,.7); font-size:.78rem; margin-top:2px; max-width:220px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }

        .btn-logout {
            padding:10px 25px; background-color:transparent;
            border:2px solid var(--bs-primary); color: var(--bs-primary);
            border-radius:30px; cursor:pointer; font-weight:600;
            text-transform:uppercase; font-size:.85rem; letter-spacing:1px;
            transition: all .3s ease; text-decoration:none; display:inline-block;
        }
        .btn-logout:hover { background-color: var(--bs-primary); color: var(--bs-white); transform: translateY(-2px); box-shadow: 0 5px 15px rgba(255, 20, 147, 0.4); }

        .dashboard-container { display:flex; height: calc(100vh - 70px); margin-top:70px; }

        .sidebar {
            width:280px;
            background: linear-gradient(180deg, #1a1a1a 0%, #0a0a0a 100%);
            border-right:2px solid rgba(255, 20, 147, 0.2);
            display:flex; flex-direction:column;
        }
        .sidebar-nav { padding:20px 0; }
        .nav-item {
            padding:15px 25px;
            color: rgba(255,255,255,.7);
            cursor:pointer; transition: all .3s ease;
            display:flex; align-items:center; gap:15px;
            font-weight:600; font-size:.95rem;
            border-left: 3px solid transparent;
            user-select:none;
        }
        .nav-item:hover { background: rgba(255,20,147,.1); color: var(--bs-white); border-left-color: var(--bs-primary); }
        .nav-item.active { background: rgba(255,20,147,.15); color: var(--bs-primary); border-left-color: var(--bs-primary); }
        .nav-item i { font-size:1.2rem; width:25px; }

        .main-content { flex:1; display:flex; flex-direction:column; background:#0a0a0a; }

        .content-header {
            padding:25px 30px;
            background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
            border-bottom:2px solid rgba(255, 20, 147, 0.2);
        }
        .content-title { color: var(--bs-white); font-size:1.8rem; font-weight:700; text-transform:uppercase; letter-spacing:1px; margin-bottom:15px; }

        .panel { display:none; height:100%; }
        .panel.active { display:flex; flex-direction:column; height:100%; }

        .search-form {
            display:grid;
            grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
            gap:15px;
            margin-bottom: 12px;
        }

        .form-group { display:flex; flex-direction:column; }
        .form-group label { color: rgba(255,255,255,.8); font-size:.85rem; font-weight:600; margin-bottom:6px; text-transform:uppercase; letter-spacing:.5px; }

        /* ASP.NET controls will receive these classes */
        .form-control, .form-select {
            padding:10px 15px;
            background: rgba(255,255,255,.05);
            border: 1px solid rgba(255,255,255,.1);
            border-radius: 8px;
            color: var(--bs-white);
            font-size:.9rem;
            transition: all .3s ease;
        }
        .form-control:focus, .form-select:focus {
            outline:none; border-color: var(--bs-primary);
            background: rgba(255,255,255,.08);
            box-shadow: 0 0 15px rgba(255, 20, 147, 0.2);
        }
        .form-select option { background:#1a1a1a; color: var(--bs-white); }

        .btn-search {
            padding:12px 40px;
            background: linear-gradient(135deg, var(--bs-primary) 0%, #ff6b9d 100%);
            border:none; border-radius:30px;
            color:white; font-weight:600;
            text-transform:uppercase; cursor:pointer;
            transition: all .3s ease;
            font-size:.95rem; letter-spacing:1px;
            width:100%;
        }
        .btn-search:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(255, 20, 147, 0.4); }

        .notice { color: rgba(255,255,255,.78); font-size:.95rem; margin-top:8px; }
        .notice b, .notice strong { color: var(--bs-primary); }

        .results-container { flex:1; overflow-y:auto; padding:30px; }
        .results-grid { display:grid; grid-template-columns: repeat(auto-fill, minmax(280px,1fr)); gap:25px; }

        .member-card {
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.9) 0%, rgba(10, 10, 10, 0.9) 100%);
            border: 2px solid rgba(255,255,255,.05);
            border-radius: 15px;
            overflow:hidden;
            transition: all .4s ease;
        }
        .member-card:hover { transform: translateY(-5px); border-color: var(--bs-primary); box-shadow: 0 10px 30px rgba(255,20,147,.3); }

        .member-image {
            width:100%; height: 210px;
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
            display:flex; align-items:center; justify-content:center;
            position:relative; overflow:hidden;
        }
        .member-image::after {
            content:'';
            position:absolute; inset:0;
            background: linear-gradient(180deg, transparent 0%, rgba(0, 0, 0, 0.7) 100%);
        }
        .member-image .initial {
            position:relative; z-index:2;
            width:72px; height:72px; border-radius:50%;
            background: linear-gradient(135deg, var(--bs-primary) 0%, #ff6b9d 100%);
            display:flex; align-items:center; justify-content:center;
            color:white; font-weight:900; font-size:2rem;
            box-shadow: 0 10px 25px rgba(255,20,147,.35);
        }

        .member-info { padding: 20px; }
        .member-name { color: var(--bs-white); font-size:1.3rem; font-weight:700; margin-bottom:10px; }
        .member-details { color: rgba(255,255,255,.7); font-size:.85rem; margin-bottom:6px; display:flex; align-items:center; gap:8px; }
        .member-details i { color: var(--bs-primary); width:16px; }

        .member-actions { display:flex; gap:10px; margin-top:15px; }
        .btn-message {
            flex:1; padding:10px;
            background: var(--bs-primary);
            border:none; border-radius:8px;
            color:white; font-weight:600;
            cursor:pointer; transition: all .3s ease;
            font-size:.85rem;
            text-align:center; text-decoration:none;
            display:inline-block;
        }
        .btn-message:hover { background:#ff6b9d; transform: translateY(-2px); }
        .btn-profile {
            flex:1; padding:10px;
            background:transparent;
            border:2px solid var(--bs-primary);
            border-radius:8px;
            color: var(--bs-primary);
            font-weight:600;
            cursor:pointer; transition: all .3s ease;
            font-size:.85rem;
            text-align:center; text-decoration:none;
            display:inline-block;
        }
        .btn-profile:hover { background: rgba(255,20,147,.1); }

        /* Chat host */
        .chat-host { flex:1; overflow:hidden; border-top:2px solid rgba(255,20,147,.2); }
        .chat-host iframe { width:100%; height:100%; border:none; background:#0a0a0a; }

        @media (max-width: 768px){
            .sidebar { width:100%; border-right:none; border-bottom:2px solid rgba(255,20,147,.2); }
            .sidebar-nav { display:flex; justify-content:space-around; padding:10px 0; }
            .results-grid { grid-template-columns: 1fr; }
            body{ overflow:auto; }
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <!-- HEADER -->
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
                <div>
                    <div class="user-name">
                        <asp:Label ID="lblWelcome" runat="server" Text="Utilisateur" />
                    </div>
                    <div class="user-email">
                        <asp:Label ID="lblUserEmail" runat="server" Text="" />
                    </div>
                </div>
            </div>

            <asp:Button ID="btnLogout" runat="server" Text="Déconnexion"
                CssClass="btn-logout" OnClick="btnLogout_Click" />
        </div>
    </div>

    <div class="dashboard-container">

        <!-- SIDEBAR -->
        <div class="sidebar">
            <div class="sidebar-nav">
                <div class="nav-item active" data-target="panelSearch">
                    <i class="fas fa-search"></i><span>Recherche</span>
                </div>
                <div class="nav-item" data-target="panelChat">
                    <i class="fas fa-comments"></i><span>Messages</span>
                </div>
                <div class="nav-item" data-target="panelFavorites">
                    <i class="fas fa-heart"></i><span>Favoris</span>
                </div>
                <div class="nav-item" data-target="panelProfile">
                    <i class="fas fa-user"></i><span>Mon Profil</span>
                </div>
                <div class="nav-item" data-target="panelSettings">
                    <i class="fas fa-gear"></i><span>Paramètres</span>
                </div>
            </div>
        </div>

        <!-- MAIN -->
        <div class="main-content">

            <!-- PANEL: SEARCH -->
            <div id="panelSearch" class="panel active">
                <div class="content-header">
                    <h1 class="content-title">
                        <i class="fas fa-users me-3"></i>Rechercher des membres
                    </h1>

                    <div class="search-form">

                        <!-- ✅ Nom / prénom -->
                        <div class="form-group">
                            <label>Nom / Prénom</label>
                            <asp:TextBox ID="txtSearchName" runat="server" CssClass="form-control" placeholder="Ex: Sarah, John..." />
                        </div>

                        <!-- ✅ Genre -->
                        <div class="form-group">
                            <label>Genre</label>
                            <asp:DropDownList ID="ddlSearchGender" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Tous" Value="" />
                                <asp:ListItem Text="Femme" Value="Female" />
                                <asp:ListItem Text="Homme" Value="Male" />
                                <asp:ListItem Text="Autre" Value="Other" />
                            </asp:DropDownList>
                        </div>

                        <!-- ✅ Age min -->
                        <div class="form-group">
                            <label>Âge min</label>
                            <asp:TextBox ID="txtAgeMin" runat="server" CssClass="form-control" Text="0" />
                        </div>

                        <!-- ✅ Age max -->
                        <div class="form-group">
                            <label>Âge max</label>
                            <asp:TextBox ID="txtAgeMax" runat="server" CssClass="form-control" Text="999" />
                        </div>

                        <!-- ✅ Ethnicité -->
                        <div class="form-group">
                            <label>Ethnicité</label>
                            <asp:DropDownList ID="ddlSearchEthnicity" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Tous" Value="" />
                                <asp:ListItem Text="African" Value="African" />
                                <asp:ListItem Text="Latin" Value="Latin" />
                                <asp:ListItem Text="Other" Value="Other" />
                            </asp:DropDownList>
                        </div>

                        <!-- ✅ Raison -->
                        <div class="form-group">
                            <label>Raison</label>
                            <asp:DropDownList ID="ddlSearchReason" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Toutes" Value="" />
                                <asp:ListItem Text="Love" Value="Love" />
                                <asp:ListItem Text="Friendship" Value="Friendship" />
                                <asp:ListItem Text="Networking" Value="Networking" />
                            </asp:DropDownList>
                        </div>

                        <!-- ✅ Search button -->
                        <div class="form-group" style="display:flex; align-items:flex-end;">
                            <asp:Button ID="btnSearch" runat="server"
                                Text="Rechercher"
                                CssClass="btn-search"
                                OnClick="btnSearch_Click" />
                        </div>
                    </div>

                    <asp:Label ID="lblNoResults" runat="server" CssClass="notice" Visible="false" />
                    <asp:Label ID="lblDebug" runat="server" CssClass="notice" Visible="false" />
                </div>

                <div class="results-container">
                    <asp:Repeater ID="rptMembers" runat="server">
                        <HeaderTemplate>
                            <div class="results-grid">
                        </HeaderTemplate>

                        <ItemTemplate>
                            <div class="member-card">
                                <div class="member-image">
                                    <div class="initial"><%# GetInitial(Eval("FirstName")) %></div>
                                </div>

                                <div class="member-info">
                                    <h3 class="member-name"><%# Eval("FirstName") %> <%# Eval("LastName") %></h3>

                                    <div class="member-details">
                                        <i class="fas <%# GetGenderIcon(Eval("Gender")) %>"></i>
                                        <span><%# GetGenderText(Eval("Gender")) %>, <%# Eval("Age") %> ans</span>
                                    </div>

                                    <div class="member-details">
                                        <i class="fas fa-earth-africa"></i>
                                        <span><%# Eval("EthnicGroup") %></span>
                                    </div>

                                    <div class="member-details">
                                        <i class="fas <%# GetReasonIcon(Eval("Reason")) %>"></i>
                                        <span><%# GetReasonText(Eval("Reason")) %></span>
                                    </div>

                                    <div class="member-actions">
                                        <a class="btn-message" href="javascript:void(0)"
                                           onclick="openChat(<%# Eval("Id") %>, '<%# (Eval("FirstName") + " " + Eval("LastName")).ToString().Replace("'", "\\'") %>')">
                                            <i class="fas fa-paper-plane me-2"></i>Message
                                        </a>

                                        <a class="btn-profile" href="javascript:void(0)">
                                            <i class="fas fa-user me-2"></i>Profil
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>

                        <FooterTemplate>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- PANEL: CHAT -->
            <div id="panelChat" class="panel">
                <div class="content-header">
                    <h1 class="content-title">
                        <i class="fas fa-comments me-3"></i>Messages
                    </h1>
                    <div class="notice">
                        Clique sur <b>Message</b> dans une carte pour ouvrir la conversation.
                    </div>
                </div>

                <div class="chat-host">
                    <iframe id="chatFrame" src="Chat.aspx" title="Chat"></iframe>
                </div>
            </div>

            <!-- PANEL: FAVORIS -->
            <div id="panelFavorites" class="panel">
                <div class="content-header">
                    <h1 class="content-title"><i class="fas fa-heart me-3"></i>Favoris</h1>
                    <div class="notice">Bientôt disponible.</div>
                </div>
                <div class="results-container">
                    <div class="notice">Aucun favori pour l’instant.</div>
                </div>
            </div>

            <!-- PANEL: PROFILE -->
            <div id="panelProfile" class="panel">
                <div class="content-header">
                    <h1 class="content-title"><i class="fas fa-user me-3"></i>Mon Profil</h1>
                    <div class="notice">
                        Prénom: <b><asp:Label ID="lblProfileFirstName" runat="server" /></b>
                        &nbsp; | &nbsp;
                        Email: <b><asp:Label ID="lblProfileEmail" runat="server" /></b>
                    </div>
                </div>
                <div class="results-container">
                    <div class="notice">Page profil à compléter.</div>
                </div>
            </div>

            <!-- PANEL: SETTINGS -->
            <div id="panelSettings" class="panel">
                <div class="content-header">
                    <h1 class="content-title"><i class="fas fa-gear me-3"></i>Paramètres</h1>
                    <div class="notice">Bientôt disponible.</div>
                </div>
                <div class="results-container">
                    <div class="notice">Paramètres à venir.</div>
                </div>
            </div>

        </div>
    </div>

    <script>
        (function () {
            const items = document.querySelectorAll('.nav-item[data-target]');
            const panels = document.querySelectorAll('.panel');

            function show(targetId) {
                panels.forEach(p => p.classList.toggle('active', p.id === targetId));
                items.forEach(i => i.classList.toggle('active', i.dataset.target === targetId));
            }

            items.forEach(i => i.addEventListener('click', () => show(i.dataset.target)));
            show('panelSearch');
        })();

        function openChat(userId, userName) {
            const btn = document.querySelector('.nav-item[data-target="panelChat"]');
            if (btn) btn.click();

            const frame = document.getElementById('chatFrame');
            if (frame) {
                frame.src = "Chat.aspx?userId=" + encodeURIComponent(userId) +
                    "&userName=" + encodeURIComponent(userName);
            }
        }
    </script>

</form>
</body>
</html>
