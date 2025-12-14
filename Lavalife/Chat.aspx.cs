using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Lavalife
{
    public partial class Chat : Page
    {
        private int CurrentUserId
        {
            get
            {
                if (Session["UserId"] != null)
                    return (int)Session["UserId"];
                return 0;
            }
        }

        private string CurrentUserEmail
        {
            get
            {
                if (Session["UserEmail"] != null)
                    return Session["UserEmail"].ToString();
                return string.Empty;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Vérifier si l'utilisateur est connecté
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                // Récupérer l'ID utilisateur depuis l'email
                if (Session["UserId"] == null)
                {
                    Session["UserId"] = GetUserIdFromEmail(CurrentUserEmail);
                }

                LoadConversations();

                // Si on vient de Messages.aspx avec un userId en query string
                if (Request.QueryString["userId"] != null)
                {
                    int userId = int.Parse(Request.QueryString["userId"]);
                    string userName = Request.QueryString["userName"];
                    LoadChatWith(userId, userName);
                }
            }
            else
            {
                // Gérer le postback pour charger un chat
                string eventTarget = Request["__EVENTTARGET"];
                string eventArgument = Request["__EVENTARGUMENT"];

                if (eventTarget == "LoadChat" && !string.IsNullOrEmpty(eventArgument))
                {
                    string[] parts = eventArgument.Split('|');
                    int userId = int.Parse(parts[0]);
                    string userName = parts[1];
                    LoadChatWith(userId, userName);
                }
                else if (eventTarget == "RefreshMessages")
                {
                    if (!string.IsNullOrEmpty(hdnReceiverId.Value))
                    {
                        int receiverId = int.Parse(hdnReceiverId.Value);
                        LoadMessages(receiverId);
                    }
                }
            }
        }

        /// <summary>
        /// Récupérer l'ID utilisateur depuis l'email
        /// </summary>
        private int GetUserIdFromEmail(string email)
        {
            var cs = ConfigurationManager.ConnectionStrings["LavalifeConnectionString"];
            if (cs == null) return 0;

            try
            {
                using (SqlConnection conn = new SqlConnection(cs.ConnectionString))
                {
                    conn.Open();
                    string query = "SELECT Id FROM Users WHERE Email = @Email";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        object result = cmd.ExecuteScalar();
                        return result != null ? (int)result : 0;
                    }
                }
            }
            catch
            {
                return 0;
            }
        }

        /// <summary>
        /// Charger la liste des conversations
        /// </summary>
        private void LoadConversations()
        {
            var cs = ConfigurationManager.ConnectionStrings["LavalifeConnectionString"];
            if (cs == null) return;

            try
            {
                using (SqlConnection conn = new SqlConnection(cs.ConnectionString))
                {
                    conn.Open();

                    string query = @"
                        WITH LastMessages AS (
                            SELECT 
                                CASE 
                                    WHEN SenderId = @CurrentUserId THEN ReceiverId
                                    ELSE SenderId
                                END AS OtherUserId,
                                MessageText AS LastMessage,
                                SentDate AS LastMessageTime,
                                ROW_NUMBER() OVER (
                                    PARTITION BY 
                                        CASE 
                                            WHEN SenderId = @CurrentUserId THEN ReceiverId
                                            ELSE SenderId
                                        END 
                                    ORDER BY SentDate DESC
                                ) AS RowNum
                            FROM Messages
                            WHERE SenderId = @CurrentUserId OR ReceiverId = @CurrentUserId
                        )
                        SELECT 
                            lm.OtherUserId,
                            u.FirstName + ' ' + u.LastName AS OtherUserName,
                            LEFT(u.FirstName, 1) AS OtherUserInitial,
                            lm.LastMessage,
                            CASE 
                                WHEN DATEDIFF(MINUTE, lm.LastMessageTime, GETDATE()) < 60 
                                    THEN CAST(DATEDIFF(MINUTE, lm.LastMessageTime, GETDATE()) AS VARCHAR) + ' min'
                                WHEN DATEDIFF(HOUR, lm.LastMessageTime, GETDATE()) < 24 
                                    THEN CAST(DATEDIFF(HOUR, lm.LastMessageTime, GETDATE()) AS VARCHAR) + ' h'
                                ELSE CONVERT(VARCHAR, lm.LastMessageTime, 103)
                            END AS LastMessageTime,
                            (SELECT COUNT(*) 
                             FROM Messages 
                             WHERE SenderId = lm.OtherUserId 
                               AND ReceiverId = @CurrentUserId 
                               AND IsRead = 0) AS UnreadCount
                        FROM LastMessages lm
                        INNER JOIN Users u ON u.Id = lm.OtherUserId
                        WHERE lm.RowNum = 1
                        ORDER BY lm.LastMessageTime DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CurrentUserId", CurrentUserId);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            DataTable dt = new DataTable();
                            dt.Load(reader);

                            rptConversations.DataSource = dt;
                            rptConversations.DataBind();

                            lblNoConversations.Visible = (dt.Rows.Count == 0);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblNoConversations.Visible = true;
                lblNoConversations.Text = "Erreur : " + ex.Message;
            }
        }

        /// <summary>
        /// Charger une conversation spécifique
        /// </summary>
        private void LoadChatWith(int userId, string userName)
        {
            hdnReceiverId.Value = userId.ToString();
            lblChatUserName.Text = userName;
            lblChatUserInitial.Text = userName.Substring(0, 1).ToUpper();

            LoadMessages(userId);
            MarkMessagesAsRead(userId);
        }

        /// <summary>
        /// Charger les messages d'une conversation
        /// </summary>
        private void LoadMessages(int otherUserId)
        {
            var cs = ConfigurationManager.ConnectionStrings["LavalifeConnectionString"];
            if (cs == null) return;

            try
            {
                using (SqlConnection conn = new SqlConnection(cs.ConnectionString))
                {
                    conn.Open();

                    string query = @"
                        SELECT 
                            m.MessageId,
                            m.SenderId,
                            m.ReceiverId,
                            m.MessageText,
                            m.SentDate,
                            u.FirstName + ' ' + u.LastName AS SenderName
                        FROM Messages m
                        INNER JOIN Users u ON u.Id = m.SenderId
                        WHERE (m.SenderId = @CurrentUserId AND m.ReceiverId = @OtherUserId)
                           OR (m.SenderId = @OtherUserId AND m.ReceiverId = @CurrentUserId)
                        ORDER BY m.SentDate ASC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CurrentUserId", CurrentUserId);
                        cmd.Parameters.AddWithValue("@OtherUserId", otherUserId);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            DataTable dt = new DataTable();
                            dt.Load(reader);

                            rptMessages.DataSource = dt;
                            rptMessages.DataBind();

                            lblNoMessages.Visible = (dt.Rows.Count == 0);
                        }
                    }
                }

                UpdatePanel1.Update();
            }
            catch (Exception ex)
            {
                lblNoMessages.Visible = true;
                lblNoMessages.Text = "Erreur : " + ex.Message;
            }
        }

        /// <summary>
        /// Marquer les messages comme lus
        /// </summary>
        private void MarkMessagesAsRead(int senderId)
        {
            var cs = ConfigurationManager.ConnectionStrings["LavalifeConnectionString"];
            if (cs == null) return;

            try
            {
                using (SqlConnection conn = new SqlConnection(cs.ConnectionString))
                {
                    conn.Open();

                    string query = @"
                        UPDATE Messages 
                        SET IsRead = 1 
                        WHERE SenderId = @SenderId 
                          AND ReceiverId = @ReceiverId 
                          AND IsRead = 0";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@SenderId", senderId);
                        cmd.Parameters.AddWithValue("@ReceiverId", CurrentUserId);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch { }
        }

        /// <summary>
        /// Envoyer un message
        /// </summary>
        protected void btnSend_Click(object sender, EventArgs e)
        {
            string messageText = txtMessage.Text.Trim();
            if (string.IsNullOrEmpty(messageText) || string.IsNullOrEmpty(hdnReceiverId.Value))
                return;

            int receiverId = int.Parse(hdnReceiverId.Value);

            var cs = ConfigurationManager.ConnectionStrings["LavalifeConnectionString"];
            if (cs == null) return;

            try
            {
                using (SqlConnection conn = new SqlConnection(cs.ConnectionString))
                {
                    conn.Open();

                    string query = @"
                        INSERT INTO Messages (SenderId, ReceiverId, MessageText, SentDate, IsRead)
                        VALUES (@SenderId, @ReceiverId, @MessageText, GETDATE(), 0)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@SenderId", CurrentUserId);
                        cmd.Parameters.AddWithValue("@ReceiverId", receiverId);
                        cmd.Parameters.AddWithValue("@MessageText", messageText);

                        cmd.ExecuteNonQuery();
                    }
                }

                // Recharger les messages
                LoadMessages(receiverId);
                LoadConversations();

                // Vider le champ de texte
                txtMessage.Text = string.Empty;

                // Scroll auto vers le bas via JavaScript
                ScriptManager.RegisterStartupScript(this, GetType(), "ScrollDown", "scrollToBottom();", true);
            }
            catch (Exception ex)
            {
                lblNoMessages.Visible = true;
                lblNoMessages.Text = "Erreur lors de l'envoi : " + ex.Message;
            }
        }

        /// <summary>
        /// Méthode helper pour les templates
        /// </summary>
        protected int GetCurrentUserId()
        {
            return CurrentUserId;
        }
        protected void tmrRefresh_Tick(object sender, EventArgs e)
        {
            // Refresh seulement si une conversation est ouverte
            if (!string.IsNullOrEmpty(hdnReceiverId.Value))
            {
                int receiverId;
                if (int.TryParse(hdnReceiverId.Value, out receiverId))
                {
                    LoadMessages(receiverId);
                }
            }
        }

    }
}