<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="Lavalife.Chat" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <title>FriendBook - Messagerie</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@300;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <link href="./Poseify-1.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="./Poseify-1.0.0/css/style.css" rel="stylesheet" />

    <style type="text/css">
        body { margin: 0; font-family: 'Work Sans', sans-serif; background-color: #0a0a0a; overflow: hidden; }
        .top-header { position: fixed; top: 0; left: 0; right: 0; height: 70px; background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%); border-bottom: 2px solid rgba(255, 20, 147, 0.3); display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; box-shadow: 0 2px 20px rgba(255, 20, 147, 0.2); }
        .logo { display: flex; align-items: center; gap: 10px; color: var(--bs-primary); font-size: 1.8rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; text-decoration: none; }
        .chat-container { display: flex; height: calc(100vh - 70px); margin-top: 70px; }
        
        /* Liste des conversations */
        .conversations-sidebar { width: 350px; background: linear-gradient(180deg, #1a1a1a 0%, #0a0a0a 100%); border-right: 2px solid rgba(255, 20, 147, 0.2); display: flex; flex-direction: column; }
        .conversations-header { padding: 20px; border-bottom: 2px solid rgba(255, 20, 147, 0.2); }
        .conversations-title { color: var(--bs-white); font-size: 1.3rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; }
        .conversations-list { flex: 1; overflow-y: auto; padding: 10px; }
        .conversation-item { padding: 15px; background: rgba(255, 255, 255, 0.03); border-radius: 12px; margin-bottom: 10px; cursor: pointer; transition: all 0.3s ease; border: 1px solid rgba(255, 255, 255, 0.05); display: flex; align-items: center; gap: 12px; }
        .conversation-item:hover { background: rgba(255, 20, 147, 0.1); border-color: var(--bs-primary); transform: translateX(5px); }
        .conversation-item.active { background: rgba(255, 20, 147, 0.15); border-color: var(--bs-primary); }
        .conv-avatar { width: 50px; height: 50px; border-radius: 50%; background: linear-gradient(135deg, var(--bs-primary) 0%, #ff6b9d 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: 700; font-size: 1.2rem; flex-shrink: 0; }
        .conv-info { flex: 1; min-width: 0; }
        .conv-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 5px; }
        .conv-name { color: var(--bs-white); font-weight: 600; font-size: 0.95rem; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .conv-time { color: rgba(255, 255, 255, 0.5); font-size: 0.75rem; white-space: nowrap; }
        .conv-preview { color: rgba(255, 255, 255, 0.6); font-size: 0.85rem; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .unread-badge { background: var(--bs-primary); color: white; padding: 2px 8px; border-radius: 10px; font-size: 0.7rem; font-weight: 700; }
        
        /* Zone de chat */
        .chat-main { flex: 1; display: flex; flex-direction: column; background: #0a0a0a; }
        .chat-header { padding: 20px 30px; background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%); border-bottom: 2px solid rgba(255, 20, 147, 0.2); display: flex; align-items: center; justify-content: space-between; }
        .chat-user-info { display: flex; align-items: center; gap: 15px; }
        .chat-avatar { width: 50px; height: 50px; border-radius: 50%; background: linear-gradient(135deg, var(--bs-primary) 0%, #ff6b9d 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: 700; font-size: 1.3rem; }
        .chat-user-details h3 { color: var(--bs-white); font-size: 1.2rem; font-weight: 700; margin: 0; }
        .chat-user-status { color: #4caf50; font-size: 0.8rem; }
        .btn-back { padding: 10px 20px; background: transparent; border: 2px solid var(--bs-primary); color: var(--bs-primary); border-radius: 30px; cursor: pointer; font-weight: 600; text-transform: uppercase; font-size: 0.85rem; transition: all 0.3s ease; text-decoration: none; }
        .btn-back:hover { background: var(--bs-primary); color: white; }
        
        /* Messages */
        .messages-container { flex: 1; overflow-y: auto; padding: 30px; background: linear-gradient(180deg, #0a0a0a 0%, #050505 100%); }
        .message-row { display: flex; margin-bottom: 20px; animation: messageSlideIn 0.3s ease-out; }
        @keyframes messageSlideIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        .message-row.me { justify-content: flex-end; }
        .message-bubble { max-width: 60%; padding: 12px 18px; border-radius: 18px; font-size: 0.95rem; line-height: 1.5; word-wrap: break-word; }
        .message-row:not(.me) .message-bubble { background: rgba(255, 255, 255, 0.08); color: var(--bs-white); border: 1px solid rgba(255, 255, 255, 0.1); }
        .message-row.me .message-bubble { background: linear-gradient(135deg, var(--bs-primary) 0%, #ff6b9d 100%); color: white; }
        .message-meta { font-size: 0.75rem; margin-top: 5px; opacity: 0.7; }
        .no-messages { text-align: center; padding: 60px 20px; color: rgba(255, 255, 255, 0.6); font-size: 1.1rem; }
        
        /* Input */
        .chat-input-container { padding: 20px 30px; background: #1a1a1a; border-top: 2px solid rgba(255, 20, 147, 0.2); display: flex; gap: 15px; align-items: center; }
        .chat-input-container input { flex: 1; padding: 14px 20px; background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 30px; color: var(--bs-white); font-size: 0.95rem; outline: none; transition: all 0.3s ease; }
        .chat-input-container input:focus { border-color: var(--bs-primary); background: rgba(255, 255, 255, 0.08); }
        .btn-send { padding: 14px 30px; background: linear-gradient(135deg, var(--bs-primary) 0%, #ff6b9d 100%); border: none; border-radius: 30px; color: white; font-weight: 600; cursor: pointer; transition: all 0.3s ease; }
        .btn-send:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(255, 20, 147, 0.4); }
        
        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-track { background: #0a0a0a; }
        ::-webkit-scrollbar-thumb { background: rgba(255, 20, 147, 0.3); border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: rgba(255, 20, 147, 0.5); }
        
        @media (max-width: 768px) {
            .conversations-sidebar { width: 100%; position: absolute; z-index: 100; height: calc(100vh - 70px); }
            .conversations-sidebar.hidden { display: none; }
            .chat-main.hidden { display: none; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
        
        <div class="top-header">
            <a href="Messages.aspx" class="logo">
                <i class="fa-regular fa-face-smile"></i>
                FriendBook
            </a>
            <a href="Logout.aspx" class="btn-back">
                <i class="fas fa-sign-out-alt me-2"></i>Déconnexion
            </a>
        </div>

        <div class="chat-container">
            <!-- Liste des conversations -->
            <div class="conversations-sidebar">
                <div class="conversations-header">
                    <h2 class="conversations-title">
                        <i class="fas fa-comments me-2"></i>Messages
                    </h2>
                </div>
                <div class="conversations-list">
                    <asp:Repeater ID="rptConversations" runat="server">
                        <ItemTemplate>
                            <div class="conversation-item" onclick="loadChat(<%# Eval("OtherUserId") %>, '<%# Eval("OtherUserName") %>', '<%# Eval("OtherUserInitial") %>')">
                                <div class="conv-avatar"><%# Eval("OtherUserInitial") %></div>
                                <div class="conv-info">
                                    <div class="conv-header">
                                        <span class="conv-name"><%# Eval("OtherUserName") %></span>
                                        <span class="conv-time"><%# Eval("LastMessageTime") %></span>
                                    </div>
                                    <div class="conv-preview"><%# Eval("LastMessage") %></div>
                                </div>
                                <%# (int)Eval("UnreadCount") > 0 ? "<span class='unread-badge'>" + Eval("UnreadCount") + "</span>" : "" %>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Label ID="lblNoConversations" runat="server" CssClass="no-messages" Visible="false" 
                        Text="Aucune conversation pour le moment.<br/>Envoyez un message depuis la recherche de membres !" />
                </div>
            </div>

            <!-- Zone de chat -->
            <div class="chat-main">
                <div class="chat-header">
                    <div class="chat-user-info">
                        <div class="chat-avatar">
                            <asp:Label ID="lblChatUserInitial" runat="server" Text="?" />
                        </div>
                        <div class="chat-user-details">
                            <h3>
                                <asp:Label ID="lblChatUserName" runat="server" Text="Sélectionnez une conversation" />
                            </h3>
                            <div class="chat-user-status">
                                <i class="fas fa-circle" style="font-size: 0.6rem;"></i> En ligne
                            </div>
                        </div>
                    </div>
                    <a href="Messages.aspx" class="btn-back">
                        <i class="fas fa-arrow-left me-2"></i>Retour
                    </a>
                </div>

                <div class="messages-container" id="messagesContainer">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>

        <!-- ✅ refresh async -->
        <asp:Timer ID="tmrRefresh" runat="server" Interval="5000" OnTick="tmrRefresh_Tick" />

        <asp:Repeater ID="rptMessages" runat="server">
            <ItemTemplate>
                <div class='message-row <%# (int)Eval("SenderId") == GetCurrentUserId() ? "me" : "" %>'>
                    <div class="message-bubble">
                        <%# Eval("MessageText") %>
                        <div class="message-meta">
                            <%# (int)Eval("SenderId") == GetCurrentUserId() ? "Vous" : Eval("SenderName") %> •
                            <%# ((DateTime)Eval("SentDate")).ToString("HH:mm") %>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <asp:Label ID="lblNoMessages" runat="server" CssClass="no-messages" Visible="false"
            Text="Aucun message pour le moment.<br/>Soyez le premier à envoyer un message ! 💬" />
    </ContentTemplate>
</asp:UpdatePanel>

                </div>

                <div class="chat-input-container">
                    <asp:HiddenField ID="hdnReceiverId" runat="server" />
                    <asp:TextBox ID="txtMessage" runat="server" placeholder="Écris ton message..." 
                        onkeypress="return handleEnter(event);" />
                    <asp:Button ID="btnSend" runat="server" Text="Envoyer" CssClass="btn-send" 
                        OnClick="btnSend_Click" />
                </div>
            </div>
        </div>
    </form>

    <script>
        function loadChat(userId, userName, userInitial) {
            __doPostBack('LoadChat', userId + '|' + userName + '|' + userInitial);
        }

        function handleEnter(event) {
            if (event.keyCode === 13) {
                event.preventDefault();
                document.getElementById('<%= btnSend.ClientID %>').click();
                return false;
            }
            return true;
        }

        // Auto-scroll vers le bas
        function scrollToBottom() {
            var container = document.getElementById('messagesContainer');
            if (container) {
                container.scrollTop = container.scrollHeight;
            }
        }

        window.onload = scrollToBottom;
        

    </script>
</body>
</html>