# food-menu-api
Food Menu management API. Technologies used: .Net Core 5, Dapper, MySql

# Quick Start

## Setup 

- create database locally (with name foodmenu) and import the data with info that is in the .sql file on folder ./solution/data.
- run solution
- acess swagger methods on https://localhost:44315/swagger/index.html
- postman collection available in postman folder 
- get complete menu list with the postman "get complete menu" endpoint or => https://localhost:44315/api/menu/1/complete


## Features

- API endpoints for CRUD operations.
- MySql Database setup.
- Swagger documentation.
- Postman collection.
- Unit tests.


### Things that could be improved

- automated unit tests are not done.
- config and connection string should be in a separate file (ex. webconfig.config).
- api methods with joins (ex: categories with items) should be done with dapper maps instead of doing the properties mapping in the code with loops.
- api methods should have a cleaner and fullproof implementation (with async and ActionResult management), just like exemplified in the endpoint https://localhost:44315/api/menu/1/categories
- connection table between groups and categories or products are in two separate relation tables (productsitemsotheroptionsgroups and categoriesotheroptionsgroups) but they could be in one single table with two foreign keys, productitem_id and category_id respectively.
