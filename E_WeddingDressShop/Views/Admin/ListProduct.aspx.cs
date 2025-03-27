using E_WeddingDressShop.Controllers;
using E_WeddingDressShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_WeddingDressShop.Views.Admin
{
    public partial class ListProduct : System.Web.UI.Page
    {
        ProductController productController = new ProductController();
        CategoryController categoryController = new CategoryController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
            }
        }
        private void LoadProducts(string searchKeyword = null)
        {
            List<PRODUCT> products;

            if (!string.IsNullOrEmpty(searchKeyword))
            {
                products = productController.getListProductByName(searchKeyword);
            }
            else
            {
                products = productController.getListProduct();
            }

            if (products == null || products.Count == 0)
            {
                ShowMessage($"Không tìm thấy sản phẩm nào với từ khóa '{searchKeyword}'.", false);
            }
            else
            {
                lblMessage.Visible = false;
            }

            gvProducts.DataSource = products;
            gvProducts.DataBind();
        }


        protected void Xoa_Click(object sender, CommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "XOA")
                {
                    int productID = Convert.ToInt32(e.CommandArgument);
                    string result = productController.DeleteProduct(productID);

                    ShowMessage(result, result.Contains("thành công"));
                    LoadProducts();
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Lỗi khi xóa danh mục: {ex.Message}", false);
            }
        }
        protected void Sua_Click(object sender, CommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "SUA")
                {
                    int productId = Convert.ToInt32(e.CommandArgument);
                    PRODUCT product = productController.getProductByID(productId);

                    if (product != null)
                    {
                        Session["sp"] = product;
                        Response.Redirect("UpdateProductManage.aspx");
                    }
                    else
                    {
                        ShowMessage("Không tìm thấy danh mục cần sửa.", false);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Lỗi khi sửa danh mục: {ex.Message}", false);
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = isSuccess ? System.Drawing.Color.Green : System.Drawing.Color.Red;
            lblMessage.Visible = true;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchKeyword = txtSearch.Text.Trim(); 
            LoadProducts(searchKeyword); 
        }

    }
}