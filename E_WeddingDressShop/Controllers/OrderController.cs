using E_WeddingDressShop.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace E_WeddingDressShop.Controllers
{
    public class OrderController
    {
        SqlConnection conn;

        public OrderController()
        {
            string SqlCon = "Data Source=NQD-DESKTOP\\MSSQLSERVER01;Initial Catalog=E_WeddingDress;Integrated Security=True;TrustServerCertificate=True";
            conn = new SqlConnection(SqlCon);
        }

        private void AddParameters(SqlCommand cmd, ORDER order)
        {
            cmd.Parameters.AddWithValue("@UserID", order.UserID);
            cmd.Parameters.AddWithValue("@OrderDate", order.OrderDate);
            cmd.Parameters.AddWithValue("@TotalAmount", order.TotalAmount);
            cmd.Parameters.AddWithValue("@Status", order.Status);
        }

        public List<ORDER> getListOrderForClient(int userID)
        {
            var list = new List<ORDER>();
            string sql = @"SELECT * from tb_Orders where UserID = @UserID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@UserID", userID);
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ORDER cate = new ORDER
                {
                    OrderID = (int)dr["OrderID"],
                    OrderDate = (DateTime)dr["OrderDate"],
                    TotalAmount = (decimal)dr["TotalAmount"],
                    Status = (string)dr["Status"],
                    UserID = (int)dr["UserID"],
                };
                list.Add(cate);
            }
            conn.Close();
            return list;
        }

        public List<ORDER> getListOrder()
        {
            var list = new List<ORDER>();
            string sql = "SELECT o.OrderID ,o.UserID , u.FullName , o.TotalAmount, o.OrderDate , o.Status  FROM tb_Orders o\r\ninner join tb_Users u on u.UserID = o.UserID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ORDER cate = new ORDER
                {
                    OrderID = (int)dr["OrderID"],
                    OrderDate = (DateTime)dr["OrderDate"],
                    TotalAmount = (decimal)dr["TotalAmount"],
                    Status = (string)dr["Status"],
                    UserID = (int)dr["UserID"],
                    FullName = (string)dr["FullName"]
                };
                list.Add(cate);
            }
            conn.Close();
            return list;
        }

        public ORDER getORDERByID(int ORDERID)
        {
            string sql = @"SELECT o.OrderID , o.UserID , u.FullName , o.TotalAmount, o.OrderDate , o.Status  FROM tb_Orders o
                inner join tb_Users u on u.UserID = o.UserID WHERE OrderID = @ORDERID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@ORDERID", ORDERID);
            conn.Open();
            ORDER cate = null;
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                cate = new ORDER
                {
                    OrderID = (int)dr["OrderID"],
                    OrderDate = (DateTime)dr["OrderDate"],
                    TotalAmount = (decimal)dr["TotalAmount"],
                    Status = (string)dr["Status"],
                    UserID = (int)dr["UserID"],
                    FullName = (string)dr["FullName"]
                };
            }
            conn.Close();
            return cate;
        }

        public int AddORDER(ORDER order)
        {
            try
            {
                using (var conn = new SqlConnection("Data Source=bekend\\sqlexpress;Initial Catalog=E_WeddingDress;Integrated Security=True;TrustServerCertificate=True"))
                {
                    conn.Open();
                    string sql = @"
                    INSERT INTO tb_Orders (UserID, OrderDate, Status, TotalAmount)
                    VALUES (@UserID, @OrderDate, @Status, @TotalAmount);

                    SELECT SCOPE_IDENTITY();"; 

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@UserID", order.UserID);
                    cmd.Parameters.AddWithValue("@OrderDate", order.OrderDate);
                    cmd.Parameters.AddWithValue("@Status", order.Status);
                    cmd.Parameters.AddWithValue("@TotalAmount", order.TotalAmount);

                    int orderId = Convert.ToInt32(cmd.ExecuteScalar());  
                    return orderId;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Lỗi khi thêm đơn hàng: " + ex.Message);
            }
        }
        public string UpdateORDER(ORDER cate)
        {
            try
            {
                string sql = @"
                UPDATE tb_Orders
                SET OrderDate = @OrderDate, TotalAmount = @TotalAmount,
                Status = @Status
                WHERE OrderID = @ORDERID";

                SqlCommand cmd = new SqlCommand(sql, conn);
                AddParameters(cmd, cate);
                cmd.Parameters.AddWithValue("@ORDERID", cate.OrderID);

                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                conn.Close();

                return rowsAffected > 0 ? "Cập nhật đơn hàng thành công!" : "Không tìm thấy đơn hàng để cập nhật!";
            }
            catch (Exception ex)
            {
                conn.Close();
                return "Lỗi: " + ex.Message;
            }
        }

        public string DeleteORDER(int ORDERID)
        {
            try
            {
                string sql = "DELETE FROM tb_Orders WHERE OrderID = @ORDERID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@ORDERID", ORDERID);

                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                conn.Close();

                return rowsAffected > 0 ? "Xóa danh mục thành công!" : "Không tìm thấy danh mục để xóa!";
            }
            catch (Exception ex)
            {
                conn.Close();
                return "Lỗi: " + ex.Message;
            }
        }
    }
}