using System;
using System.Collections.Generic;

namespace solution
{
    public class ProductItem
    {
        
        public int id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public DateTime CreatedAt { get; set; }

        public DateTime UpdatedAt { get; set; }

        public bool Active { get; set; }

        public decimal Price { get; set; }

        public int Category_id { get; set; }

        public List<OtherOptionGroup> groups { get; set; }
    }
}
