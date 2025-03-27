using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_WeddingDressShop.DTO
{
    public class USER
    {
        public int UserID { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string PasswordHash { get; set; }
        public string NumberPhone { get; set; }
        public string Address { get; set; }
        public string Role { get; set; }
        public DateTime CreatedDate { get; set; } = DateTime.Now;

        public USER()
        {
            
        }

        public USER(string fullName, string email, string passwordHash, string numberPhone, string address, string role, DateTime createdDate)
        {
            FullName = fullName;
            Email = email;
            PasswordHash = passwordHash;
            NumberPhone = numberPhone;
            Address = address;
            Role = role;
            CreatedDate = createdDate;
        }
    }
}