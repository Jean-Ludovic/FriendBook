<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Inscription.aspx.cs"
    Inherits="Lavalife.Inscription" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FriendBook - Sign Up</title>
    <meta charset="utf-8" />

    <style type="text/css">
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 600px;
            margin: 40px auto;
            background-color: white;
            padding: 30px;
            border-radius: 6px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: #d93025;
        }

        .form-row {
            margin-bottom: 12px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 3px;
        }

        .textbox, .dropdown {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        .btn-submit {
            background-color: #d93025;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        .validation {
            color: red;
            font-size: 11px;
        }

        .message {
            margin-top: 15px;
            font-weight: bold;
            text-align: center;
        }

        .back-link {
            margin-top: 15px;
            text-align: center;
        }

        a {
            color: #d93025;
            text-decoration: none;
        }

        /* ===== Overlay Lottie ===== */
        #successOverlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.6);
            display: none;      /* caché par défaut */
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }

        #successModal {
            background: #fff;
            border-radius: 10px;
            padding: 20px 30px;
            text-align: center;
            max-width: 400px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Create Your Profile</h1>

            <div class="form-row">
                <label for="txtFirstName">First Name</label>
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="textbox" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                    ControlToValidate="txtFirstName" CssClass="validation"
                    ErrorMessage="First name is required." Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="txtLastName">Last Name</label>
                <asp:TextBox ID="txtLastName" runat="server" CssClass="textbox" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                    ControlToValidate="txtLastName" CssClass="validation"
                    ErrorMessage="Last name is required." Display="Dynamic" />
            </div>

            <div class="form-row">
                <label>Date of Birth</label>
                <asp:TextBox ID="txtBirthDate" runat="server" CssClass="textbox" Placeholder="YYYY-MM-DD" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                    ControlToValidate="txtBirthDate" CssClass="validation"
                    ErrorMessage="Birth date is required." Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="ddlGender">Gender</label>
                <asp:DropDownList ID="ddlGender" runat="server" CssClass="dropdown">
                    <asp:ListItem Text="-- Select --" Value="" />
                    <asp:ListItem Text="Female" Value="Female" />
                    <asp:ListItem Text="Male" Value="Male" />
                    <asp:ListItem Text="Other" Value="Other" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                    ControlToValidate="ddlGender" InitialValue="" CssClass="validation"
                    ErrorMessage="Gender is required." Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="txtEmail">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                    ControlToValidate="txtEmail" CssClass="validation"
                    ErrorMessage="Email is required." Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="textbox" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                    ControlToValidate="txtPassword" CssClass="validation"
                    ErrorMessage="Password is required." Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="ddlEthnicity">Ethnic Group</label>
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
                <label for="ddlReason">Reason</label>
                <asp:DropDownList ID="ddlReason" runat="server" CssClass="dropdown">
                    <asp:ListItem Text="-- Select --" Value="" />
                    <asp:ListItem Text="Love" Value="Love" />
                    <asp:ListItem Text="Friendship" Value="Friendship" />
                    <asp:ListItem Text="Networking" Value="Networking" />
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

        <!-- Overlay Lottie -->
        <div id="successOverlay">
            <div id="successModal">
                <div id="lottieContainer" style="width:250px;height:250px;margin:0 auto;"></div>
                <p style="margin-top:10px;font-weight:bold;color:#e74c3c;">
                    Profile created successfully!<br />Redirecting to login...
                </p>
            </div>
        </div>
    </form>

    <!-- CDN Lottie -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bodymovin/5.12.2/lottie.min.js"></script>

    <script type="text/javascript">
        function showSuccessAndRedirect() {
            // 🔥 TEST : si tu ne vois pas CETTE ALERT → la fonction n’est jamais appelée
            alert('JS OK : showSuccessAndRedirect() appelée !');

            // 2) Afficher l’overlay
            var overlay = document.getElementById('successOverlay');
            overlay.style.display = 'flex';

            // 3) Lancer l’animation
            var anim = lottie.loadAnimation({
                container: document.getElementById('lottieContainer'),
                renderer: 'svg',
                loop: false,
                autoplay: true,
                // ⚠️ adapte EXACTEMENT au nom de ton fichier
                path: '<%= ResolveUrl("~/Lottie/Love_is_blind.json") %>'
            });

            // 4) Quand l’animation est terminée → attendre 1s puis redirection
            anim.addEventListener('complete', function () {
                setTimeout(function () {
                    window.location.href = '<%= ResolveUrl("~/Login.aspx") %>';
                }, 1000);
            });
        }
    </script>
</body>
</html>
