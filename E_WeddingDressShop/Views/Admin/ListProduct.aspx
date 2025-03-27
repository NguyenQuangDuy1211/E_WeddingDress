<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListProduct.aspx.cs" Inherits="E_WeddingDressShop.Views.Admin.ListProduct" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Danh sách sản phẩm</title>
    <style>
        /* Reset mặc định */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        /* Tiêu đề chính */
        h2 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }
        /* Form container */
        form {
            max-width: 80%;
            margin: auto;
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        /* Tìm kiếm */
        .form-control {
            width: 70%;
            padding: 10px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        .btn {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: #fff;
            transition: background-color 0.3s ease;
        }

            .btn:hover {
                background-color: #0056b3;
            }
        /* Lưới sản phẩm */
        .grid-container {
            margin-top: 20px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

            .table th, .table td {
                text-align: center;
                padding: 10px;
                border: 1px solid #ddd;
            }

            .table th {
                background-color: #f2f2f2;
                font-weight: bold;
            }

            .table td {
                background-color: #fff;
            }

            .table img {
                max-width: 100px;
                max-height: 100px;
            }
            /* Nút sửa và xoá */
            .table .btn {
                width: 80px;
            }

        .btn-danger {
            background-color: #dc3545;
        }

            .btn-danger:hover {
                background-color: #a71d2a;
            }
        /* Thông báo */
        #lblMessage {
            display: block;
            text-align: center;
            font-size: 18px;
            margin-top: 20px;
        }

        .btn {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        /* Nút Sửa */
        .btn-edit {
            background-color: #28a745; /* Màu xanh lá cây */
            color: white;
        }

            .btn-edit:hover {
                background-color: #218838; /* Màu đậm hơn khi hover */
                transform: scale(1.05);
            }
        /* Nút Xóa */
        .btn-delete {
            background-color: #dc3545; /* Màu đỏ */
            color: white;
        }

            .btn-delete:hover {
                background-color: #c82333; /* Màu đậm hơn khi hover */
                transform: scale(1.05);
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center;">
            <h2>Danh sách sản phẩm</h2>
            <div style="display: flex; flex-direction: row; align-items: center; justify-content: center; gap: 10px; margin-top: 10px;">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Nhập tên sản phẩm..." />
                <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
            </div>
        </div>
        <br />
        <div class="grid-container">
            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered">
                <Columns>
                    <asp:BoundField DataField="ProductID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="Name" HeaderText="Tên sản phẩm" />
                    <asp:TemplateField HeaderText="Ảnh sản phẩm">
                        <ItemTemplate>
                            <img src='<%# ResolveUrl(Eval("ImageUrl").ToString()) %>' class="product-img" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Description" HeaderText="Mô tả" />
                    <asp:BoundField DataField="Price" HeaderText="Giá" DataFormatString="{0:N0} VNĐ" />
                    <asp:BoundField DataField="StockQuantity" HeaderText="Số lượng tồn" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Danh mục" />
                    <asp:TemplateField HeaderText="Sửa">
                        <ItemTemplate>
                            <asp:Button runat="server" ID="sua" CommandName="SUA" OnCommand="Sua_Click" Text="Sửa" CommandArgument='<%# Bind("ProductID") %>' CssClass="btn btn-edit"></asp:Button>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Xoá">
                        <ItemTemplate>
                            <asp:Button runat="server" ID="xoa" CommandName="XOA" OnCommand="Xoa_Click" Text="Xóa" CommandArgument='<%# Bind("ProductID") %>' CssClass="btn btn-delete" OnClientClick="return confirm('Bạn có chắc chắn xoá không ?')"></asp:Button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>
    </form>
</body>
</html>
