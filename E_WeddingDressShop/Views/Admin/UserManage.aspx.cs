using E_WeddingDressShop.Controllers;
using E_WeddingDressShop.DTO;
using E_WeddingDressShop.Models;
using E_WeddingDressShop.Views.Clients;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_WeddingDressShop.Views.Admin
{
    public partial class UserManage : Page
    {
        UserController userController = new UserController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUsers();
            }
            string email = Session["UserEmail"].ToString();
            int userID = userController.getUserByEmail(email);
            string role = userController.getUserByUserID(userID).Role;
            if(role != "Admin")
            {
                Response.Redirect("~/Views/Clients/Login.aspx");
            }
        }

        private void LoadUsers(string searchKeyword = null)
        {
            List<USER> users;

            if (!string.IsNullOrEmpty(searchKeyword))
            {
                users = userController.getListUserByKeyword(searchKeyword);
            }
            else
            {
                users = userController.getListUser();
            }

            gvUsers.DataSource = users;
            gvUsers.DataBind();

            if (users.Count == 0)
            {
                ShowMessage("Không tìm thấy người dùng phù hợp.", false);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchKeyword = txtSearch.Text.Trim();
            LoadUsers(searchKeyword);
        }

        protected void btnEdit_Click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "PROMOTE_ROLE")
            {
                int userId = Convert.ToInt32(e.CommandArgument);
                string result = userController.UpdateUserRoleToAdmin(userId);

                ShowMessage(result, result.Contains("thành công"));
                LoadUsers();
            }
        }

        protected void btnDelete_Click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "DELETE_ROLE")
            {
                int userId = Convert.ToInt32(e.CommandArgument);
                
                string email = Session["UserEmail"].ToString();
                int userID = userController.getUserByEmail(email);
                string result = userController.RemoveUserRole(userId);
                ShowMessage(result, result.Contains("thành công"));
                if (userID == userId) Page_Load(sender, e);
                LoadUsers();
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = isSuccess ? System.Drawing.Color.Green : System.Drawing.Color.Red;
            lblMessage.Visible = true;
        }
    }
}
