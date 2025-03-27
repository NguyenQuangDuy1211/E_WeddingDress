using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using E_WeddingDressShop.Models;

namespace E_WeddingDressShop.Controllers
{
    public class CartController
    {
        SqlConnection conn;

        public CartController()
        {
            string SqlCon = "Data Source=bekend\\sqlexpress;Initial Catalog=E_WeddingDress;Integrated Security=True;TrustServerCertificate=True";
            conn = new SqlConnection(SqlCon);
        }

        public string AddCart(CART cart)
        {
            try
            {
                string sql = "INSERT INTO tb_Cart (UserID, ProductID, Quantity) " +
                             "VALUES (@UserID, @ProductID, @Quantity)";
                SqlCommand cmd = new SqlCommand(sql, conn);
                AddCartParamater(cmd, cart);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                return "Thêm giỏ hàng thành công!";
            }
            catch (Exception ex)
            {
                conn.Close();
                return "Lỗi khi thêm giỏ hàng: " + ex.Message;
            }
        }
        public string DeleteCart(int CartID)
        {
            try
            {
                string sql = "DELETE FROM tb_Cart WHERE CartID = @CartID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@CartID", CartID);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                return "Xóa giỏ hàng thành công!";
            }
            catch (Exception ex)
            {
                conn.Close();
                return "Lỗi khi xóa giỏ hàng: " + ex.Message;
            }
        }

        public void AddCartParamater(SqlCommand cmd, CART cart)
        {
            cmd.Parameters.AddWithValue("@CartID", cart.CartID);
            cmd.Parameters.AddWithValue("@UserID", cart.UserID);
            cmd.Parameters.AddWithValue("@ProductID", cart.ProductID);
            cmd.Parameters.AddWithValue("@Quantity", cart.Quantity);
        }
        public int getProductIDByCartID(int CartID)
        {
            try
            {
                int productID = -1;
                conn.Open();
                string url = @"select c.ProductID from tb_Cart c where CartID=@CartID";
                SqlCommand cmd = new SqlCommand(url, conn);
                cmd.Parameters.AddWithValue("@CartID", CartID);
                var dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    productID = (int)dr["ProductID"];
                }
                conn.Close();
                return productID;
            }
            catch (Exception e1)
            {
                conn.Close();
                return -1;
            }
        }
        public int getQuantityByID(int CartID)
        {
            try
            {
                int quantity = -1;
                conn.Open();
                string url = @"select c.Quantity from tb_Cart c where CartID=@CartID";
                SqlCommand cmd = new SqlCommand(url, conn);
                cmd.Parameters.AddWithValue("@CartID", CartID);
                var dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    quantity = (int)dr["Quantity"];
                }
                conn.Close();
                return quantity;
            }
            catch (Exception e1)
            {
                conn.Close();
                return -1;
            }
        }
        public CART getItemByID(int CartID, int UserID)
        {
            try
            {
                CART cart = null;
                conn.Open();
                string url = @"select p.Name , c.Quantity from tb_cart c
                    inner join tb_Products p on c.ProductID = p.ProductID
                    where CartID=@CartID and UserID=@UserID";
                SqlCommand cmd = new SqlCommand(url, conn);
                cmd.Parameters.AddWithValue("@CartID", CartID);
                cmd.Parameters.AddWithValue("@UserID", UserID);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    cart = new CART
                    {
                        CartID = cart.CartID,
                        UserID = UserID,
                        ProductID = cart.ProductID,
                        Quantity = cart.Quantity
                    };
                }
                cmd.ExecuteNonQuery();
                conn.Close();
                return cart;
            }
            catch (Exception e1)
            {
                conn.Close();
                return null;
            }
        }
        public List<CART> getList(int userID)
        {
            try
            {
                conn.Open();
                List<CART> list = new List<CART>();
                string url = @"select c.CartID, p.Name , c.Quantity from tb_Cart c
                        inner join tb_Products p on c.ProductID = p.ProductID
                        where UserID=@UserID";
                SqlCommand cmd = new SqlCommand(url, conn);
                cmd.Parameters.AddWithValue("@UserID", userID);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    CART cart = new CART
                    {
                        CartID = (int)dr["CartID"],
                        ProductName = (string)dr["Name"],
                        Quantity = (int)dr["Quantity"],
                        //ProductID = (int)dr["ProductID"],
                        //UserID = (int)dr["UserID"],
                    };
                    list.Add(cart);
                }
                conn.Close();
                return list;
            }
            catch (Exception e1)
            {
                return null;
            }
        }
    }
}