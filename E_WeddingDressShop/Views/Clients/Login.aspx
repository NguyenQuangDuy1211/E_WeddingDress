<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="E_WeddingDressShop.Views.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng nhập</title>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css"/>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@300..700&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap');
        @font-face {
	        font-family: "Housttely";
	        src: url("../../Template/fonts/SVN-HousttelySignature-Regular.eot");
	        src: url("../../Template/fonts/SVN-HousttelySignature-Regular.eot?#iefix") format("embedded-opentype"), 
                url("../../Template/fonts/SVN-HousttelySignature-Regular.woff2") format("woff2"), 
                url("../../Template/fonts/SVN-HousttelySignature-Regular.woff") format("woff"), 
                url("../../Template/fonts/SVN-HousttelySignature-Regular.ttf") format("truetype"), 
                url("../../Template/fonts/SVN-HousttelySignature-Regular.svg#SVN-HousttelySignature-Regular") format("svg");
	        font-weight: normal;
	        font-style: normal;
	        font-display: swap;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            width: 100%;
            height: 100vh;
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('../../Template/image/titleAD.png') no-repeat center;
            background-size: cover;
            overflow: hidden;
        }

        /* Wrapper chiếm toàn màn hình */
        .wrapper-login {
            width: 100%;
            height: 100%; /* Chiều dài full màn hình */
            display: flex;
            background-color: #fff;
            padding: 20px 100px;
            margin-top: 80px;
            overflow: hidden;
            transform: translateX(100%); /* Ban đầu trượt ngoài màn hình bên phải */
            animation: slideInFromRight 1.5s ease-in-out forwards 0.1s; /* Hiệu ứng trượt từ phải */
        }
        
        /* Ảnh: Hiệu ứng từ trái sang */
        .wrapper-login img {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }

        /* Form đăng nhập */
        .login-container {
            width: 100%;
            margin-left: 50px;
        }

        /* Tiêu đề */
        .login-container .title {
            display: block;
            width: 100%;
            text-align: center;
            color: #ffb648;
            font-size: 22px;
            font-weight: 500;
            font-family: 'Housttely';
            letter-spacing: 2px;
        }

        /* Label */
        .login-container label {
            color: #ffb648;
            display: block;
            margin-top: 10px;
            font-size: 18px;
            font-weight: 500;
            font-family: 'Housttely';
        }

        .login-container .form-control {
            width: 100%;
            padding: 5px 10px;
            border: none;
            outline: none;
            border-bottom: 1px solid #ffb648;
            background-color: transparent;
            letter-spacing: 1px;
            font-size: 18px;
            font-family: "Quicksand";
        }

        .login-container .form-control::placeholder {
            font-family: 'Housttely';
        }

        #btnLogin ,#btnRegister {
            background-color: transparent;
            border: 2px solid #ffb648;
            border-radius: 30px;
            font-family: 'Quicksand';
            font-size: 20px;
            margin-top: 30px;
            padding: 8px 0;
            cursor: pointer;
            color: #ffb648;
            width: 100%;
            transition: all 0.3s ease;
        }

        #btnLogin:hover , #btnRegister:hover {
            color: #fff;
            background-color: #ffb648;
            box-shadow: 0 0 10px #ffb648;
            border: 2px solid #ffb64852;
            letter-spacing: 1px;
        }

        /* Hiệu ứng trượt từ phải */
        @keyframes slideInFromRight {
            0% {
                transform: translateX(100%);
                opacity: 0.5;
            }
            100% {
                transform: translateX(0);
                opacity: 1;
            }
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="wrapper-login">
            <img src="../../Template/image/anh1.png" />
            <div class="login-container">
                <span class="title">Đăng Nhập</span>
                <label for="txtEmail">Email</label>
                <asp:TextBox runat="server" ID="txtEmail" class="form-control" CssClass="form-control" TextMode="Email" placeholder="nhập email của bạn" />
                <br />
                <label for="txtPassword">Mật khẩu</label>
                <asp:TextBox runat="server" ID="txtPassword" class="form-control" CssClass="form-control" TextMode="Password" placeholder="nhập mật khẩu của bạn" />
                <br />
                <div style="display: flex; gap: 0 20px;">
                    <asp:Button runat="server" ID="btnLogin" Text="Đăng Nhập" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                    <asp:Button runat="server" ID="btnRegister" Text="Đăng Ký" CssClass="btn btn-primary" PostBackUrl="~/Views/Clients/Register.aspx"/>
                </div>

                <br />
                <asp:Label runat="server" ID="lblErrorMessage" CssClass="error-message" Visible="false"></asp:Label>
            </div>
        </div>
    </form>
</body>
    
</html>

