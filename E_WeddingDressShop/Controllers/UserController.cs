using E_WeddingDressShop.DTO;
using E_WeddingDressShop.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.EnterpriseServices.Internal;
using System.Security.Cryptography;
using System.Text;
using System.Web.ApplicationServices;

namespace E_WeddingDressShop.Controllers
{
    public class UserController
    {
        private readonly string SqlCon = "Data Source=NQD-DESKTOP\\MSSQLSERVER01;Initial Catalog=E_WeddingDress;Integrated Security=True;TrustServerCertificate=True";

        public string RegisterUser(USER us)
        {
            try
            {
                using (var conn = new SqlConnection(SqlCon))
                {
                    conn.Open();

                    // Check nếu email đã tồn tại
                    string isEmailExisting = "SELECT COUNT(*) FROM tb_Users WHERE Email = @Email";
                    using (SqlCommand checkCmd = new SqlCommand(isEmailExisting, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Email", us.Email);
                        int userCount = (int)checkCmd.ExecuteScalar();

                        if (userCount > 0)
                        {
                            return "Email đã được đăng ký!";
                        }
                    }

                    // Băm mật khẩu trước khi lưu vào cơ sở dữ liệu
                    us.PasswordHash = HashPassword(us.PasswordHash);

                    // Thêm người dùng mới
                    string insertQuery = @"
                    INSERT INTO tb_Users (FullName, Email, PasswordHash, NumberPhone, Address, Role, CreatedDate) 
                    VALUES (@FullName, @Email, @PasswordHash, @NumberPhone, @Address, @Role, @CreatedDate)";
                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        AddUserParameters(cmd, us);
                        cmd.ExecuteNonQuery();
                    }
                }
                return "Đăng ký thành công!";
            }
            catch (Exception ex)
            {
                return "Lỗi: Không thể thực hiện đăng ký. Vui lòng thử lại. " + ex.Message;
            }
        }

        public string LoginUser(string email, string plainPassword)
        {

            try
            {
                using (var conn = new SqlConnection(SqlCon))
                {
                    conn.Open();

                    string query = "SELECT UserID, FullName, PasswordHash, Role FROM tb_Users WHERE Email = @Email";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                reader.Read();
                                string storedPasswordHash = (reader["PasswordHash"].ToString()).Trim() as string;

                                if (VerifyPassword(plainPassword, storedPasswordHash))
                                {

                                    return "Đăng nhập thành công!";
                                }
                                else
                                {
                                    return "Mật khẩu không đúng!";
                                }
                            }
                            else
                            {
                                // Không tìm thấy email
                                return "Email không tồn tại!";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Lỗi: Không thể thực hiện đăng nhập: " + ex.Message;
            }
        }

        public string UpdateUserRoleToAdmin(int userID)
        {
            try
            {
                using (var conn = new SqlConnection(SqlCon))
                {
                    conn.Open();
                    string sql = @"
                    UPDATE tb_Users
                    SET Role = 'Admin'
                    WHERE UserID = @UserID";

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    conn.Close();

                    return rowsAffected > 0 ? "Cập nhật người dùng thành công!" : "Không tìm thấy người dùng để cập nhật!";
                }
            }
            catch (Exception ex)
            {
                return "Lỗi: " + ex.Message;
            }
        }

        public string RemoveUserRole(int userID)
        {
            try
            {
                using (var conn = new SqlConnection(SqlCon))
                {
                    conn.Open();
                    string sql = @"
                    UPDATE tb_Users
                    SET Role = 'User'
                    WHERE UserID = @UserID";

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    conn.Close();

                    return rowsAffected > 0 ? "Cập nhật người dùng thành công!" : "Không tìm thấy người dùng để cập nhật!";
                }
            }
            catch (Exception ex)
            {
                return "Lỗi: " + ex.Message;
            }
        }

        public string UpdateUser(USER us)
        {
            try
            {
                using (var conn = new SqlConnection(SqlCon))
                {
                    conn.Open();

                    string updateQuery = @"
                    UPDATE tb_Users 
                    SET FullName = @FullName, Email = @Email, PasswordHash = @PasswordHash, 
                        NumberPhone = @NumberPhone, Address = @Address, Role = @Role, CreatedDate = @CreatedDate 
                    WHERE UserID = @UserID";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        AddUserParameters(cmd, us);
                        cmd.Parameters.AddWithValue("@UserID", us.UserID);
                        cmd.ExecuteNonQuery();
                    }
                }
                return "Cập nhật thành công!";
            }
            catch (Exception ex)
            {
                return "Lỗi: Không thể cập nhật thông tin người dùng. Vui lòng thử lại. " + ex.Message;
            }
        }

