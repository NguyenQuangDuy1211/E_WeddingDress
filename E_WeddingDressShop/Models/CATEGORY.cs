using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_WeddingDressShop.Models
{
    public class CATEGORY
    {
        public int CategoryID { get; set; }
        public string CategoryName { get; set; }
        public string Description { get; set; }

        public CATEGORY(int categoryID, string name, string description)
        {
            CategoryID = categoryID;
            CategoryName = name;
            Description = description;
        }

        public CATEGORY()
        {
        }
    }
}