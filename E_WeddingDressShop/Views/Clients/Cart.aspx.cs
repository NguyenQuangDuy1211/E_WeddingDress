using E_WeddingDressShop.Controllers;
using E_WeddingDressShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_WeddingDressShop.Views.Clients
{
    public partial class Cart : System.Web.UI.Page
    {
        public CartController cartController = new CartController();
        public UserController userController = new UserController();
        public OrderController orderController = new OrderController();
        public OrderDetailController orderDetailController = new OrderDetailController();
        public ProductController productController = new ProductController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string email = Session["UserEmail"].ToString();
                int userId = userController.getUserByEmail(email);
                string userName = userController.getUserByUserID(userId).FullName;
                nameUser.InnerText = "Xin chào " + userName.ToString();
                Loaded();
            }
           
        }
        public void Loaded()
        {
            string email = Session["UserEmail"].ToString();
            int userId = userController.getUserByEmail(email);

            var cartList = cartController.getList(userId);

            if (cartList.Count == 0)
            {
                lblMessage.Text = "Không có sản phẩm trong giỏ hàng.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
                gvOrders.Visible = false;  
            }
            else
            {
                gvOrders.DataSource = cartList;
                gvOrders.DataBind();
                gvOrders.Visible = true;
            }
        }

        protected void Xoa_Click(object sender, CommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "DeleteCart")
                {
                    //string email = Session["UserEmail"].ToString();
                    //int userId = userController.getUserByEmail(email);
                    int cartID = Convert.ToInt32(e.CommandArgument);
                    string result = cartController.DeleteCart(cartID);
                    ShowMessage(result, result.Contains("thành công"));
                    Loaded();
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Lỗi khi xóa danh mục: {ex.Message}", false);
            }
        }
        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = isSuccess ? System.Drawing.Color.Green : System.Drawing.Color.Red;
            lblMessage.Visible = true;
        }
        protected void Dat_Hang_Click(object sender, CommandEventArgs e)
        {
            try
            {
                // Lấy email người dùng từ Session
                string email = Session["UserEmail"]?.ToString();
                if (string.IsNullOrEmpty(email))
                {
                    ShowMessage("Không tìm thấy thông tin người dùng. Vui lòng đăng nhập lại.", false);
                    return;
                }

                // Lấy thông tin người dùng và sản phẩm
                int userId = userController.getUserByEmail(email);
                string fullName = userController.getUserByUserID(userId).FullName;
                int cartID = Convert.ToInt32(e.CommandArgument);
                int productId = cartController.getProductIDByCartID(cartID);
                decimal price = productController.getPriceByID(productId);
                int quantity = cartController.getQuantityByID(cartID);
                int stockQuantity = productController.getProductByID(productId).StockQuantity;
                ORDER od = new ORDER
                {
                    UserID = userId,
                    OrderDate = DateTime.Now,
                    Status = "Processing",
                    TotalAmount = Convert.ToDecimal(price * quantity)
                };

                int orderId = orderController.AddORDER(od);
                
                ORDERDETAILS odd = new ORDERDETAILS
                {
                    OrderID = orderId,
                    ProductID = productId,
                    Quantity = quantity,
                    UnitPrice = Convert.ToDecimal(price * quantity)
                };

                string detailResult = orderDetailController.AddOderDetail(odd);
                productController.UpdateStockQuantity(productId, stockQuantity - quantity);
                cartController.DeleteCart(cartID);

                ShowMessage("Đặt hàng thành công!", true);
                Loaded();
            }
            catch (Exception ex)
            {
                ShowMessage("Có lỗi xảy ra: " + ex.Message, false);
            }
        }
       protected void logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Views/Clients/Login.aspx");
        }
    }
}