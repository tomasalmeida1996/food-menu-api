using System;
using System.Collections.Generic;

namespace solution
{
    public class Menu
    {
        
        public int id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public string Currency { get; set; }

        //public DateTime CreatedAt { get; set; }

        //public DateTime UpdatedAt { get; set; }

        public bool Active { get; set; }

        public List<Category> categories { get; set; }
    }
}
