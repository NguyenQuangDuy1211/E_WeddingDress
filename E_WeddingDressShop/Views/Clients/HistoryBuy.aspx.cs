using E_WeddingDressShop.Controllers;
using E_WeddingDressShop.Models;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_WeddingDressShop.Views.Clients
{
    public partial class HistoryBuy : Page
    {
        private readonly ProductController productController = new ProductController();
        private readonly UserController userController = new UserController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string userEmail = Session["UserEmail"]?.ToString();
                int userID = userController.getUserByEmail(userEmail);
                if (string.IsNullOrEmpty(userEmail))
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                LoadPurchaseHistory(userID);
            }
        }

        private void LoadPurchaseHistory(int userID)
        {
            try
            {
                List<PRODUCT> purchasedProducts = productController.getListProductBought(userID);

                if (purchasedProducts != null && purchasedProducts.Count > 0)
                {
                    gvHistory.DataSource = purchasedProducts;
                    gvHistory.DataBind();
                }
                else
                {
                    gvHistory.EmptyDataText = "Bạn chưa mua sản phẩm nào.";
                }
            }
            catch (Exception ex)
            {
                gvHistory.EmptyDataText = "Có lỗi xảy ra khi lấy dữ liệu lịch sử.";
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
