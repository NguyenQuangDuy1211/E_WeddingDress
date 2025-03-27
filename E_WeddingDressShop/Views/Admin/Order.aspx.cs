using E_WeddingDressShop.Controllers;
using E_WeddingDressShop.Models;
using System;
using System.Web.UI.WebControls;

namespace E_WeddingDressShop.Views.Admin
{
    public partial class Order : System.Web.UI.Page
    {
        private OrderController orderController = new OrderController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            gvOrders.DataSource = orderController.getListOrder();
            gvOrders.DataBind();
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int orderId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditOrder")
            {
                ORDER order = orderController.getORDERByID(orderId);

                if (order != null)
                {
                    hfOrderID.Value = order.OrderID.ToString();
                    txtUserID.Text = order.UserID.ToString();
                    txtFullName.Text = order.FullName;
                    txtOrderDate.Text = order.OrderDate.ToString("yyyy-MM-dd");
                    txtTotalAmount.Text = order.TotalAmount.ToString();
                    ddlStatus.SelectedValue = order.Status;
                }
            }
            else if (e.CommandName == "DeleteOrder")
            {
                string message = orderController.DeleteORDER(orderId);
                lblMessage.Text = message;
                LoadOrders();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            ORDER order = new ORDER
            {
                OrderID = string.IsNullOrEmpty(hfOrderID.Value) ? 0 : Convert.ToInt32(hfOrderID.Value),
                UserID = Convert.ToInt32(txtUserID.Text),
                FullName = txtFullName.Text,
                OrderDate = Convert.ToDateTime(txtOrderDate.Text),
                TotalAmount = Convert.ToDecimal(txtTotalAmount.Text),
                Status = ddlStatus.SelectedValue
            };

            string message;

            if (order.OrderID == 0)
            {
                int orderId = orderController.AddORDER(order); 
                if(orderId > 0)
                {
                    message = "Đơn hàng đã được thêm thành công!";
                    lblMessage.Text = message;
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    message = "Đơn hàng đã được thêm thất bại!";
                    lblMessage.Text = message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                message = orderController.UpdateORDER(order);
                lblMessage.Text = message;
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            LoadOrders();
        }
    }
}
