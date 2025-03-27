using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_WeddingDressShop.Models
{
    public class ORDERDETAILS
    {
        public int OrderDetailID { get; set; }
        public int OrderID { get; set; }
        public int ProductID { get; set; }
        public int Quantity { get; set; }
        public decimal UnitPrice { get; set; }
        public decimal TotalPrice { get; set; }
        public string ImageUrl { get; set; }
        public string ProductName { get; set; }

        public ORDERDETAILS()
        {
            
        }

        public ORDERDETAILS(int orderDetailID, int orderID, int productID, int quantity, decimal unitPrice , decimal totalPrice , string imageUrl , string productName)
        {
            OrderDetailID = orderDetailID;
            OrderID = orderID;
            ProductID = productID;
            Quantity = quantity;
            UnitPrice = unitPrice;
            TotalPrice = totalPrice;
            ImageUrl = imageUrl;
            ProductName = productName;
        }
    }
}