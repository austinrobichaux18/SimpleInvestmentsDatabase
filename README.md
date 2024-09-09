# SimpleSqlDatabaseAssignment
 
# What is this Application?
This is a .sql file datatbase that satisfies the below directions. 
It creates the database, stored procedures, and views to store the queries.

# How to run this application
Open SSMS and create a new database named "InvestmentsDatabase"  
Open a new Query window within the new database  
Open the contents of the .sql file in this repo, or copy/paste the contents into the query window   
Run the Query  
Go to Programability > Stored Procedures > and Right click Execute the "Intialize and Reset Database" Stored Procedure.  
	Run this procedure.  
See that you now have 3 tables, 2 views, and 4 stored procedures.  
The tables should have data in them that came from the SeedData Stored Procedure  

If you want to Reset to the default data at any point, execute the "Intialize and Reset Database" Stored Procedure.  

# Tables  
## View the Code  
Right click the "Intialize and Reset Database" Stored Procedure and select "Modify" to view the table creation code and the data seeding execution  
## View the Results  
Right click a table and select top 1000 rows to view data   

# Stored Procedures  
## View the Code  
Right click the Stored Procedure and select "Modify"   
## View the Results   
Right click the Stored Procedure and select "Execute Stored Procedure"  
Optional: Enter VALUE on the top right if needed   
Click OK  

# Views
## View the Code  
Right click the View > Script View As> Alter To > New query editor window  
## View the Results  
Right click a table and select top 1000 rows to view data  



# Original Directions
Imagine we are setting up a database for an investment firm the investment firm only has a few clients that are sharing investments in a handful of products, so the requirements are as follows.  

We need three tables:  
Clients - Includes a primary key ID and a name.  
Products – Includes a primary key ID and a name.  
Investments – Includes a primary key ID, a foreign key for a client, a foreign key for a product and an Amount in USD that is invested in a product.  

Your task is to create these three tables, populate them with a small amount of test data, and create the following stored procedures and queries.  

1. A stored procedure that returns the name of the product and the name of the client for a given investment ID  
2. A stored procedure that returns the name of each client and the product they have invested more than an X amount in.  
3. A query that returns the total investment amount for each client.  
4. A query that returns 3 products that have the highest investment amount, ordered from most to least.  

Make sure that your submission includes your finished tables, along with the records used and the procedures and queries marked with the proper number.  