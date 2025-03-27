<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateProductManage.aspx.cs" Inherits="E_WeddingDressShop.Views.Admin.UpdateProductManage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sửa sản phẩm</title>
    <link href="../../Assets/UpdateProduct.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Cập Nhật Sản Phẩm</h2>
            <asp:Table runat="server" ID="t1" class="product-table">
                <asp:TableRow>
                    <asp:TableCell>Mã sản phẩm</asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtProductID" runat="server" class="input-field" Enabled="false" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>Tên sản phẩm</asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtProductName" runat="server" class="input-field" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>Mô tả</asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtDescription" runat="server" class="input-field" TextMode="MultiLine" Rows="4" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>Giá</asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtPrice" runat="server" class="input-field" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>Số lượng tồn</asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtStockQuantity" runat="server" class="input-field" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>Danh mục</asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="ddlCategory" runat="server" class="input-field" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>Ảnh</asp:TableCell>
                    <asp:TableCell>
                        <asp:Image ID="imgPreview" runat="server" Width="200px" Height="200px" Visible="false" />
                        <br />
                        <asp:FileUpload ID="fileUploadImage" runat="server" class="input-file" />
                        <asp:Label ID="lblUploadMessage" runat="server" class="upload-message" Visible="false"></asp:Label>
                        <asp:TextBox ID="txtImageUrl" runat="server" class="input-field" Visible="false"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <div class="buttons">
                <asp:Button ID="btnSua" runat="server" Text="Lưu thay đổi" OnClick="btnSua_Click" class="btn-save" />
                <asp:Button ID="btnBoQua" runat="server" Text="Hủy bỏ" class="btn-cancel"  PostBackUrl="~/Views/Admin/ProductManage.aspx"/>
            </div>
            <p>
                <asp:Label ID="msg" runat="server" class="message-label" Font-Italic="true" />
            </p>
        </div>
    </form>
</body>
</html>