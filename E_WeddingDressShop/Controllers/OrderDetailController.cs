using E_WeddingDressShop.DTO;
using E_WeddingDressShop.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace E_WeddingDressShop.Controllers
{
    public class OrderDetailController
    {
        SqlConnection conn;

        public OrderDetailController()
        {
            string SqlCon = "Data Source=bekend\\sqlexpress;Initial Catalog=E_WeddingDress;Integrated Security=True;TrustServerCertificate=True";
            conn = new SqlConnection(SqlCon);
        }
        private void AddParameters(SqlCommand cmd, ORDERDETAILS order)
        {
            cmd.Parameters.AddWithValue("@OrderID", order.OrderID);
            cmd.Parameters.AddWithValue("@ProductID", order.ProductID);
            cmd.Parameters.AddWithValue("@Quantity", order.Quantity);
            cmd.Parameters.AddWithValue("@UnitPrice", order.UnitPrice);
        }
        public List<ORDERDETAILS> getListOrderDetail(ORDERDETAILS od)
        {
            var list = new List<ORDERDETAILS>();
            string sql = @"SELECT * from tb_OrderDetails where Product = @ProductID and OrderID = @OrderID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@ProductID", od.ProductID);
            cmd.Parameters.AddWithValue("@OrderID", od.OrderID);
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ORDERDETAILS cate = new ORDERDETAILS
                {
                    OrderID = (int)dr["OrderID"],
                    ProductID = (int)dr["ProductID"],
                    Quantity = (int)dr["Quantity"],
                    UnitPrice = (decimal)dr["UnitPrice"],
                };
                list.Add(cate);
            }
            conn.Close();
            return list;
        }

        public string AddOderDetail(ORDERDETAILS od) {
            try
            {
                string sql = "INSERT INTO tb_OrderDetails (OrderID, ProductID , Quantity , UnitPrice) VALUES (@OrderID , @ProductID, @Quantity , @UnitPrice)";
                SqlCommand cmd = new SqlCommand(sql, conn);
                AddParameters(cmd, od);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                return "Thêm danh mục thành công!";
            }
            catch (Exception ex)
            {
                conn.Close();
                return "Lỗi: " + ex.Message;
            }
        }

        public List<ORDERDETAILS> getOrderDetailsByOrderId(int orderId)
        {
            var list = new List<ORDERDETAILS>();
            string sql = @"
                SELECT od.ProductID, p.Name AS ProductName, od.Quantity, od.UnitPrice, (od.Quantity * od.UnitPrice) AS TotalPrice, p.ImageUrl
                FROM tb_OrderDetails od
                JOIN tb_Products p ON od.ProductID = p.ProductID
                WHERE od.OrderID = @OrderID";

            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@OrderID", orderId);

            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ORDERDETAILS odd = new ORDERDETAILS
                {
                    ProductID = (int)dr["ProductID"],
                    ProductName = (string)dr["ProductName"],
                    Quantity = (int)dr["Quantity"],
                    UnitPrice = Convert.ToDecimal(dr["UnitPrice"]),
                    TotalPrice = Convert.ToDecimal(dr["TotalPrice"]),
                    ImageUrl = (string)dr["ImageUrl"] 
                };
                list.Add(odd);
            }
            conn.Close();

            return list;
        }

    }
}