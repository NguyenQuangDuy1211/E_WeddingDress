<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateUser.aspx.cs" Inherits="E_WeddingDressShop.Views.Clients.UpdateUser" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chỉnh sửa thông tin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.1/css/bootstrap.min.css" integrity="sha512-Ez0cGzNzHR1tYAv56860NLspgUGuQw16GiOOp/I2LuTmpSK9xDXlgJz3XN4cnpXWDmkNBKXR/VDMTCnAaEooxA==" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@300..700&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap');

        @font-face {
            font-family: "Housttely";
            src: url("../../Template/fonts/SVN-HousttelySignature-Regular.eot");
            src: url("../../Template/fonts/SVN-HousttelySignature-Regular.eot?#iefix") format("embedded-opentype"), url("../../Template/fonts/SVN-HousttelySignature-Regular.woff2") format("woff2"), url("../../Template/fonts/SVN-HousttelySignature-Regular.woff") format("woff"), url("../../Template/fonts/SVN-HousttelySignature-Regular.ttf") format("truetype"), url("../../Template/fonts/SVN-HousttelySignature-Regular.svg#SVN-HousttelySignature-Regular") format("svg");
            font-weight: normal;
            font-style: normal;
            font-display: swap;
        }

        :root {
            --primary-color: #ffb648;
        }
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            margin-top: 80px;
            width: 100%;
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('../../Template/image/titleAD.png') no-repeat center;
            background-size: cover;
        }
        /* Header */
        header {
            position: fixed;
            top: 0;
            width: 100%;
            height: 80px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 40px;
            z-index: 1000;
        }

            header img {
                width: 150px;
                object-fit: cover;
            }

        .menu-header {
            height: 100%;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .category-wedding {
            position: relative;
        }

        .category-wedding-secondary {
            position: absolute;
            top: 100%;
            left: -100px;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 10px 15px;
            display: none;
        }

        .category-wedding:hover .category-wedding-secondary {
            display: flex;
        }

        .category-wedding-secondary div div {
            border-bottom: 1px solid #f5f5f5;
            width: 200px;
            padding: 10px;
            cursor: pointer;
        }

            .category-wedding-secondary div div:hover {
                background-color: #f5f5f5;
            }

        .category-wedding-secondary img {
            width: 100px;
            height: 150px;
            object-fit: cover;
        }

        .category-wedding-secondary span {
            width: 30px;
            height: 30px;
            border: 1px solid var(--primary-color);
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
        }

        .menu-header a {
            color: #333;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        #logoutContainer {
            position: absolute;
            top: 100%;
            right: 0;
            width: 280px;
            background-color: #fff;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            display: none;
            z-index: 100;
            overflow: hidden
        }

            #logoutContainer div {
                width: 100%;
                border: none;
                background: #fff;
                padding: 10px 20px;
                text-align: left;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: flex-start;
            }

                #logoutContainer div:last-child {
                    border-top: 1px solid #ccc;
                }

                #logoutContainer div:hover {
                    background-color: #f5f5f5;
                }

                #logoutContainer div i {
                    width: 25px;
                    text-align: center;
                    margin-right: 5px;
                }

            #logoutContainer input {
                background-color: transparent;
                border: none;
            }

        #nameUser {
            cursor: pointer;
        }

        .content-update {
            background-color: #fff;
            margin: 80px;
            padding: 50px;
            overflow: hidden;
            transform: translateY(30%); /* Ban đầu trượt ngoài màn hình bên phải */
            animation: slideInFromRight 1s ease-in-out forwards 0.1s;
        }

            .content-update .form-control {
                border: none;
            }

                .content-update .form-control span {
                    font-size: 18px;
                    font-weight: 500;
                }

                .content-update .form-control input {
                    border: none;
                    outline: none;
                    width: 100%;
                    border-bottom: 1px solid #ccc;
                }
        /* Hiệu ứng trượt từ phải */
        @keyframes slideInFromRight {
            0% {
                transform: translateY(30%);
                opacity: 0.5;
            }

            100% {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .btnControlUpdate {
            background-color: transparent;
            border: 2px solid #ffb648;
            border-radius: 30px;
            font-family: 'Quicksand';
            font-size: 20px;
            margin-top: 30px;
            padding: 8px 30px;
            cursor: pointer;
            color: #ffb648;
            transition: all 0.3s ease;
        }

            .btnControlUpdate:hover {
                color: #fff;
                background-color: #ffb648;
                box-shadow: 0 0 10px #ffb648;
                border: 2px solid #ffb64852;
                letter-spacing: 1px;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <%--<div class="menu-header">
        <a href="#">ABOUT US</a>
        <a href="#">ALBUMS WEDDING</a>
        <a href="#">COLLECTIONS</a>
        <a href="#">NEW CONCEPT</a>
    </div>--%>
            <a href="./DashBoard.aspx">
                <img src="../../Template/image/logo-header.png" alt="Logo" />
            </a>
            <div class="menu-header">
                <div class="category-wedding h-100 d-flex align-items-center">
                    <a href="#">
                        <div class="h-100 d-flex align-items-center">Dress Wedding +</div>
                    </a>
                    <div class="category-wedding-secondary">
                        <img src="../../Template/image/Váy%20công%20chúa/congchua1.jpg" />
                        <div>
                            <div class="d-flex justify-content-between align-items-center">Tất cả <span>10</span></div>
                            <div class="d-flex justify-content-between align-items-center">Váy công chúa <span>5</span></div>
                            <div class="d-flex justify-content-between align-items-center">Váy đuôi cá <span>5</span></div>
                        </div>
                    </div>
                </div>
                <a id="nameUser" runat="server" class="dropdown-toggle" onclick="toggleLogout(event)">User
                </a>
                <div id="logoutContainer" class="logout-container" style="display: none;">
                    <div class="d-flex align-item-center justify-content-start">
                        <i class="fa-solid fa-user-pen"></i>
                        <asp:Button runat="server" Text="Chỉnh sửa thông tin" PostBackUrl="~/Views/Clients/UpdateUser.aspx" />
                    </div>
                    <div>
                        <a href="Cart.aspx"><i class="fa-solid fa-cart-shopping"></i>Giỏ hàng của tôi</a>
                    </div>
                    <div class="d-flex align-item-center justify-content-start">
                        <i class="fa-solid fa-bag-shopping"></i>
                        <asp:Button runat="server" Text="Đơn hàng của tôi" PostBackUrl="~/Views/Clients/Order.aspx" />
                    </div>
                    <div class="d-flex">
                        <i class="fa-solid fa-clock-rotate-left"></i>
                        <asp:Button runat="server" Text="Lịch sử đặt hàng" PostBackUrl="~/Views/Clients/HistoryBuy.aspx" />
                    </div>
                    <div class="d-flex">
                        <i class="fa-solid fa-arrow-right-from-bracket"></i>
                        <asp:Button ID="logout" runat="server" Text="Đăng xuất" OnClick="logout_Click" />
                    </div>
                </div>
            </div>
        </header>
        <div class="content-update">
            <h2>Chỉnh sửa thông tin</h2>
            <hr />
            <div class="d-flex ">
                <img src="../../Template/image/Váy%20công%20chúa/congchua1.jpg" style="width: 400px; height: 500px; object-fit: cover;" />
                <div style="flex: 1; margin-left: 20px">
                    <div class="form-control">
                        <asp:Label runat="server" Text="Họ tên:" />
                        <asp:TextBox ID="txthoten" runat="server" placeholder="Nhập họ và tên của bạn" />
                    </div>
                    <div class="form-control">
                        <asp:Label runat="server" Text="Email:" />
                        <asp:TextBox ID="txtemail" runat="server" placeholder="Nhập email của bạn" />
                    </div>
                    <div class="form-control">
                        <asp:Label runat="server" Text="Số điện thoại:" />
                        <asp:TextBox ID="txtphonenumber" runat="server" placeholder="Nhập số điện thoại" />
                    </div>
                    <div class="form-control">
                        <asp:Label runat="server" Text="Địa chỉ:" />
                        <asp:TextBox ID="txtdiachi" runat="server" placeholder="Nhập địa chỉ" />
                    </div>
                    <div class="form-control">
                        <asp:Label runat="server" Text="Mật khẩu:" />
                        <asp:TextBox ID="txtmatkhau" runat="server" placeholder="Nhập mật khẩu mới" TextMode="Password" />
                    </div>
                    <div class="form-control">
                        <asp:Label runat="server" Text="Nhập lại mật khẩu:" />
                        <asp:TextBox ID="txtnhaplaimatkhau" runat="server" placeholder="Nhập lại mật khẩu" TextMode="Password" />
                    </div>

                    <div class="d-flex">
                        <asp:Button runat="server" class="btnControlUpdate me-3" Text="Update" CommandName="UpdateUserNe" OnCommand="UpdateUserNe" />
                        <asp:Button runat="server" class="btnControlUpdate" Text="Cancel" PostBackUrl="~/Views/Clients/DashBoard.aspx" />
                    </div>
                </div>
            </div>
            <asp:Label runat="server" ID="lblErrorMessage"></asp:Label>
        </div>
    </form>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.1/js/bootstrap.min.js" integrity="sha512-EKWWs1ZcA2ZY9lbLISPz8aGR2+L7JVYqBAYTq5AXgBkSjRSuQEGqWx8R1zAX16KdXPaCjOCaKE8MCpU0wcHlHA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.5.7/jquery.fancybox.min.js" integrity="sha512-uURl+ZXMBrF4AwGaWmEetzrd+J5/8NRkWAvJx5sbPSSuOb0bZLqf+tOzniObO00BjHa/dD7gub9oCGMLPQHtQA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js" integrity="sha512-HGOnQO9+SP1V92SrtZfjqxxtLmVzqZpjFFekvzZVWoiASSQgSr4cw9Kqd2+l8Llp4Gm0G8GIFJ4ddwZilcdb8A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script>
        function toggleLogout(event) {
            event.preventDefault();
            const logoutContainer = document.getElementById('logoutContainer');
            if (logoutContainer.style.display === 'none' || logoutContainer.style.display === '') {
                logoutContainer.style.display = 'block';
            } else {
                logoutContainer.style.display = 'none';
            }
        }
    </script>
</body>
</html>
