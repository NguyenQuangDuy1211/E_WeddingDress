using E_WeddingDressShop.DTO;
using E_WeddingDressShop.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace E_WeddingDressShop.Controllers
{
    public class ProductController
    {
        SqlConnection conn;

        public ProductController()
        {
            string SqlCon = "Data Source=NQD-DESKTOP\\MSSQLSERVER01;Initial Catalog=E_WeddingDress;Integrated Security=True;TrustServerCertificate=True";
            conn = new SqlConnection(SqlCon);
        }

        private void AddProductParameters(SqlCommand cmd, PRODUCT product)
        {
            cmd.Parameters.AddWithValue("@Name", product.Name);
            cmd.Parameters.AddWithValue("@Description", product.Description);
            cmd.Parameters.AddWithValue("@Price", product.Price);
            cmd.Parameters.AddWithValue("@StockQuantity", product.StockQuantity);
            cmd.Parameters.AddWithValue("@ImageUrl", product.ImageUrl);
            cmd.Parameters.AddWithValue("@CreatedDate", product.CreatedDate);
            cmd.Parameters.AddWithValue("@CategoryID", product.CategoryID);
        }

        public List<PRODUCT> getListProduct()
        {
            var list = new List<PRODUCT>();
            string sql = @"SELECT P.ProductID, P.Name, P.Description, P.Price, P.StockQuantity, P.ImageUrl, P.CreatedDate, 
                 P.CategoryID, C.CategoryName
                 FROM tb_Products P 
                 INNER JOIN tb_Categories C ON P.CategoryID = C.CategoryID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                PRODUCT pr = new PRODUCT
                {
                    ProductID = (int)dr["ProductID"],
                    Name = (string)dr["Name"],
                    Description = (string)dr["Description"],
                    Price = Convert.ToDecimal(dr["Price"]),
                    StockQuantity = (int)dr["StockQuantity"],
                    ImageUrl = (string)dr["ImageUrl"],
                    CreatedDate = (DateTime)dr["CreatedDate"],
                    CategoryID = (int)dr["CategoryID"],
                    CategoryName = (string)dr["CategoryName"]
                };
                list.Add(pr);
            }
            conn.Close();
            return list;
        }

        public List<PRODUCT> getListProductBought(int UserID)
        {
            var list = new List<PRODUCT>();
            string sql = @"SELECT 
                P.ProductID, 
                P.Name, 
                P.Description, 
                P.Price,
                od.Quantity, 
                P.StockQuantity, 
                P.ImageUrl, 
                P.CategoryID, 
                C.CategoryName,
                (P.Price * od.Quantity) AS TotalPrice
            FROM tb_Products P 
            INNER JOIN tb_Categories C ON P.CategoryID = C.CategoryID
            INNER JOIN tb_OrderDetails od ON od.ProductID = P.ProductID
            JOIN tb_Orders o ON od.OrderID = o.OrderID
            WHERE o.Status = 'Completed' 
            AND o.UserID =  @UserID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@UserID", UserID);
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                PRODUCT pr = new PRODUCT
                {
                    ProductID = (int)dr["ProductID"],
                    Name = (string)dr["Name"],
                    Description = (string)dr["Description"],
                    Price = Convert.ToDecimal(dr["Price"]),
                    StockQuantity = (int)dr["StockQuantity"],
                    ImageUrl = (string)dr["ImageUrl"],
                    CategoryID = (int)dr["CategoryID"],
                    CategoryName = (string)dr["CategoryName"],
                    Quantity = (int)dr["Quantity"],
                    TotalPrice = (decimal)dr["TotalPrice"],
                };
                list.Add(pr);
            }
            conn.Close();
            return list;
        }

        public PRODUCT getProductByID(int productID)
        {
            string sql = "SELECT * FROM tb_Products WHERE ProductID = @ProductID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@ProductID", productID);
            conn.Open();
            PRODUCT product = null;
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                product = new PRODUCT
                {
                    ProductID = (int)dr["ProductID"],
                    Name = (string)dr["Name"],
                    Description = (string)dr["Description"],
                    Price = Convert.ToDecimal(dr["Price"]),
                    StockQuantity = (int)dr["StockQuantity"],
                    ImageUrl = (string)dr["ImageUrl"],
                    CreatedDate = (DateTime)dr["CreatedDate"],
                    CategoryID = (int)dr["CategoryID"]
                };
            }
            conn.Close();
            return product;
        }
        public void UpdateStockQuantity(int productId, int newQuantity)
        {
            conn.Open();
            string sql = @"UPDATE tb_Products 
                    SET StockQuantity = @newQuantity 
                    WHERE ProductID = @productId";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@newQuantity", newQuantity);
            cmd.Parameters.AddWithValue("@productId", productId);
            cmd.ExecuteNonQuery();
            conn.Close(); 
        }

        public PRODUCT getProductByName(string name)
        {
            string sql = "SELECT * FROM tb_Products WHERE Name Like @Name";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@Name", "%" + name + "%"); ;
            conn.Open();
            PRODUCT product = null;
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                product = new PRODUCT
                {
                    ProductID = (int)dr["ProductID"],
                    Name = (string)dr["Name"],
                    Description = (string)dr["Description"],
                    Price = Convert.ToDecimal(dr["Price"]),
                    StockQuantity = (int)dr["StockQuantity"],
                    ImageUrl = (string)dr["ImageUrl"],
                    CreatedDate = (DateTime)dr["CreatedDate"],
                    CategoryID = (int)dr["CategoryID"]
                };
            }
            conn.Close();
            return product;
        }

        public List<PRODUCT> getListProductByName(string keyword)
        {
            var list = new List<PRODUCT>();
            string sql = @"SELECT P.ProductID, P.Name, P.Description, P.Price, P.StockQuantity, P.ImageUrl, P.CreatedDate, 
                 P.CategoryID, C.CategoryName
                 FROM tb_Products P 
                 INNER JOIN tb_Categories C ON P.CategoryID = C.CategoryID
                 WHERE Name LIKE @Keyword   
                   ";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@Keyword" , "%" + keyword + "%");
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                PRODUCT pr = new PRODUCT
                {
                    ProductID = (int)dr["ProductID"],
                    Name = (string)dr["Name"],
                    Description = (string)dr["Description"],
                    Price = Convert.ToDecimal(dr["Price"]),
                    StockQuantity = (int)dr["StockQuantity"],
                    ImageUrl = (string)dr["ImageUrl"],
                    CreatedDate = (DateTime)dr["CreatedDate"],
                    CategoryID = (int)dr["CategoryID"],
                    CategoryName = (string)dr["CategoryName"]
                };
                list.Add(pr);
            }
            conn.Close();
            return list;
        }

        public List<PRODUCT> getListNewProduct()
        {
            var list = new List<PRODUCT>();
            string sql = @"
                SELECT TOP 5 P.ProductID, P.Name, P.Description, P.Price, P.StockQuantity, P.ImageUrl, P.CreatedDate, 
                       P.CategoryID, C.CategoryName
                FROM tb_Products P 
                INNER JOIN tb_Categories C ON P.CategoryID = C.CategoryID
                ORDER BY P.CreatedDate DESC";
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {

                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    PRODUCT pr = new PRODUCT
                    {
                        ProductID = (int)dr["ProductID"],
                        Name = dr["Name"].ToString(),
                        Description = dr["Description"].ToString(),
                        Price = Convert.ToDecimal(dr["Price"]),
                        StockQuantity = (int)dr["StockQuantity"],
                        ImageUrl = dr["ImageUrl"].ToString(),
                        CreatedDate = (DateTime)dr["CreatedDate"],
                        CategoryID = (int)dr["CategoryID"],
                        CategoryName = dr["CategoryName"].ToString()
                    };
                    list.Add(pr);
                }
                conn.Close();
            }
            return list;
        }

        public decimal getPriceByID(int productID)
        {
            try
            {
                string sql = "SELECT p.Price from tb_Products p WHERE ProductID = @ProductID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@ProductID", productID);
                conn.Open();
                decimal price = -1;
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    price = (decimal)dr["Price"];
                }
                conn.Close();
                return price;
            }
            catch
            {
                conn.Close();
                return 0;
            }
        }
        public PRODUCT getProductByPrice(int toPrice)
        {
            string sql = "SELECT * FROM tb_Products WHERE Price between 0 and @toPrice";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@toPrice", toPrice);
            conn.Open();
            PRODUCT product = null;
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                product = new PRODUCT
                {
                    ProductID = (int)dr["ProductID"],
                    Name = (string)dr["Name"],
                    Description = (string)dr["Description"],
                    Price = Convert.ToDecimal(dr["Price"]),
                    StockQuantity = (int)dr["StockQuantity"],
                    ImageUrl = (string)dr["ImageUrl"],
                    CreatedDate = (DateTime)dr["CreatedDate"],
                    CategoryID = (int)dr["CategoryID"]
                };
            }
            conn.Close();
            return product;
        }

        public string AddProduct(PRODUCT product)
        {
            try
            {
                string sql = "INSERT INTO tb_Products (Name, Description, Price, StockQuantity, ImageUrl, CreatedDate, CategoryID) " +
                             "VALUES (@Name, @Description, @Price, @StockQuantity, @ImageUrl, @CreatedDate, @CategoryID)";
                SqlCommand cmd = new SqlCommand(sql, conn);
                AddProductParameters(cmd, product);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                return "Thêm sản phẩm thành công!";
            }
            catch (Exception ex)
            {
                conn.Close();
                return "Lỗi khi thêm sản phẩm: " + ex.Message;
            }
        }

        public string UpdateProduct(PRODUCT product)
        {
            try
            {
                string sql = "UPDATE tb_Products SET Name = @Name, Description = @Description, Price = @Price, " +
                             "StockQuantity = @StockQuantity, ImageUrl = @ImageUrl, CreatedDate = @CreatedDate, CategoryID = @CategoryID " +
                             "WHERE ProductID = @ProductID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                AddProductParameters(cmd, product);
                cmd.Parameters.AddWithValue("@ProductID", product.ProductID);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                return "Cập nhật sản phẩm thành công!";
            }
            catch (Exception ex)
            {
                conn.Close();
                return "Lỗi khi cập nhật sản phẩm: " + ex.Message;
            }
        }

        public string DeleteProduct(int productID)
        {
            try
            {
                string sql = "DELETE FROM tb_Products WHERE ProductID = @ProductID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@ProductID", productID);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                return "Xóa sản phẩm thành công!";
            }
            catch (Exception ex)
            {
                conn.Close();
                return "Lỗi khi xóa sản phẩm: " + ex.Message;
            }
        }
    }
}
