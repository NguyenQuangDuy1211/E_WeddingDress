<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryManage.aspx.cs" Inherits="E_WeddingDressShop.Views.Admin.CategoryManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản lý danh mục</title>
    <link href="../../Assets/CategoryManage.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Thêm</h2>
            <asp:Label ID="lblCategoryID" runat="server" Text="ID danh mục (chỉ dùng khi cập nhật):" Visible="false"></asp:Label>
            <asp:TextBox ID="txtCategoryID" runat="server" Visible="false"></asp:TextBox>

            <label for="txtCategoryName">Tên danh mục:</label>
            <asp:TextBox ID="txtCategoryName" runat="server"></asp:TextBox>

            <label for="txtDescription">Mô tả danh mục:</label>
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>

            <asp:Button ID="btnAddOrUpdate" runat="server" Text="Thêm / Cập nhật" OnClick="btnAddOrUpdate_Click" CssClass="button" />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>
        </div>

        <div class="grid-container">
            <h2>Danh sách danh mục</h2>
            <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered">
                <Columns>
                    <asp:BoundField DataField="CategoryID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Tên danh mục" />
                    <asp:BoundField DataField="Description" HeaderText="Mô tả" />
                    <asp:TemplateField HeaderText="Sửa">
                        <ItemTemplate>
                            <asp:Button runat="server" ID="sua" CommandName="SUA" OnCommand="Sua_Click" Text="Sửa" CommandArgument='<%# Bind("CategoryID") %>' CssClass="sua"></asp:Button>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Xoá">
                        <ItemTemplate>
                            <asp:Button runat="server" ID="xoa" CommandName="XOA" OnCommand="Xoa_Click" Text="Xoá" CommandArgument='<%# Bind("CategoryID") %>'
                                OnClientClick="return confirm('Bạn có chắc chắn xoá không ?') " CssClass="xoa"></asp:Button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
