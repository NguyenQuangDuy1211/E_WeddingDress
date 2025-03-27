using E_WeddingDressShop.Controllers;
using E_WeddingDressShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_WeddingDressShop.Views
{
    public partial class DashBoard : System.Web.UI.Page
    {
        private UserController userController = new UserController();
        private ProductController productController = new ProductController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("~/Views/Clients/Login.aspx");
            }
            else
            {
                string email = Session["UserEmail"].ToString();
                int userID = userController.getUserByEmail(email);
                string userName = userController.getUserByUserID(userID).FullName;
                nameUser.InnerText = "Xin chào " + userName.ToString();
                LoadNewProducts();
            }
        }

        protected void logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Views/Clients/Login.aspx");
        }


        private int PageSize = 8; // Số sản phẩm trên mỗi trang
        private int CurrentPage
        {
            get
            {
                if (ViewState["CurrentPage"] == null)
                    return 1; // Trang mặc định là 1
                return (int)ViewState["CurrentPage"];
            }
            set
            {
                ViewState["CurrentPage"] = value;
            }
        }

        private void LoadNewProducts()
        {
            List<PRODUCT> products = productController.getListProduct();

            // Tổng số trang
            int totalProducts = products.Count;
            int totalPages = (int)Math.Ceiling((double)totalProducts / PageSize);

            // Hiển thị chỉ sản phẩm của trang hiện tại
            var paginatedProducts = products.Skip((CurrentPage - 1) * PageSize).Take(PageSize).ToList();

            rptNewProducts.DataSource = paginatedProducts;
            rptNewProducts.DataBind();

            // Cập nhật thông tin phân trang
            lblTotalPages.Text = totalPages.ToString();
            lblCurrentPage.Text = CurrentPage.ToString();

            // Kiểm tra trạng thái nút bấm
            btnPrevious.Enabled = CurrentPage > 1;
            btnNext.Enabled = CurrentPage < totalPages;
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 1)
            {
                CurrentPage--;
                LoadNewProducts();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            int totalProducts = productController.getListProduct().Count;
            int totalPages = (int)Math.Ceiling((double)totalProducts / PageSize);

            if (CurrentPage < totalPages)
            {
                CurrentPage++;
                LoadNewProducts();
            }
        }


        protected void View_Details(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                int productID;
                if (int.TryParse(e.CommandArgument.ToString(), out productID))
                {
                    Response.Redirect("~/Views/Clients/ProductDetails.aspx?productID=" + productID);
                }

            }
        }
    }
}