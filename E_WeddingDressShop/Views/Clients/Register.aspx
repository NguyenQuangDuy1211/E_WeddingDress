<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="E_WeddingDressShop.Views.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng Ký</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.1/css/bootstrap.min.css" integrity="sha512-Ez0cGzNzHR1tYAv56860NLspgUGuQw16GiOOp/I2LuTmpSK9xDXlgJz3XN4cnpXWDmkNBKXR/VDMTCnAaEooxA==" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
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
            display: block;
            width: 100%;
            height: 70%;
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('../../Template/image/titleAD.png') no-repeat center;
            background-size: cover;
            display: flex;
            justify-content: center;
        }

        /* Wrapper chiếm toàn màn hình */
        .wrapper-register {
            position: relative;
            width: 600px;
            display: flex;
            background-color: #fff;
            padding: 20px;
            margin: 80px 0;
            overflow: hidden;
            transform: translateY(100%); /* Ban đầu trượt ngoài màn hình bên phải */
            animation: slideInFromBottom 1.5s ease-in-out forwards 0.1s; /* Hiệu ứng trượt từ phải */
        }
    
        /* Ảnh: Hiệu ứng từ trái sang */
        .wrapper-register img {
            width: 600px;
            object-fit: cover;
            position: absolute;
            top: 150px;
            left: 0;
        }

        /* Form đăng nhập */
        .register-container {
            width: 100%;
            z-index: 2;
            padding: 50px 20px;
        }

        /* Tiêu đề */
        .register-container .title {
            display: block;
            width: 100%;
            text-align: center;
            color: #ffb648;
            font-size: 22px;
            font-weight: 500;
            font-family: 'Housttely';
            letter-spacing: 2px;
            margin-bottom: 40px;
        }

        /* Label */
        .register-container label {
            color: #ffb648;
            display: block;
            margin-top: 10px;
            font-size: 18px;
            font-weight: 500;
            font-family: 'Housttely';
        }

        .register-container .form-control {
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

        .register-container .form-control::placeholder {
            font-family: 'Housttely';
        }

        #btnRegister, #btnLogin {
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

        #btnRegister:hover,
        #btnLogin:hover {
            color: #fff;
            background-color: #ffb648;
            box-shadow: 0 0 10px #ffb648;
            border: 2px solid #ffb64852;
            letter-spacing: 1px;
        }

        /* Hiệu ứng trượt từ phải */
        @keyframes slideInFromBottom {
            0% {
                transform: translateY(100%);
                opacity: 0.5;
            }
            100% {
                transform: translateY(0);
                opacity: 1;
            }
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="wrapper-register">
            <img src="../../Template/image/main-img.png" />
            <div class="register-container">
                <span class="title">Đăng Ký Tài Khoản</span>
                <label for="txtFullName">Họ và Tên:</label><br />
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="nhập họ và tên của bạn" /><br />

                <label for="txtEmail">Email:</label><br />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="nhập email của bạn" /><br />

                <label for="txtPassword">Mật khẩu:</label><br />
                <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" CssClass="form-control" placeholder="nhập mật khẩu của bạn" /><br />

                <label for="txtRePassword">Nhập lại mật khẩu:</label><br />
                <asp:TextBox ID="txtRePassword" TextMode="Password" runat="server" CssClass="form-control" placeholder="nhập lại mật khẩu của bạn" /><br />

                <label for="txtNumberPhone">Số điện thoại:</label><br />
                <asp:TextBox ID="txtNumberPhone" runat="server" CssClass="form-control" placeholder="nhập số điện thoại của bạn" /><br />

                <label for="txtAddress">Địa chỉ:</label><br />
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="nhập địa chỉ của bạn" /><br />

                <div class="d-flex gap-3">
                    <asp:Button ID="btnLogin" runat="server" class="btnControlUpdate" Text="Đăng nhập" PostBackUrl="~/Views/Clients/Login.aspx" />
                    <asp:Button ID="btnRegister" Text="Đăng Ký" runat="server" CssClass="btn btn-primary" OnClick="btnRegister_Click" />
                </div>
                <asp:Label runat="server" ID="lblErrorMessage" CssClass="error-message" Visible="false"></asp:Label>
            </div>
        </div>
    </form>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.1/js/bootstrap.min.js" integrity="sha512-EKWWs1ZcA2ZY9lbLISPz8aGR2+L7JVYqBAYTq5AXgBkSjRSuQEGqWx8R1zAX16KdXPaCjOCaKE8MCpU0wcHlHA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.5.7/jquery.fancybox.min.js" integrity="sha512-uURl+ZXMBrF4AwGaWmEetzrd+J5/8NRkWAvJx5sbPSSuOb0bZLqf+tOzniObO00BjHa/dD7gub9oCGMLPQHtQA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js" integrity="sha512-HGOnQO9+SP1V92SrtZfjqxxtLmVzqZpjFFekvzZVWoiASSQgSr4cw9Kqd2+l8Llp4Gm0G8GIFJ4ddwZilcdb8A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
</body>
</html>
