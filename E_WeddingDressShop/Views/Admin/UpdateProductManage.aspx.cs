using E_WeddingDressShop.Controllers;
using E_WeddingDressShop.Models;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_WeddingDressShop.Views.Admin
{
    public partial class UpdateProductManage : System.Web.UI.Page
    {
        private readonly ProductController productController = new ProductController();
        private readonly CategoryController categoryController = new CategoryController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                if (Session["sp"] is PRODUCT sv)
                {
                    txtProductID.Text = sv.ProductID.ToString();
                    txtProductName.Text = sv.Name;
                    txtDescription.Text = sv.Description;
                    txtPrice.Text = sv.Price.ToString("F2");
                    txtStockQuantity.Text = sv.StockQuantity.ToString();
                    ddlCategory.SelectedValue = sv.CategoryID.ToString();

                    if (!string.IsNullOrWhiteSpace(sv.ImageUrl))
                    {
                        imgPreview.ImageUrl = sv.ImageUrl;
                        imgPreview.Visible = true;
                    }
                }
                else
                {
                    msg.Text = "Không có sản phẩm nào để cập nhật.";
                    msg.ForeColor = System.Drawing.Color.Red;
                    btnSua.Enabled = false;
                }
            }
        }
        private void LoadCategories()
        {
            ddlCategory.DataSource = categoryController.getListCategory();
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryID";
            ddlCategory.DataBind();

        }

        protected void btnSua_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtProductName.Text) ||
                    string.IsNullOrWhiteSpace(txtDescription.Text) ||
                    string.IsNullOrWhiteSpace(txtPrice.Text) ||
                    string.IsNullOrWhiteSpace(txtStockQuantity.Text) ||
                    ddlCategory.SelectedValue == null)
                {
                    msg.Text = "Vui lòng điền đầy đủ thông tin trước khi cập nhật.";
                    msg.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string imageUrl = imgPreview.ImageUrl;
                if (fileUploadImage.HasFile)
                {
                    string fileName = $"{DateTime.Now.Ticks}_{fileUploadImage.FileName}";
                    string filePath = Server.MapPath($"~/Uploads/{fileName}");
                    fileUploadImage.SaveAs(filePath);
                    imageUrl = $"/Uploads/{fileName}"; 
                }

                PRODUCT updateProduct = new PRODUCT
                {
                    ProductID = int.Parse(txtProductID.Text),
                    Name = txtProductName.Text.Trim(),
                    Description = txtDescription.Text.Trim(),
                    Price = decimal.Parse(txtPrice.Text),
                    StockQuantity = int.Parse(txtStockQuantity.Text),
                    ImageUrl = imageUrl,
                    CategoryID = int.Parse(ddlCategory.SelectedValue)
                };

                string result = productController.UpdateProduct(updateProduct);

                if (result.Contains("thành công"))
                {
                    msg.Text = "Cập nhật sản phẩm thành công!";
                    msg.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    msg.Text = result;
                    msg.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                msg.Text = $"Lỗi khi cập nhật sản phẩm: {ex.Message}";
                msg.ForeColor = System.Drawing.Color.Red;
            }
        }
        private void ShowMessage(string message, bool isSuccess)
        {
            msg.Text = message;
            msg.ForeColor = isSuccess ? System.Drawing.Color.Green : System.Drawing.Color.Red;
            msg.Visible = true;
        }
    }
}
