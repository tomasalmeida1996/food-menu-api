using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using MySql.Data.MySqlClient;
using Dapper;
using System.Data;

namespace solution.Controllers
{
    [ApiController]
    [Route("api/menu")]
    public class MenuController : ControllerBase
    {
        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        private readonly ILogger<MenuController> _logger;

        private MySqlDatabase MySqlDatabase { get; set; }
                
        public MenuController(MySqlDatabase mySqlDatabase)
        {
            this.MySqlDatabase = mySqlDatabase;
        }

        //private List<Category> getCategoriesWithGroups(int menu_id)
        //{
        //    using (MySqlConnection conn = this.MySqlDatabase.Connection)
        //    {
        //        var lookup = new Dictionary<int, Category>();
        //        var lookup2 = new Dictionary<int, OtherOptionGroup>();

        //        var parameters = new { };
        //        var sql = 
        //            "SELECT * " +
        //            "FROM categories cat " +
        //            "left join categoriesotheroptionsgroups coog on  coog.category_id = cat.id" +
        //            "left join otheroptionsgroups oog on coog.otheroptiongroup_id = oog.id" +
        //            //"where id = @Id" +
        //            "";

        //        List<Category> categories = new List<Category>();

        //        //conn.Query<Category, OtherOptionGroup, Category>(sql, (cat,group) =>
        //        //{
        //        //    Category category;
        //        //    if (!lookup.TryGetValue(cat.id, out category))
        //        //    {
        //        //        lookup.Add(cat.id, category = cat);
        //        //    }
        //        //    OtherOptionGroup groups;
        //        //    if (!lookup2.TryGetValue(ol.id, out orderLine))
        //        //    {
        //        //        lookup2.Add(ol.id, orderLine = ol);
        //        //        orderDetail.OrderLines.Add(orderLine);
        //        //    }
        //        //}
        //        //).ToList();

        //        return categories;
        //    }
        //}
        

