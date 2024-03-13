select * from walmartsales.sales;

-- ------------------Feature Engineering---------------------------------------------
-- ------------------Add Time_of_day column-----------------------------------------
select
	time,
	(case
		when `time` between "00:00:00" and "12:00:00" then "Morning"
        when `time` between "12:01:00" and "16:00:00" then "Afternoon"
        else "Evening"
    end) as time_of_day
from sales;

alter table sales add column time_of_day varchar(20)

update sales
set time_of_day = (
case
		when `time` between "00:00:00" and "12:00:00" then "Morning"
        when `time` between "12:01:00" and "16:00:00" then "Afternoon"
        else "Evening"
end
);

-- --------------------day_name----------------------------------------
select 
     date,
     dayname(date) as day_name
from sales;

alter table sales add column day_name varchar(10)

update sales
set day_name = dayname(date);

-- -------------------month_name-----------------------------------------
select 
     date,
     monthname(date) as month_name
from sales;

alter table sales add column month_name varchar(10);

update sales
set month_name = monthname(date);

-- -----------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------
-- --------------------Generic--------------------------------------------------------------
-- ------1. How many unique cities does the data have?----
select
      distinct city
from sales;
-- ------ Answer : There are 3 unique cities--------

-- ------2. In which city is each branch?----------------
select
      distinct city,branch
from sales;

-- ---------------------Product------------------------------------------------------------
-- ------1. How many unique product lines does the data have?
select
      count(distinct Product_line)
from sales;
-- ------Ans : There are 6 distinct product lines

-- ------2. What is the most common payment method?
select 
      payment,
      count(payment) as cnt
from sales
group by payment
order by cnt desc;
-- ------Ans: Most common payment method is Ewallet

-- -------3. What is the most selling product line?
select
      product_line,
      count(Product_line) as cnt
from sales
group by product_line
order by cnt desc;
-- -------Ans : The most selling product line is Fashion accessories.

-- -------4. What is the total revenue by month?
select
      month_name as month,
      sum(total) as total_revenue
from sales
group by month_name
order by total_revenue desc;

-- -------5. What month had the largest COGS?
select
      month_name as month,
      sum(cogs) as total_cogs
from sales
group by month_name
order by total_cogs desc;
-- -------Ans : largest COGS is in the month of Jan with $ 110754.16

-- -------6. What product line had the largest revenue?
select
      product_line,
      sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc;
-- -------Ans:  Food & beverages had the largest revenue with $56144.84

-- -------7. What is the city with the largest revenue?
select
      city,
      sum(total) as total_revenue
from sales
group by city
order by total_revenue desc;
-- -------Ans: Naypyitaw with revenue $110568.71

-- -------8. What product line had the largest VAT?
select
      product_line,
      avg(VAT) as avg_tax
from sales
group by product_line
order by avg_tax desc;
-- ------Ans: Home and lifestyle with avg VAT of $16.03

-- ----9.Fetch each product line and add a column to those product line showing 
-- ----"Good", "Bad". Good if its greater than average sales
select
      Product_line,
      case
           when avg(quantity)> 6 then "Good"
           else "Bad"
	  end as remark
from sales
group by Product_line;
-- -----Ans: All product lines have sales less than average sales

-- -----10. Which branch sold more products than average product sold?
select
      branch,
      sum(Quantity) as qty
from sales
group by branch
having sum(Quantity) > (select avg(Quantity) FROM sales);
-- -----Ans: A branch sold more products than average product sold.

-- -----11. What is the most common product line by gender?
select
      Gender,
      Product_line,
      count(Gender) as total_cnt
from sales
group by Gender, Product_line
order by Total_cnt desc;
-- -----Ans: Fashion accessories is the most common product line preferred by females.

-- ------12. What is the average rating of each product line?
select
      Product_line,
      round(avg(rating),2) as avg_rating
from sales
group by Product_line;

-- ----------------------------------Sales---------------------------------------------
-- --------------1. Number of sales made in each time of the day per weekday
select
      time_of_day,
      count(*) as total_sales
from sales
where day_name = "Sunday"
group by time_of_day;

-- -------------2. Which of the customer types brings the most revenue?
select
      Customer_type,
      sum(total) as total_revenue
from sales
group by Customer_type
order by total_revenue;
-- ------------Ans: The Normal customer type brings most revenue of $158743.31

-- ------------3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
select
      City,
      avg(VAT) as VAT
from sales
group by City
order by VAT desc;
-- -----------Ans: Naypyitaw city has largest average VAT of $16.05

-- -----------4. Which customer type pays the most in VAT?
select
      Customer_type,
      avg(VAT) as VAT
from sales
group by Customer_type
order by VAT desc;
-- ----------Ans: Member type pays the most in VAT around $15.61

-- -------------------------------------Customer------------------------------------------
-- ---------------1. How many unique customer types does the data have?
select
      distinct Customer_type
from sales;
-- --------------Ans: The data has 2 customer types, viz. Member & Normal.

-- --------------2. How many unique payment methods does the data have?
select
      distinct Payment
from sales;
-- ------Ans: The data has 3 unique payment methods,viz. Ewallet,cash & credit card.

-- -------------3. What is the most common customer type?
select
      Customer_type,
      count(*) as count
from sales
group by Customer_type
order by count desc;
-- ------------Ans. Member is the most common customer type.

-- ------------4. What is the gender of most of the customers?
select
      Gender,
      count(*) as count
from sales
group by Gender
order by count desc;
-- ---------Ans: Female dominate the customer base.

-- --------------What is the gender distribution per branch?
select
      Gender,
      count(*) as count
from sales
where branch = "A"
group by Gender
order by count desc;
-- -------------Which time of the day do customers give most ratings?
select
      time_of_day,
      round(avg(rating),2) as avg_rating
from sales
group by time_of_day
order by avg_rating desc;
-- -------------Which time of the day do customers give most ratings per branch?
select
      time_of_day,
      round(avg(rating),2) as avg_rating
from sales
where branch = "C"
group by time_of_day
order by avg_rating desc;
-- -------------Which day of the week has the best avg ratings?
select
      day_name,
      round(avg(rating),2) as avg_rating
from sales
group by day_name
order by avg_rating desc;
-- -------------Which day of the week has the best average ratings per branch?
select
      day_name,
      round(avg(rating),2) as avg_rating
from sales
where branch = "A"
group by day_name
order by avg_rating desc;