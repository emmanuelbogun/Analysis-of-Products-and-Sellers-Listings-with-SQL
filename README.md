# Analysis-of-Products-and-Sellers-Listings-with-SQL
 
## Introduction
In this project, SQL queries were used to analyze data related to sellers and their listings on an online marketplace.
## Data Injestion
The datasets were imported into the PostgreSQL database automatically after creating the tables manually. The process also involved the extraction of records from the external sources, which were four (4) CSV files, and finally populating the corresponding tables in the database. The tables were named **`brands`**, **`category`**, **`clicks`** and **`listings`** respectively using the internal query tool in pgAdmin. I also ensured the tables had the same column names as those in the csv file.
## Description of the Tables
<br> `listings`: **`id`** column indicates id of the listing started by seller. Completed listings are listings where sellers has finished listing process.</br>
<br> `clicks` : Rich data on behaviour on the listing form. One row is one click made by seller.</br>
<br> `brands` and `categories` : keys for the product attributes. </br>
## Data Analysis
In this section, I wrote SQL queries to answer the following business questions:
- Per customer, show number of total listings started, listings completed and listings sold; order by listings started descending?
- Per customer, if True or False they listed items in Clothing, Bags, Shoes and Accessories categories?
- Per seller: date of their first listing, date of their last listing, date of last sale and name of last action (completed list/sale)?
- Median number of clicks made on listing form for submitted products?
- Per product that was not submitted : last seller's action on listing form?
