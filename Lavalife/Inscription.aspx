<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Inscription.aspx.cs"
    Inherits="Lavalife.Inscription" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FriendBook - Sign Up</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <style type="text/css">
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            max-width: 600px;
            width: 90%;
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }

        h1 {
            text-align: center;
            color: #667eea;
            margin-bottom: 30px;
            font-size: 28px;
        }

        .form-row {
            margin-bottom: 18px;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            color: #333;
        }

        .textbox, .dropdown {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .textbox:focus, .dropdown:focus {
            outline: none;
            border-color: #667eea;
        }

        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 14px 30px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
            width: 100%;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .validation {
            color: #e74c3c;
            font-size: 12px;
            margin-top: 4px;
            display: block;
        }

        .message {
            margin-top: 20px;
            padding: 12px;
            font-weight: 500;
            text-align: center;
            border-radius: 6px;
        }

        .back-link {
            margin-top: 20px;
            text-align: center;
        }

        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .back-link a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        /* ===== Overlay Animation Lottie ===== */
        #successOverlay {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.85);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        #successModal {
            background: white;
            border-radius: 16px;
            padding: 30px 40px;
            text-align: center;
            max-width: 450px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.5);
            animation: slideUp 0.4s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        #successModal h2 {
            color: #27ae60;
            margin-top: 10px;
            font-size: 24px;
        }

        #successModal p {
            color: #666;
            font-size: 16px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>🎉 Create Your Profile</h1>

            <div class="form-row">
                <label for="txtFirstName">First Name</label>
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="textbox" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                    ControlToValidate="txtFirstName" CssClass="validation"
                    ErrorMessage="⚠️ First name is required." Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="txtLastName">Last Name</label>
                <asp:TextBox ID="txtLastName" runat="server" CssClass="textbox" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                    ControlToValidate="txtLastName" CssClass="validation"
                    ErrorMessage="⚠️ Last name is required." Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="txtBirthDate">Date of Birth</label>
                <asp:TextBox ID="txtBirthDate" runat="server" CssClass="textbox" 
                    Placeholder="YYYY-MM-DD (e.g., 1995-06-15)" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                    ControlToValidate="txtBirthDate" CssClass="validation"
                    ErrorMessage="⚠️ Birth date is required." Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="ddlGender">Gender</label>
                <asp:DropDownList ID="ddlGender" runat="server" CssClass="dropdown">
                    <asp:ListItem Text="-- Select Gender --" Value="" />
                    <asp:ListItem Text="Female" Value="Female" />
                    <asp:ListItem Text="Male" Value="Male" />
                    <asp:ListItem Text="Other" Value="Other" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                    ControlToValidate="ddlGender" InitialValue="" CssClass="validation"
                    ErrorMessage="⚠️ Please select your gender." Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="txtEmail">Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox" 
                    TextMode="Email" Placeholder="your.email@example.com" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                    ControlToValidate="txtEmail" CssClass="validation"
                    ErrorMessage="⚠️ Email is required." Display="Dynamic" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                    ControlToValidate="txtEmail" CssClass="validation"
                    ErrorMessage="⚠️ Invalid email format."
                    ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                    Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                    CssClass="textbox" Placeholder="Minimum 6 characters" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                    ControlToValidate="txtPassword" CssClass="validation"
                    ErrorMessage="⚠️ Password is required." Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="ddlEthnicity">Ethnic Group (Optional)</label>
                <asp:DropDownList ID="ddlEthnicity" runat="server" CssClass="dropdown">
                    <asp:ListItem Text="-- Select --" Value="" />
                    <asp:ListItem Text="African" Value="African" />
                    <asp:ListItem Text="European" Value="European" />
                    <asp:ListItem Text="Asian" Value="Asian" />
                    <asp:ListItem Text="Latin" Value="Latin" />
                    <asp:ListItem Text="Other" Value="Other" />
                </asp:DropDownList>
            </div>

            <div class="form-row">
                <label for="ddlReason">Main Reason for Joining</label>
                <asp:DropDownList ID="ddlReason" runat="server" CssClass="dropdown">
                    <asp:ListItem Text="-- Select --" Value="" />
                    <asp:ListItem Text="Love ❤️" Value="Love" />
                    <asp:ListItem Text="Friendship 🤝" Value="Friendship" />
                    <asp:ListItem Text="Networking 💼" Value="Networking" />
                    <asp:ListItem Text="Other Interests" Value="Other" />
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Create My Account"
                CssClass="btn-submit" OnClick="btnRegister_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="message" />

            <div class="back-link">
                <a href="Default.aspx">← Back to Home</a>
            </div>
        </div>

        <!-- ===== Overlay Lottie Animation ===== -->
        <div id="successOverlay">
            <div id="successModal">
                <!-- Container pour l'animation Lottie -->
                <div id="lottieContainer" style="width:300px; height:300px; margin:0 auto;"></div>
                
                <h2>Account Created! 🎉</h2>
                <p>Redirecting you to the login page...</p>
            </div>
        </div>
    </form>

    <!-- CDN Lottie Player -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bodymovin/5.12.2/lottie.min.js"></script>

    <script type="text/javascript">
        function showSuccessAndRedirect() {
            // 1) Afficher l'overlay immédiatement
            var overlay = document.getElementById('successOverlay');
            overlay.style.display = 'flex';

            // 2) Charger et lancer l'animation Lottie
            var animation = lottie.loadAnimation({
                container: document.getElementById('lottieContainer'),
                renderer: 'svg',
                loop: false,        // Animation joue une seule fois
                autoplay: true,     // Démarre automatiquement
                path: '<%= ResolveUrl("~/Lottie/Love_is_blind.json") %>' // ✅ Chemin corrigé
            });

            // 3) Quand l'animation est terminée → attendre 1 seconde puis rediriger
            animation.addEventListener('complete', function () {
                setTimeout(function () {
                    // Redirection vers Login.aspx
                    window.location.href = '<%= ResolveUrl("~/Login.aspx") %>';
                }, 1000); // Attente de 1 seconde après la fin de l'animation
            });

            // 4) Sécurité: si l'animation ne se charge pas, rediriger après 5 secondes
            setTimeout(function() {
                if (window.location.href.indexOf('Login.aspx') === -1) {
                    window.location.href = '<%= ResolveUrl("~/Login.aspx") %>';
                }
            }, 5000);
        }
    </script>
</body>
</html>