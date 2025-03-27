<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="E_WeddingDressShop.Views.Admin.Order" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản lý đơn hàng</title>
    <style>
        .container {
            width: 80%;
            margin: auto;
            font-family: Arial, sans-serif;
        }
        .table-orders {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .table-orders th, .table-orders td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .table-orders th {
            background-color: #f4f4f4;
        }
        .form-container {
            margin-top: 20px;
            border: 1px solid #ccc;
            padding: 15px;
            border-radius: 8px;
        }
        .form-container label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-container input, .form-container select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-danger {
            background-color: #dc3545;
        }
        .btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Danh sách đơn hàng</h2>
            <!-- Bảng hiển thị danh sách đơn hàng -->
            <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="table-orders" OnRowCommand="gvOrders_RowCommand">
                <Columns>
                    <asp:BoundField DataField="OrderID" HeaderText="ID"/>
                    <asp:BoundField DataField="UserID" HeaderText="User ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Họ và tên" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Ngày đặt hàng" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="TotalAmount" HeaderText="Tổng tiền" DataFormatString="{0:N0} VNĐ" />
                    <asp:BoundField DataField="Status" HeaderText="Trạng thái" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" Text="Sửa" CommandName="EditOrder" CommandArgument='<%# Eval("OrderID") %>' CssClass="btn" />
                            <asp:Button ID="btnDelete" runat="server" Text="Xóa" CommandName="DeleteOrder" CommandArgument='<%# Eval("OrderID") %>' CssClass="btn btn-danger" 
                                OnClientClick="return confirm('Bạn có chắc chắn xoá không ?') "
                                />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="form-container">
                <h3>Thêm/Sửa đơn hàng</h3>
                <asp:HiddenField ID="hfOrderID" runat="server"/>
                <label for="txtUserID">User ID:</label>
                <asp:TextBox ID="txtUserID" runat="server" ReadOnly ="true"/>
                <label for="txtFullName">Họ và tên:</label>
                <asp:TextBox ID="txtFullName" runat="server" ReadOnly ="true" />
                <label for="txtOrderDate">Ngày đặt hàng:</label>
                <asp:TextBox ID="txtOrderDate" runat="server" TextMode="Date" ReadOnly ="true"/>
                <label for="txtTotalAmount">Tổng tiền:</label>
                <asp:TextBox ID="txtTotalAmount" runat="server" ReadOnly ="true"/>
                <label for="ddlStatus">Trạng thái:</label>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Text="Huỷ đơn" Value="Cancle" />
                    <asp:ListItem Text="Chờ xử lý" Value="Pending" />
                    <asp:ListItem Text="Đang giao hàng" Value="Shipping" />
                    <asp:ListItem Text="Đã hoàn tất" Value="Completed" />
                </asp:DropDownList>
                <asp:Button ID="btnSave" runat="server" Text="Lưu" CssClass="btn" OnClick="btnSave_Click" />
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
            </div>
        </div>
    </form>
</body>
</html>
