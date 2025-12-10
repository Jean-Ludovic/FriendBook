<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FriendBook - Login</title>
    <meta charset="utf-8" />

    <style type="text/css">
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 400px;
            margin: 60px auto;
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

        .textbox {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        .btn-login {
            background-color: #d93025;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
            width: 100%;
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
    </style>

    <script runat="server">
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();

                // Simulation : plus tard on vérifiera avec la BD
                if (email == "test@friendbook.com" && password == "1234")
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Login successful (simulation).";
                }
                else
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Invalid email or password (simulation).";
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Login</h1>

            <div class="form-row">
                <label for="txtEmail">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                    ControlToValidate="txtEmail" CssClass="validation"
                    ErrorMessage="Email is required." Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="textbox" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                    ControlToValidate="txtPassword" CssClass="validation"
                    ErrorMessage="Password is required." Display="Dynamic" />
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="LOGIN"
                CssClass="btn-login" OnClick="btnLogin_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="message" />

            <div class="back-link">
                <a href="Default.aspx">← Back to Home</a>
            </div>
        </div>
    </form>
</body>
</html>S