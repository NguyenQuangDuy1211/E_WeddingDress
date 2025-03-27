using E_WeddingDressShop.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace E_WeddingDressShop.Controllers
{
    public class CategoryController
    {
        SqlConnection conn;

        public CategoryController()
        {
            string SqlCon = "Data Source=NQD-DESKTOP\\MSSQLSERVER01;Initial Catalog=E_WeddingDress;Integrated Security=True;TrustServerCertificate=True";
            conn = new SqlConnection(SqlCon);
        }

        private void AddParameters(SqlCommand cmd, CATEGORY cate)
        {
            cmd.Parameters.AddWithValue("@CategoryName", cate.CategoryName);
            cmd.Parameters.AddWithValue("@Description", cate.Description);
        }

        public List<CATEGORY> getListCategory()
        {
            var list = new List<CATEGORY>();
            string sql = "SELECT * FROM tb_Categories";
            SqlCommand cmd = new SqlCommand(sql, conn);
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                CATEGORY cate = new CATEGORY
                {
                    CategoryID = (int)dr["CategoryID"],
                    CategoryName = (string)dr["CategoryName"],
                    Description = (string)dr["Description"]
                };
                list.Add(cate);
            }
            conn.Close();
            return list;
        }
        public string getCategoryNameByID(int categoryID)
        {
            string sql = "SELECT c.CategoryName FROM tb_Categories c WHERE CategoryID = @CategoryID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@CategoryID", categoryID);
            conn.Open();
            string cate = null;
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                cate = (string)dr["CategoryName"];
            }
            conn.Close();
            return cate;
        }
        public CATEGORY getCategoryByID(int categoryID)
        {
            string sql = "SELECT * FROM tb_Categories WHERE CategoryID = @CategoryID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@CategoryID", categoryID);
            conn.Open();
            CATEGORY cate = null;
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                cate = new CATEGORY
                {
                    CategoryID = (int)dr["CategoryID"],
                    CategoryName = (string)dr["CategoryName"],
                    Description = (string)dr["Description"]
                };
            }
            conn.Close();
            return cate;
        }

        public string AddCategory(CATEGORY cate)
        {
            try
            {
                string sql = "INSERT INTO tb_Categories (CategoryName, Description) VALUES (@CategoryName, @Description)";
                SqlCommand cmd = new SqlCommand(sql, conn);
                AddParameters(cmd, cate);
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

        public string UpdateCategory(CATEGORY cate)
        {
            try
            {
                string sql = @"
                UPDATE tb_Categories
                SET CategoryName = @CategoryName, Description = @Description
                WHERE CategoryID = @CategoryID";

                SqlCommand cmd = new SqlCommand(sql, conn);
                AddParameters(cmd, cate);
                cmd.Parameters.AddWithValue("@CategoryID", cate.CategoryID);

                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                conn.Close();

                return rowsAffected > 0 ? "Cập nhật danh mục thành công!" : "Không tìm thấy danh mục để cập nhật!";
            }
            catch (Exception ex)
            {
                conn.Close();
                return "Lỗi: " + ex.Message;
            }
        }

        public string DeleteCategory(int categoryID)
        {
            try
            {
                string sql = "DELETE FROM tb_Categories WHERE CategoryID = @CategoryID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@CategoryID", categoryID);

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
