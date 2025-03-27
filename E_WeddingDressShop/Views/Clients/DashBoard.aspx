<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashBoard.aspx.cs" Inherits="E_WeddingDressShop.Views.DashBoard" EnableEventValidation="false" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Wedding Dress Shop</title>
    <!-- External CSS -->
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

            .menu-header a {
                color: #333;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
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
                font-weight: 500;
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

        /* Banner */
        .banner {
            width: 100%;
            margin: -80px auto;
            overflow: hidden;
            padding-top: 80px;
        }

            .banner .swiper-slide img {
                width: 100%;
                object-fit: cover;
                display: block;
            }

            .banner .swiper-container {
                position: relative;
                width: 100%;
                height: 600px;
            }

            .banner .swiper-button-next,
            .banner .swiper-button-prev {
                color: white;
                opacity: 0.8;
                transition: color 0.3s ease, opacity 0.3s ease;
            }

                .banner .swiper-button-next:hover,
                .banner .swiper-button-prev:hover {
                    opacity: 1;
                }

            .banner .swiper-pagination-bullet {
                background-color: white;
                opacity: 0.6;
                transition: opacity 0.3s ease;
            }

            .banner .swiper-pagination-bullet-active {
                opacity: 1;
            }

        /* Product Grid */
        .wrapper-new-product {
            width: 100%;
            margin-top: 100px;
            padding: 80px 50px;
        }

            .wrapper-new-product .title {
                position: relative;
                text-align: center;
                font-size: 40px;
                font-family: "Housttely";
                color: var(--primary-color);
                margin-bottom: 70px;
                z-index: 2;
            }

                .wrapper-new-product .title img {
                    position: absolute;
                    top: 50%; /* Đặt điểm giữa theo trục dọc */
                    left: 50%; /* Đặt điểm giữa theo trục ngang */
                    transform: translate(-50%, -50%);
                    width: 200px;
                    object-fit: cover;
                    z-index: -1;
                }

        .product-grid {
            display: grid;
            gap: 20px;
            padding: 20px;
            grid-template-columns: repeat(4, 1fr);
        }

        /*        .product-card-wrapper {
            flex: 1 1 calc(20% - 20px);
            max-width: calc(20% - 20px);
        }*/

        .product-card {
            border-radius: 8px;
            background: #fff;
            text-align: left;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

            .product-card:hover {
                transform: scale(1.02);
            }

            .product-card img {
                width: 100%;
                height: 500px;
                object-fit: cover;
            }

            .product-card h3 {
                font-size: 16px;
                color: #333;
            }

            .product-card p {
                font-size: 14px;
                color: #333;
            }

            .product-card .price {
                color: #f60;
                font-size: 14px;
            }

            .product-card input {
                width: 100%;
                background-color: transparent;
                color: #222;
                border: none;
                outline: none;
                font-size: 14px;
                margin-top: 10px;
                text-decoration: underline;
            }

                .product-card input:hover {
                    color: var(--primary-color);
                }

        /* Responsive Adjustments */
        @media (max-width: 1200px) {
            .product-card-wrapper {
                flex: 1 1 calc(25% - 20px);
            }
        }

        @media (max-width: 992px) {
            .product-card-wrapper {
                flex: 1 1 calc(33.33% - 20px);
            }
        }

        @media (max-width: 768px) {
            .product-card-wrapper {
                flex: 1 1 calc(50% - 20px);
            }
        }

        @media (max-width: 576px) {
            .product-card-wrapper {
                flex: 1 1 100%;
            }
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 30px;
            gap: 10px;
        }

            .pagination input {
                padding: 8px 16px;
                font-size: 14px;
                color: #222;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                background-color: transparent;
                text-decoration: underline;
            }

                .pagination input:hover {
                    color: var(--primary-color); 
                }

                .pagination input:disabled {
                    cursor: not-allowed;
                }

            .pagination span {
                font-size: 15px;
                color: var(--primary-color);
            }


        footer {
            width: 100%;
        }

            footer img {
                width: 100%;
                height: 100%;
                object-fit: cover;
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
        <div class="banner">
            <div class="swiper-container">
                <div class="swiper-wrapper slides-banner">
                    <div class="swiper-slide">
                        <img src="../../Template/image/image-banner1.jpg" />
                    </div>
                    <div class="swiper-slide">
                        <img src="../../Template/image/image-banner1.jpg" />
                    </div>
                    <div class="swiper-slide">
                        <img src="../../Template/image/image-banner1.jpg" />
                    </div>
                </div>
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-pagination"></div>
            </div>
        </div>
        <div class="wrapper-new-product">
            <div class="title">
                Danh sách sản phẩm
        <img src="../../Template/image/main-img.png" />
            </div>
            <div class="product-grid">
                <asp:Repeater ID="rptNewProducts" runat="server">
                    <ItemTemplate>
                        <div class="product-card-wrapper">
                            <div class="product-card">
                                <img src='<%# ResolveUrl(Eval("ImageUrl").ToString()) %>' />
                                <div class="d-flex justify-content-between mt-2">
                                    <div>
                                        <h3 class="mb-2"><%# Eval("Name") %></h3>
                                        <p class="mb-0"><%# Eval("Description") %></p>
                                    </div>
                                    <p class="price"><%# Eval("Price", "{0:N0} VNĐ") %></p>
                                </div>
                                <asp:Button runat="server" CommandName="view" Text="View Details" CommandArgument='<%# Eval("ProductID") %>' OnCommand="View_Details" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <!-- Phân trang -->
            <div class="pagination">
                <asp:Button ID="btnPrevious" runat="server" Text="<<Trang trước" CssClass="pagination-button" OnClick="btnPrevious_Click" />
                <asp:Label ID="lblCurrentPage" runat="server"></asp:Label>
                <span>/</span>
   
                <asp:Label ID="lblTotalPages" runat="server"></asp:Label>
                <asp:Button ID="btnNext" runat="server" Text="Trang sau>>" CssClass="pagination-button" OnClick="btnNext_Click" />
            </div>
        </div>
        <footer>
            <img src="../../Template/image/Screenshot%202024-12-25%20000248.png" />
        </footer>
    </form>
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
        document.addEventListener("DOMContentLoaded", () => {
            const swiper = new Swiper('.banner .swiper-container', {
                loop: true,
                autoplay: {
                    delay: 3000,
                    disableOnInteraction: false,
                },
                speed: 800,
                effect: 'slide',
                fadeEffect: {
                    crossFade: true,
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
                lazy: true,
            });
        });
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.1/js/bootstrap.min.js" integrity="sha512-EKWWs1ZcA2ZY9lbLISPz8aGR2+L7JVYqBAYTq5AXgBkSjRSuQEGqWx8R1zAX16KdXPaCjOCaKE8MCpU0wcHlHA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.5.7/jquery.fancybox.min.js" integrity="sha512-uURl+ZXMBrF4AwGaWmEetzrd+J5/8NRkWAvJx5sbPSSuOb0bZLqf+tOzniObO00BjHa/dD7gub9oCGMLPQHtQA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js" integrity="sha512-HGOnQO9+SP1V92SrtZfjqxxtLmVzqZpjFFekvzZVWoiASSQgSr4cw9Kqd2+l8Llp4Gm0G8GIFJ4ddwZilcdb8A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
</body>
</html>
