using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_WeddingDressShop.Models
{
    public class ORDER
    {
        public int OrderID { get; set; }
        public int UserID { get; set; }
        public string FullName { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public string Status { get; set; }
        public ORDER()
        {
            
        }
        public ORDER(int orderID, int userID, string fullName, DateTime orderDate, decimal totalAmount, string status)
        {
            OrderID = orderID;
            UserID = userID;
            FullName = fullName;
            OrderDate = orderDate;
            TotalAmount = totalAmount;
            Status = status;
        }
    }
}