        private List<OtherOptionGroupItem> getGroupsOptions(int group_id)
        {
            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new { group_id = group_id };
                var sql =
                    " SELECT * FROM otheroptionsgroupsitems" +
                    " where otheroptiongroup_id = @group_id";

                List<OtherOptionGroupItem> options = conn.Query<OtherOptionGroupItem>(sql, parameters).ToList();

                return options;
            }
        }
        private List<OtherOptionGroup> getCategoryItemsGroups(int category_id)
        {
            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new { category_id = category_id };
                var sql =
                    " SELECT oog.* FROM otheroptionsgroups oog" +
                    " left join categoriesotheroptionsgroups coog on coog.otheroptiongroup_id = oog.id" +
                    " where coog.category_id = @category_id";

                List<OtherOptionGroup> items = conn.Query<OtherOptionGroup>(sql, parameters).ToList();

                for (int i = 0; i < items.Count; i++)
                {
                    items[i].options = getGroupsOptions(items[i].id);
                }

                return items;
            }
        }
        private List<Category> getMenuCategories(int menu_id)
        {            
            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new { menu_id = menu_id };
                var sql = "SELECT * FROM categories where active = 1 and menu_id = @menu_id";
                List <Category> categories = conn.Query<Category>(sql,parameters).ToList();
                return categories;
            }            
        }

        private List<OtherOptionGroup> getProductItemsGroups(int productitem_id)
        {
            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new { productitem_id = productitem_id };
                var sql = 
                    " SELECT * FROM otheroptionsgroups oog" +
                    " left join productsitemsotheroptionsgroups poog on poog.otheroptiongroup_id = oog.id" +
                    " where poog.productItem_id = @productitem_id";

                List<OtherOptionGroup> items = conn.Query<OtherOptionGroup>(sql, parameters).ToList();

                for (int i = 0; i < items.Count; i++)
                {
                    items[i].options = getGroupsOptions(items[i].id);
                }

                return items;
            }
        }
        private List<ProductItem> getCategoryItems(int category_id)
        {
            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new { category_id = category_id };
                var sql = "SELECT * FROM productItems where category_id = @category_id";
                List <ProductItem> items = conn.Query<ProductItem>(sql,parameters).ToList();

                for (int i = 0; i < items.Count; i++)
                {
                    items[i].groups = getProductItemsGroups(items[i].id);
                }

                return items;
            }
        }

        /// <summary>
        /// Retrieves a list of available menus
        /// </summary>
        /// <response code="200">Menus available</response>
        [HttpGet]
        public List<Menu> GetMenu()
        {            
            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {                
                List<Menu> menu = conn.Query<Menu>("SELECT * FROM menus where active = 1").ToList();
                return menu;
            }
        }
        [HttpGet("{id:long}")]
        public Menu GetMenuById(int id)
        {            
            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new { Id = id };
                var sql = "SELECT * FROM menus where id = @Id";

                Menu menu = conn.Query<Menu>(sql, parameters).First();
                return menu;
            }
        }
        [HttpGet("{id:long}/complete")]
        public Menu GetCompleteMenu(int id)
        {
            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {                
                var parameters = new { Id = id };
                var sql = "SELECT * FROM menus where id = @Id";

                Menu menu = conn.Query<Menu>(sql, parameters).First();
                menu.categories = getMenuCategories(id);
                                
                for (int i = 0; i < menu.categories.Count; i++)
                {
                    menu.categories[i].items = getCategoryItems(menu.categories[i].id); //get items
                    menu.categories[i].groups = getCategoryItemsGroups(menu.categories[i].id); //get groups
                }
                
                return menu;
            }
        }
        //[HttpGet("{menu_id:long}/categories")]
        //public List<Category> GetMenuCategories(int menu_id)
        //{
        //    using (MySqlConnection conn = this.MySqlDatabase.Connection)
        //    {
        //        List<Category> categories = getMenuCategories(menu_id);
        //        return categories;
        //    }
        //}

        //CATEGORY OPERATIONS
        [HttpGet("{menu_id:long}/categories")]
        public async Task<IActionResult> GetMenuCategories(int menu_id)
        {
            try
            {
                if (menu_id == 0)
                    return BadRequest();
                
                using (MySqlConnection conn = this.MySqlDatabase.Connection)
                {
                    var parameters = new { menu_id = menu_id };
                    var sql = "select * from categories where active = 1 and menu_id = @menu_id";

                    var categories = await conn.QueryAsync<Category>(sql, parameters);

                    return Ok(categories.ToList());
                }
            }
            catch (Exception ex)
            {
                //log error
                return StatusCode(500, "Error retrieving categories!");
            }
        }
        [HttpPost("{menu_id:long}/categories")]
        public IActionResult AddCategory(int menu_id, Category category)
        {            
            if (menu_id == 0)
                return BadRequest();

            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new DynamicParameters();
                parameters.Add("Name", category.Name, DbType.String);
                parameters.Add("Description", category.Description, DbType.String);
                parameters.Add("Menu_id", menu_id, DbType.Int32);
                var query = 
                    " INSERT INTO categories (Name, Description, menu_id) VALUES (@Name, @Description, @Menu_id); " +
                    " SELECT LAST_INSERT_ID() ";

                int newCategoryId = conn.QuerySingle<int>(query, parameters);
                category.id = newCategoryId;
                category.Active = true;

                return Ok(category);
            }            
        }
        [HttpPut("{menu_id:long}/categories/{category_id:long}")]
        public IActionResult UpdateCategory(int menu_id, int category_id, Category category)
        {
            if (menu_id == 0 || category_id == 0)
                return BadRequest();

            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new DynamicParameters();
                parameters.Add("Name", category.Name, DbType.String);
                parameters.Add("Description", category.Description, DbType.String);
                parameters.Add("Active", category.Active, DbType.Boolean);
                parameters.Add("category_id", category_id, DbType.Int32);
                var query =
                    " UPDATE categories set Name = @Name, Description = @Description, Active = @Active where id = @category_id; " +
                    " SELECT * from categories where id = @category_id";

                Category newCategory = conn.QuerySingle<Category>(query, parameters);               

                return Ok(newCategory);
            }

        }
        [HttpDelete("{menu_id:long}/categories/{category_id:long}")]
        public IActionResult DeleteCategory(int menu_id, int category_id)
        {
            if (menu_id == 0 || category_id == 0)
                return BadRequest();

            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new { category_id = category_id, menu_id = menu_id };
                var query =
                    " delete from categoriesotheroptionsgroups where category_id = @category_id ;" +
                    " update productItems set category_id = null where category_id = @category_id ;" +
                    " delete from categories where id = @category_id and menu_id = @menu_id ;";                   

                int records = conn.Execute(query, parameters);
                
                return Ok(records);
            }

        }

        //PRODUCT OPERATIONS
        [HttpGet("{menu_id:long}/categories/{category_id:long}/products")]
        public IActionResult GetCategoryProducts(int menu_id, int category_id)
        {
            if (menu_id == 0 || category_id == 0)
                return BadRequest();

            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                List<ProductItem> products = getCategoryItems(category_id);
                
                return Ok(products);
            }
        }
        [HttpPost("{menu_id:long}/categories/{category_id:long}/products")]
        public IActionResult AddProduct(int menu_id, int category_id, ProductItem product)
        {
            if (menu_id == 0 || category_id == 0)
                return BadRequest();

            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new DynamicParameters();
                parameters.Add("Name", product.Name, DbType.String);
                parameters.Add("Description", product.Description, DbType.String);
                parameters.Add("Price", product.Price, DbType.Decimal);
                parameters.Add("Category_id", category_id, DbType.Int32);
                var query =
                    " INSERT INTO ProductItems (Name, Description, Price, Category_id) VALUES (@Name, @Description, @Price, @Category_id); " +
                    " SELECT LAST_INSERT_ID() ";

                int newCategoryId = conn.QuerySingle<int>(query, parameters);
                product.id = newCategoryId;
                product.Active = true;
                product.Category_id = category_id;

                return Ok(product);
            }
        }
        [HttpPut("{menu_id:long}/categories/{category_id:long}/products/{product_id:long}")]
        public IActionResult UpdateProduct(int menu_id, int category_id, Category category)
        {
            if (menu_id == 0 || category_id == 0)
                return BadRequest();

            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new DynamicParameters();
                parameters.Add("Name", category.Name, DbType.String);
                parameters.Add("Description", category.Description, DbType.String);
                parameters.Add("Active", category.Active, DbType.Boolean);
                parameters.Add("category_id", category_id, DbType.Int32);
                var query =
                    " UPDATE productItems set Name = @Name, Description = @Description, Active = @Active where id = @category_id; " +
                    " SELECT * from categories where id = @category_id";

                Category newCategory = conn.QuerySingle<Category>(query, parameters);

                return Ok(newCategory);
            }

        }
        [HttpPost("{menu_id:long}/categories/{category_id:long}/products/{product_id:long}/remove")]
        public IActionResult RemoveProductFromCategory(int menu_id, int category_id, int product_id)
        {
            if (menu_id == 0 || category_id == 0 || product_id == 0)
                return BadRequest();

            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new { category_id = category_id, product_id = product_id };
                var query =                    
                    " update productItems set category_id = null where id = @product_id and category_id = @category_id ;";

                int records = conn.Execute(query, parameters);

                return Ok(records);
            }

        }
        [HttpPost("{menu_id:long}/categories/{category_id:long}/products/{product_id:long}/add")]
        public IActionResult AddProductFromCategory(int menu_id, int category_id, int product_id)
        {
            if (menu_id == 0 || category_id == 0 || product_id == 0)
                return BadRequest();

            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new { category_id = category_id, product_id = product_id };
                var query =
                    " update productItems set category_id = @category_id where id = @product_id ;";

                int records = conn.Execute(query, parameters);

                return Ok(records);
            }

        }
        [HttpDelete("products/{product_id:long}")]
        public IActionResult DeleteProduct(int product_id)
        {
            if (product_id == 0)
                return BadRequest();

            using (MySqlConnection conn = this.MySqlDatabase.Connection)
            {
                var parameters = new { product_id = product_id };
                var query =
                    " delete from productsitemsotheroptionsgroups where productitem_id = @product_id ;" +
                    " delete from productItems where id = @product_id ;";

                int records = conn.Execute(query, parameters);

                return Ok(records);
            }

        }
    }
}
