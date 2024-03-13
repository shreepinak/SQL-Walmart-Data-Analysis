# SQL-Walmart-data-analysis
# Dataset: Taken from the Kaggle Walmart Sales Forecasting Competition. [source](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)
# Aim: To analyze sales of different branches of Walmart.
# Systematic Procedure: 
1)	Data Wrangling:
•	Build & arrange the data in csv file. 
•	Formulae used to calculate new headings.
•	Importing the data in MYSQL & setting “NOT NULL” for each field to filter out null values.

2)	Formulae used (In $):
•	COGS = unitsPrice * quantity 
•	VAT = 5\% * COGS
•	total(gross_sales) = VAT + COGS
•	grossProfit(grossIncome) = total(gross_sales) – COGS
•	Gross Margin = (gross income/total revenue) *100

3)	Feature Engineering:
•	Add a new column named `time_of_day` to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
•	Add a new column named `day_name` that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.
•	Add a new column named `month_name` that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.
# Analysis: Listed questions, code and solutions provided in the file for below analysis. 
1) Product analysis to help understand product line performance & to make better decisions. 
2) Sales analysis to help evaluate product demand & improve sales strategies. 
3) Customer analysis to structure existing customer base & identify the need of customers.
