--SEE DATA OF ZEPTO TABLE
select * from zepto;

--COUNT OF TOTAL ROWS 
select COUNT(*) from zepto;

--COUNT OF CATEGORY
select category, count(*) 
from zepto
group by category
order by count(*);

--NAME OF PRODUCT WHICH ARE OUTOFSTOCK
select name, outofstock from zepto
WHERE outofstock = true;

--PRODUCTS WITH PRICE = 0
select * from zepto 
where mrp = 0 or discountedsellingprice = 0;

--CONVERT PAISE TO RUPEES
UPDATE zepto 
set mrp = mrp/100, discountedsellingprice = discountedsellingprice/100;

--DELETE ROWS WHERE QUANTITY IS GREATER THAN 200
delete from zepto 
where quantity > 200;

--data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.
select name, mrp, discountpercent from zepto
order by discountpercent desc
limit 10;

--Q2.What are the Products with High MRP but Out of Stock
select DISTINCT name, mrp, outOfStock 
from zepto
WHERE outOfStock = true
ORDER BY mrp DESC;

--Q3.Calculate Estimated Revenue for each category
SELECT category, sum(discountedsellingprice * availablequantity) AS revenue
from zepto
GROUP BY category
ORDER BY revenue desc;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT distinct name, mrp, discountpercent 
from zepto
where mrp > 500 and discountpercent < 10
ORDER BY mrp desc;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT distinct category, round(avg(discountpercent),2) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT distinct name, discountedsellingprice, weightingms, round(discountedsellingprice/weightingms,2) as bestvalue
from zepto
where weightingms >= 100
order by bestvalue desc;

--Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE 
	WHEN weightInGms < 100 THEN 'Low'
	WHEN weightInGms < 500 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto;

--Q8.What is the Total Inventory Weight Per Category 
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;