        public int getUserByEmail(string email)
        {
            int result = -1; 
            using (var conn = new SqlConnection(SqlCon))
            {
                string sql = "SELECT UserID , FullName FROM tb_Users WHERE Email = @Email";
                var cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                var dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    result = (int)dr["UserID"];
                }
                conn.Close();
            }
            return result;
        }

        public USER getUserByUserID(int userId)
        {
            using (var conn = new SqlConnection(SqlCon))
            {
                string sql = "SELECT FullName , Role FROM tb_Users WHERE UserID = @UserID";
                var cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);
                USER user = null;
                conn.Open();
                var dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    user = new USER
                    {
                        Role = (string)dr["Role"],
                        FullName = (string)dr["FullName"]
                    };
                }
                conn.Close();
                return user;
            }
        }

        private void AddUserParameters(SqlCommand cmd, USER user)
        {
            cmd.Parameters.Add("@FullName", SqlDbType.NVarChar).Value = user.FullName;
            cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = user.Email;
            cmd.Parameters.Add("@PasswordHash", SqlDbType.NVarChar).Value = user.PasswordHash;
            cmd.Parameters.Add("@NumberPhone", SqlDbType.NVarChar).Value = user.NumberPhone;
            cmd.Parameters.Add("@Address", SqlDbType.NVarChar).Value = user.Address;
            cmd.Parameters.Add("@Role", SqlDbType.NVarChar).Value = user.Role;
            cmd.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = user.CreatedDate;
        }

        public string HashPassword(string password)
        {
            using (var sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private bool VerifyPassword(string plainPassword, string storedHash)
        {
            String hashOfInput = HashPassword(plainPassword).Trim();

            // return hashOfInput.Equals(storedHash); 
            return hashOfInput.Equals(storedHash.Trim(), StringComparison.OrdinalIgnoreCase);
        }

        public List<USER> getListUser()
        {
            List<USER> users = new List<USER>();

            try
            {
                string query = "SELECT UserID, FullName, Email, NumberPhone, Address , Role FROM tb_Users";
                using (SqlConnection con = new SqlConnection(SqlCon))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            USER us = new USER
                            {
                                UserID = dr["UserID"] != DBNull.Value ? (int)dr["UserID"] : 0,
                                FullName = dr["FullName"]?.ToString(),
                                Email = dr["Email"]?.ToString(),
                                NumberPhone = dr["NumberPhone"]?.ToString(),
                                Address = dr["Address"]?.ToString(),
                                Role = dr["Role"]?.ToString()
                            };

                            users.Add(us);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Lỗi khi lấy danh sách người dùng: " + ex.Message);
            }

            return users;
        }


        public List<USER> getListUserByKeyword(string keyword)
        {
            using (var conn = new SqlConnection(SqlCon))
            {
                conn.Open();
                var list = new List<USER>();
                string sql = @"SELECT * FROM tb_Users WHERE FullName LIKE @keyword";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@keyword", $"%{keyword}%");

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    USER us = new USER
                    {
                        UserID = dr["UserID"] != DBNull.Value ? (int)dr["UserID"] : 0,
                        FullName = dr["FullName"] != DBNull.Value ? dr["FullName"].ToString() : string.Empty,
                        Email = dr["Email"] != DBNull.Value ? dr["Email"].ToString() : string.Empty,
                        NumberPhone = dr["NumberPhone"] != DBNull.Value ? dr["NumberPhone"].ToString() : string.Empty,
                        Address = dr["Address"] != DBNull.Value ? dr["Address"].ToString() : string.Empty,
                        Role = dr["Role"] != DBNull.Value ? dr["Role"].ToString() : string.Empty,
                        CreatedDate = dr["CreatedDate"] != DBNull.Value ? (DateTime)dr["CreatedDate"] : DateTime.MinValue,
                    };
                    list.Add(us);
                }
                conn.Close();
                return list;
            }
        }
        public int getUserByID(string email)
        {
            int result = -1;
            using (var conn = new SqlConnection(SqlCon))
            {
                string sql = "SELECT UserID , FullName FROM tb_Users WHERE Email = @Email";
                var cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                conn.Open();
                var dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    result = (int)dr["UserID"];
                }
                conn.Close();
            }
            return result;
        }

        public USER layUserByUserID(int userId)
        {
            using (var conn = new SqlConnection(SqlCon))
            {
                string sql = "SELECT * FROM tb_Users WHERE UserID = @UserID";
                var cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);
                USER user = new USER();
                conn.Open();
                var dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    user.UserID = (int)dr["UserID"];
                    user.FullName = (string)dr["FullName"];
                    user.NumberPhone = (string)dr["NumberPhone"];
                    user.Email = (string)dr["Email"];
                    user.Address = (string)dr["Address"];
                    user.PasswordHash = (string)dr["PasswordHash"];
                    user.CreatedDate = (DateTime)dr["CreatedDate"];
                    user.Role = (string)dr["Role"];
                }
                conn.Close();
                return user;
            }
        }
    }
}
