<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateCategoryManage.aspx.cs" Inherits="E_WeddingDressShop.Views.Admin.UpdateCategoryManage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Update Category</title>
    <link href="../../Assets/UpdateCategory.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Cập Nhật Danh Mục</h2>
            <asp:Table runat="server" ID="t1" class="category-table">
                <asp:TableRow>
                    <asp:TableCell>Mã Danh Mục</asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtCategoryID" runat="server" class="input-field" Enabled="false" />
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>Tên Danh Mục</asp:TableCell><asp:TableCell>
                        <asp:TextBox ID="txtCategoryName" runat="server" class="input-field" />
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>Mô tả</asp:TableCell><asp:TableCell>
                        <asp:TextBox ID="txtDescription" runat="server" class="input-field" TextMode="MultiLine" />
                    </asp:TableCell></asp:TableRow></asp:Table><div class="buttons">
                <asp:Button ID="btnSua" runat="server" Text="Lưu thay đổi" OnClick="btnSua_Click" class="btn-save" />
                <asp:Button ID="btnBoQua" runat="server" Text="Hủy bỏ" class="btn-cancel" />
            </div>
            <p>
                <asp:Label ID="msg" runat="server" class="message-label" Font-Italic="true" />
            </p>
        </div>
    </form>
</body>
</html>
