<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserManage.aspx.cs" Inherits="E_WeddingDressShop.Views.Admin.UserManage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản lý người dùng</title>
    <link href="../../Assets/UserManage.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Quản lý người dùng</h1>
            <div class="search-container">
                <label for="txtSearch">Tìm kiếm theo tên </label>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" />
                <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn" OnClick="btnSearch_Click" />
            </div>

            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered">
                <Columns>
                    <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="FullName" HeaderText="Họ và tên" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="NumberPhone" HeaderText="Số điện thoại" />
                    <asp:BoundField DataField="Address" HeaderText="Địa chỉ" />
                    <asp:BoundField DataField="Role" HeaderText="Quyền" />
                    <asp:TemplateField HeaderText="Xóa quyền người dùng">
                        <ItemTemplate>
                            <asp:Button runat="server" ID="btnDeleteRole" CommandName="DELETE_ROLE" Text="Xóa quyền"
                                CommandArgument='<%# Bind("UserID") %>' OnCommand="btnDelete_Click"
                                OnClientClick="return confirm('Bạn có chắc chắn muốn xóa quyền người dùng này?');" CssClass="btn btn-danger"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Lên quyền Admin">
                        <ItemTemplate>
                            <asp:Button runat="server" ID="btnPromoteRole" CommandName="PROMOTE_ROLE" Text="Lên quyền Admin"
                                CommandArgument='<%# Bind("UserID") %>' OnCommand="btnEdit_Click"
                                OnClientClick="return confirm('Bạn có chắc chắn muốn nâng quyền người dùng này?');"
                                CssClass="btn btn-success" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
