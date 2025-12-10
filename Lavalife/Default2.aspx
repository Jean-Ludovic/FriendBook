<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Default2.aspx.cs"
    Inherits="Lavalife.Default2" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FriendBook - Meet Fun Singles</title>
    <meta charset="utf-8" />
    <style type="text/css">
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f5f5f5;
        }

        .hero {
            background: #d93025; 
            color: white;
            padding: 60px 20px;
            text-align: center;
        }

        .hero h1 {
            font-size: 42px;
            margin-bottom: 10px;
        }

        .hero p {
            font-size: 18px;
            margin-bottom: 25px;
        }

        .btn-main {
            padding: 12px 30px;
            margin: 5px;
            border: none;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
        }

        .btn-signup {
            background-color: white;
            color: #d93025;
            font-weight: bold;
        }

        .btn-login {
            background-color: #222;
            color: white;
            font-weight: bold;
        }

        .content {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px;
            text-align: center;
        }

        .footer {
            margin-top: 40px;
            padding: 20px;
            text-align: center;
            font-size: 12px;
            color: #999;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="hero">
            <h1>FriendBook</h1>
            <p>Meet new people, create connections and have fun – safely and easily.</p>

                <asp:Button ID="btnGoToSignUp" runat="server" Text="SIGN UP"
                    CssClass="btn-main btn-signup"
                    PostBackUrl="~/Inscription.aspx" />

                <asp:Button ID="btnGoToLogin" runat="server" Text="LOGIN"
                    CssClass="btn-main btn-login"
    PostBackUrl="~/Login.aspx" />

        </div>

        <div class="content">
            <h2>Make dating fun again!</h2>
            <p>
                FriendBook is a social networking and dating web site where members can find
                friends, relationships or simply meet new people that share common interests.
            </p>
            <p>
                Quick sign up process – under 10 minutes! Create your profile, add your photo
                and start connecting today.
            </p>
        </div>

        <div class="footer">
            © 2025 FriendBook – School Project inspired by Lavalife.com
        </div>
    </form>
</body>
</html>