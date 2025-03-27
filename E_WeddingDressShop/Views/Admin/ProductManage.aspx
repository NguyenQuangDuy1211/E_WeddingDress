<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductManage.aspx.cs" Inherits="E_WeddingDressShop.Views.Admin.ProductManage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản lý sản phẩm</title>
    <link href="../../Assets/ProductManage.css" rel="stylesheet" />
    <style>
        body {
            background-color: white;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .form-container, .grid-container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        h2 {
            color: #333;
        }

        label {
            display: block;
            margin-top: 10px;
            color: #555;
        }

        input[type="text"], textarea, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }

        input[type="file"] {
            margin-top: 10px;
        }

        .form-container button, .grid-container button {
            padding: 10px 20px;
            border: none;
            border-radius: 3px;
            color: white;
            cursor: pointer;
            margin-right: 10px;
        }

        .form-container button {
            background-color: #007bff;
        }

            .form-container button:hover {
                background-color: #0056b3;
            }

        .btn-blue {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
        }

            .btn-blue:hover {
                background-color: #0056b3;
            }

        .btn-red {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
        }

            .btn-red:hover {
                background-color: #a71d2a;
            }

        .grid-container table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .grid-container th, .grid-container td {
            text-align: left;
            padding: 8px;
            border: 1px solid #ddd;
        }

        .grid-container th {
            background-color: #f4f4f4;
            color: #333;
        }

        .grid-container tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .grid-container tr:hover {
            background-color: #f1f1f1;
        }

        .grid-container img {
            width: 100px;
            height: 150px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Thêm sản phẩm</h2>

            <asp:Label ID="lblProductID" runat="server" Text="ID sản phẩm (chỉ dùng khi cập nhật):" Visible="false"></asp:Label>
            <asp:TextBox ID="txtProductID" runat="server" Visible="false"></asp:TextBox>

            <label for="txtProductName">Tên sản phẩm:</label>
            <asp:TextBox ID="txtProductName" runat="server"></asp:TextBox>

            <label for="txtDescription">Mô tả sản phẩm:</label>
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>

            <label for="txtPrice">Giá:</label>
            <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>

            <label for="txtStockQuantity">Số lượng tồn:</label>
            <asp:TextBox ID="txtStockQuantity" runat="server"></asp:TextBox>

            <label for="txtImageUrl">Hình ảnh:</label>
            <asp:Label ID="lblUploadMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            <asp:Image ID="imgPreview" runat="server" Visible="false" Width="200px" Height="200px" />
            <asp:FileUpload ID="fileUploadImage" runat="server" />
            <asp:TextBox ID="txtImageUrl" runat="server" Visible="false"></asp:TextBox>

            <label for="ddlCategory">Danh mục:</label>
            <asp:DropDownList ID="ddlCategory" runat="server"></asp:DropDownList>

            <asp:Button ID="btnAddOrUpdate" runat="server" Text="Thêm" OnClick="btnAddOrUpdate_Click" CssClass="btn-blue" />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>
        </div>

        <div class="grid-container">
            <h2>Danh sách sản phẩm</h2>
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
                    <asp:BoundField DataField="Price" HeaderText="Giá" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="StockQuantity" HeaderText="Số lượng tồn" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Danh mục" />
                    <asp:TemplateField HeaderText="Sửa">
                        <ItemTemplate>
                            <asp:Button runat="server" ID="sua" CommandName="SUA" OnCommand="Sua_Click"
                                Text="Sửa" CommandArgument='<%# Bind("ProductID") %>' CssClass="btn-blue"></asp:Button>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Xoá">
                        <ItemTemplate>
                            <asp:Button runat="server" ID="xoa" CommandName="XOA" OnCommand="Xoa_Click"
                                Text="Xoá" CommandArgument='<%# Bind("ProductID") %>' CssClass="btn-red"
                                OnClientClick="return confirm('Bạn có chắc chắn xoá không ?') "></asp:Button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
