using System;
using System.Collections.Generic;

namespace solution
{
    public class Category
    {
        
        public int id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public DateTime CreatedAt { get; set; }

        public DateTime UpdatedAt { get; set; }

        public bool Active { get; set; }

        //public int Menu_id { get; set; }        

        public List<ProductItem> items { get; set; }
        
        public List<OtherOptionGroup> groups { get; set; }
    }
}
