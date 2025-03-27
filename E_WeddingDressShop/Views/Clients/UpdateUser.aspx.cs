using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using E_WeddingDressShop.Controllers;
using E_WeddingDressShop.DTO;
using System.EnterpriseServices.Internal;
using System.Security.Cryptography;
using System.Text;
namespace E_WeddingDressShop.Views.Clients
{
    public partial class UpdateUser : System.Web.UI.Page
    {
        UserController usercontroller = new UserController();
        protected void Page_Load(object sender, EventArgs e)
        {
            Loaded();
        }
        private bool checkPassword()
        {
            return txtmatkhau.Text == txtnhaplaimatkhau.Text;
        }

        protected void Loaded()
        {
            string email = Session["UserEmail"].ToString();
            int userId = usercontroller.getUserByEmail(email);
            USER u = usercontroller.layUserByUserID(userId);
            txthoten.Text = u.FullName;
            txtemail.Text = u.Email;
            txtdiachi.Text = u.Address;

            txtphonenumber.Text = u.NumberPhone;
        }
        protected void UpdateUserNe(object sender, CommandEventArgs e)
        {
            try
            {
                string email = Session["UserEmail"].ToString();
                int userId = usercontroller.getUserByEmail(email);
                USER u = usercontroller.layUserByUserID(userId);


                u.FullName = txthoten.Text;
                u.Email = txtemail.Text;
                u.NumberPhone = txtphonenumber.Text;
                if (checkPassword() == false)
                {
                    lblErrorMessage.Text = "Mật khẩu không trùng khớp";
                    return;
                }
                u.PasswordHash = usercontroller.HashPassword(txtmatkhau.Text);
                string result = usercontroller.UpdateUser(u);
                lblErrorMessage.Text = result;
                Response.Redirect("~/Views/Clients/DashBoard.aspx");

            }
            catch (Exception e1)
            {
                lblErrorMessage.Text = "Có lỗi xảy ra: " + e1.Message;
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