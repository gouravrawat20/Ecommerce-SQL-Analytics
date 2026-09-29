# customers
# products
# orders
# order_items
# payments

use ecommerce_analytics;

select * from customers;
select * from orders;
select * from products;
select * from payments;
select * from order_items;

#🟢 Part 1 — SQL Basics (Q1–Q10)

#Q1. Customers table se customer_name, city, state display karo.

select customer_name, city, state from customers;

#Q2. Sirf Mumbai ke customers find karo.

select * from customers where city = 'Mumbai';

#Q3. Mumbai aur Pune ke customers find karo.

select * from customers where city = 'mumbai'or city = 'pune';

#Q4. 2024 mein signup karne wale customers find karo.

select customer_name, city, state, signup_date from customers
where signup_date >= '2024-01-01' AND signup_date < '2025-01-01';

#Q5. Customers ko signup_date ke according newest → oldest sort karo.

select customer_name,city,signup_date from customers order by signup_date desc;

#Q6. Customers kis-kis unique city se hain, find karo.

select distinct city from  customers ;

#Q7. Customers table se first 10 records display karo.

select * from customers limit 10;

#Q8. Total customers count karo.

select count(*) from customers;
select count(signup_date) from customers;

#Q9. Total unique cities count karo.

select count(distinct city) from customers;

#Q10. Har city mein kitne customers hain?

#🟢 Part 2 — Aggregation & GROUP BY (Q11–Q20)

select city, count(*) as city_count from customers group by city order by city_count desc;

#🟢 Part 2 — Aggregation & GROUP BY (Q11–Q20)

#Q11. Payments table se total payment amount nikalo.

select sum(amount) from payments where payment_status= 'paid' ;

#Q12. Payment amount ka average nikalo.

select avg(amount) from payments where payment_status= 'paid' ;

# Q13. Minimum aur maximum payment amount nikalo.

select MIN(amount) AS min_payment ,MAX(amount) AS max_payment FROM payments
where payment_status = 'Paid';

# Q14. Har payment_status mein kitne payments hain?

select payment_status , count(*) count_payment_status from payments group by payment_status;

# Q15. Har payment_status ka total payment amount nikalo.

select payment_status , sum(amount) from payments group by payment_status;

# Q16. Har payment_status ka average payment amount nikalo.

select payment_status , avg(amount) as avg_amount from payments group by payment_status;

# Q17. Cities jahan 20 se zyada customers hain, unhe find karo.

SELECT city, COUNT(*) FROM customers GROUP BY city HAVING COUNT(*) > 20;

# Q18. Har city ka total customer count nikalo aur descending order mein sort karo.

select city, count(*) as city_count from customers group by city order by city_count desc;

# Q19. Orders table mein har order_status ke kitne orders hain?

select order_status , count(*) as total_orders from orders group by order_status;

# Q20. Har order_status ka total revenue nikalo.

#  🟡 Part 3 — CASE WHEN & Date Analysis (Q21–Q30)

select o.order_status , sum(p.amount) as total_revenue from orders as o join payments as p on o.order_id = p.order_id group by o.order_status;

#  🟡 Part 3 — CASE WHEN & Date Analysis (Q21–Q30)

# Q21. Orders ko CASE WHEN se categories mein divide karo:

# Completed → Successful
# Cancelled → Unsuccessful
# Others → Other

select order_id, order_status,
       case
           when order_status = 'Completed' THEN 'Successful'
           when order_status = 'Cancelled' THEN 'Unsuccessful'
           else 'Other'
       end AS order_category 
FROM orders  ;

# Q22. 2024 mein month-wise total orders nikalo.

select  count(*) as total_orders ,year(order_date) as Year  , month(order_date) as Month from orders 
where year(order_date) = '2024' group by YEAR(order_date), MONTH(order_date) order  by Month asc;

# Q23. 2024 mein month-wise total revenue nikalo.

select year(order_date) as Year ,month(order_date) as MOnth ,count(*) as total_order, sum(amount) as total_revenue from orders 
inner join payments 
on payments.order_id = orders.order_id 
where year(order_date) = '2024' group by year(order_date) , month(order_date) order by month(order_date) asc;

# Q24. Customers ko signup month ke according count karo.

select month(signup_date) as Month , count(*) as total_customers from customers group by month(signup_date) order by Month;

# Q25. Customers jo 2024 ke first half (Jan–Jun) mein signup hue, find karo.

select * from customers where signup_date >= '2024-01-01' and signup_date < '2024-07-01';

# Q26. Customers jo 2024 ke second half (Jul–Dec) mein signup hue, find karo.

select * from customers where signup_date >= '2024-07-01' and signup_date < '2025-01-01';

# Q27. 2024 mein month-wise orders nikalo.

select  count(*) as total_orders ,year(order_date) as Year  , month(order_date) as Month from orders 
where year(order_date) = '2024' group by YEAR(order_date), MONTH(order_date) order  by Month asc;

# Q28. 2024 mein month-wise revenue nikalo.

select year(order_date) as Year ,month(order_date) as MOnth ,count(*) as total_order, sum(amount) as total_revenue from orders 
inner join payments 
on payments.order_id = orders.order_id 
where year(order_date) = '2024' group by year(order_date) , month(order_date) order by month(order_date) asc;

# Q29. Aise customers find karo jinhone ek bhi order nahi kiya.

select customers.customer_id ,customer_name from customers 
left join orders
on orders.customer_id = customers.customer_id 
where orders.order_id is null;

# Q30. Har customer ka total order count nikalo, including customers with zero orders.

# 🟡 Part 4 — JOINs & Customer Analysis (Q31–Q40)

select C.customer_id ,count(O.order_id) as Order_count , customer_name from customers  as C
left join orders as O
on O.customer_id = C.customer_id
group by C.customer_id , C.customer_name   order by Order_count asc;

# 🟡 Part 4 — JOINs & Customer Analysis (Q31–Q40)

# Q31. Har customer ka total spending nikalo.

select c.customer_id , c.customer_name , sum(p.amount) as total_spend from customers as c
left join orders as  o
on o.customer_id = c.customer_id 
left join payments as p
on p.order_id = o.order_id
group by c.customer_id , c.customer_name ;

# Q32. Jinhone kuch spend nahi kiya unka spending 0 show karo.

select c.customer_id , c.customer_name,coalesce(sum(p.amount),0) as total_spend from customers as c
left join orders as o
on o.customer_id = c.customer_id
left join payments as p
on p.order_id = o.order_id
group by c.customer_id ,c.customer_name ;

# Q33. Har customer ka sirf Paid payments ka total spending nikalo.

select c.customer_id , c.customer_name , coalesce(sum(p.amount),0) as total_paid_amt from customers as c
left join orders as o
on o.customer_id = c.customer_id
left join payments as p
on p.order_id = o.order_id
And p.payment_status = 'paid'
group by c.customer_id ,c.customer_name 
order by c.customer_id asc;

# Q34. Top 10 customers by total spending find karo.

select  c.customer_name,coalesce(sum(p.amount),0) as total_spend from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by c.customer_name 
order by total_spend desc limit 10;

# Q35. City-wise total revenue nikalo.

select city , sum(amount) as total_revenue from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by city ;

# Q36. Har product ki total quantity sold nikalo.

select product_name , sum(quantity) as total_quantity from products as p
join order_items as oi
on oi.product_id = p.product_id 
group by product_name ;

# Q37. Top 5 products by revenue find karo.

select product_name , sum(quantity * price) as total_revenue from products as p
join order_items as oi
on oi.product_id = p.product_id 
group by product_name 
order by total_revenue desc limit 5;

# Q38. Aise customers find karo jinka spending ₹50,000 se zyada hai, lekin woh highest-spending customer nahi hain.

SELECT c.customer_name, SUM(p.amount) AS total_spent FROM customers AS c
JOIN orders AS o
ON o.customer_id = c.customer_id
JOIN payments AS p
ON p.order_id = o.order_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(p.amount) > 50000 AND SUM(p.amount) < (
SELECT MAX(total_spent) FROM (SELECT c2.customer_id,SUM(p2.amount) AS total_spent FROM customers AS c2
JOIN orders AS o2
ON o2.customer_id = c2.customer_id
JOIN payments AS p2
ON p2.order_id = o2.order_id
GROUP BY c2.customer_id
) AS customer_totals);

# Q39. CTE use karke customer-wise total spending nikalo aur top 10 customers find karo.

with customer_spending as(
select customer_name , sum(amount) as total_spending from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by c.customer_id ,c.customer_name )
SELECT customer_name,total_spending FROM customer_spending order by total_spending desc limit 10;

# Q40. Har city ke andar customers ko total spending ke basis par rank karo.

# 🔵 Part 5 — Subqueries & CTEs (Q41–Q50)

select c.customer_name , c.city , sum(p.amount) as total_spent ,
rank() over(partition by city order by sum(p.amount) desc) as city_rank from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by c.customer_id, c.customer_name,c.city ;

# 🔵 Part 5 — Subqueries & CTEs (Q41–Q50)

# Q41. Aise customers find karo jinhone at least one order kiya hai using IN.

select * from customers
where customer_id in (select customer_id from orders);

# Q42. Aise customers find karo jinhone koi order nahi kiya using NOT IN.

select * from customers
where customer_id not in (select customer_id from orders);

# Q43. Aise products find karo jinki price average product price se zyada hai.

select product_name , price from products where price > (select avg(price) from products) ;

# Q44. Sabse expensive product(s) find karo.

select product_name , price from products where price = (select max(price) from products);

# Q45. CTE use karke customer-wise total spending calculate karo.

with customer_spending as (
select c.customer_id ,c.customer_name ,sum(p.amount) as total_spending from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by c.customer_id,c.customer_name)
select customer_name,total_spending from customer_spending order by total_spending desc;

# Q46. CTE se customer spending nikalo aur sirf ₹50,000+ customers show karo.

with customer_spending as (
select c.customer_id ,c.customer_name ,sum(p.amount) as total_spending from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by c.customer_id,c.customer_name)
select customer_name,total_spending from customer_spending where total_spending > 50000 order by total_spending desc;

# Q47. CTE use karke top 5 customers by spending find karo.

with customer_spending as (
select c.customer_id ,c.customer_name ,sum(p.amount) as total_spending from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by c.customer_id,c.customer_name)
select customer_name,total_spending from customer_spending order by total_spending desc limit 5;

# Q48. CTE use karke city-wise total revenue calculate karo.

with city_revenue as (select c.city , sum(p.amount) as total_revenue from customers as c join orders as o on c.customer_id = o.customer_id join payments as p on o.order_id = p.order_id group by c.city) select city,total_revenue from city_revenue order by total_revenue desc;

# Q49. Customers ko overall spending ke basis par rank karo.

select c.customer_name , sum(p.amount) as total_spent ,
rank() over(order by sum(p.amount) desc) as city_rank from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by c.customer_id, c.customer_name ;

# Q50. Customers ko city ke andar spending ke basis par rank karo.

# 🔴 Part 6 — Window Functions (Q51–Q60)

select c.customer_name , c.city , sum(p.amount) as total_spent ,
rank() over(partition by city order by sum(p.amount) desc) as city_rank from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by c.customer_id, c.customer_name,c.city ;

# 🔴 Part 6 — Window Functions (Q51–Q60)

# Q51. ROW_NUMBER() use karke har city ke customers ko spending ke basis par rank karo.

select  row_number() over(partition by city order by sum(p.amount)desc) as row_num ,
c.customer_name ,c.city,sum(p.amount) as total_spent from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by c.customer_id, c.customer_name,c.city;

# Q52. DENSE_RANK() use karke har city ke customers ko spending ke basis par rank karo.

select c.customer_name , c.city , sum(p.amount) as total_spent ,
dense_rank()  over(partition by city order by sum(p.amount) desc) as city_dense_rank from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by c.customer_id, c.customer_name,c.city ;

# Q53. RANK() use karke customers ko overall spending ke basis par rank karo.

select c.customer_name , sum(p.amount) as total_spent ,
rank() over(order by sum(p.amount) desc) as customer_rank from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by c.customer_id, c.customer_name ;

# Q54. Har customer ka latest order find karo using ROW_NUMBER().

select * from (select  * ,ROW_NUMBER() 
OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS row_num from orders)customers
where row_num = 1;

# Q55. Har customer ka first order find karo.

select * from (select * , row_number() 
over(partition by customer_id order by order_date asc) as row_num from orders) customers
where row_num = 1;

# Q56. 2024 ka month-wise revenue aur running revenue total nikalo.

select month(payment_date) as Month , sum(amount) as Monthly_revenue , 
sum(sum(amount)) over(order by month(payment_date)) as running_revenue from  payments 
where year(payment_date) = '2024' 
group by Month(payment_date) order by month asc ;

# Q57. Har month ka revenue aur previous month's revenue nikalo using LAG().

select month(payment_date) AS Month,SUM(amount) AS Monthly_revenue,
LAG(SUM(amount)) OVER(ORDER BY MONTH(payment_date)) AS Previous_month_revenue
FROM payments
WHERE YEAR(payment_date) = 2024
GROUP BY MONTH(payment_date) ORDER BY Month;

# Q58. Month-over-Month revenue growth percentage calculate karo.

select month(payment_date) as Month , sum(amount) as Monthly_revenue ,
lag(sum(amount)) over(order by Month(payment_date)) as previous_mon_payment,
(sum(amount) - lag(sum(amount)) over(order by Month(payment_date))) / lag(sum(amount)) over(order by Month(payment_date))*100 as mon_as_mon_growth
from payments
where year(payment_date) = '2024'
group by month(payment_date) order by Month;

# Q59. Aise customers find karo jinhone 2 ya usse zyada orders kiye hain.

select c.customer_name , count(o.order_id)  as count_order from customers as c
join orders as o
on o.customer_id = c.customer_id
group by c.customer_name
having count_order >= 2 ;

# Q60. Har product ka total revenue aur overall revenue contribution % nikalo.

# 🟣 Part 7 — Business Analysis (Q61–Q70)

select product_name,
       sum(oi.quantity * oi.price) as product_revenue,
       round(
           sum(oi.quantity * oi.price) * 100 /
           (select sum(oi2.quantity * oi2.price) from order_items as oi2),
           2
       ) as revenue_percentage
from products as pro
join order_items as oi
on oi.product_id = pro.product_id
group by pro.product_id, product_name;

# 🟣 Part 7 — Business Analysis (Q61–Q70)

# Q61. Overall business performance nikalo:

# Total Customers
# Total Orders
# Total Revenue
# AOV - average order value

select
(select  count(*) from customers) as Total_customers ,
(select count(*) from orders) as Total_order,
(select sum(amount) from payments) as Total_revenue,
(select sum(amount) from payments) / (select count(*) from orders) as avg_order_value ;

# Q62. 2024 ka month-wise:

# Total Orders
# Total Revenue
# AOV

select month(o.order_date) as Month,
       count(distinct o.order_id) as total_orders,
       sum(p.amount) as total_revenue,
       sum(p.amount) / count(distinct o.order_id) as aov
from orders as o
join payments as p
on p.order_id = o.order_id
where year(o.order_date) = 2024
group by month(o.order_date)
order by month(o.order_date);

# Q63. Top 10 customers by revenue find karo.

select c.customer_name ,sum(p.amount) as Total_revenue from customers as c
JOIN orders AS o
ON o.customer_id = c.customer_id
JOIN payments AS p
ON p.order_id = o.order_id
group by c.customer_id, c.customer_name order by sum(amount) desc limit 10;

# Q64. City-wise:

# Total Customers
# Total Orders
# Total Revenue

# nikalo.

SELECT c.city AS city,
(SELECT COUNT(*) FROM customers as c2
WHERE c2.city = c.city) AS total_customers,
(SELECT COUNT(*) FROM orders o
JOIN customers c2 ON o.customer_id = c2.customer_id 
WHERE c2.city = c.city) AS total_orders,
(SELECT SUM(p.amount) FROM payments as p
JOIN orders as o 
ON p.order_id = o.order_id
JOIN customers as c2 
ON o.customer_id = c2.customer_id
     WHERE c2.city = c.city) AS total_revenue
FROM customers as c GROUP BY c.city;

# Q65. Product performance:

# Total Quantity Sold
# Total Revenue

select p.product_name,
       sum(oi.quantity) as quantity_sold,
       sum(oi.quantity * oi.price) as total_revenue
from products as p
join order_items as oi
on p.product_id = oi.product_id
group by p.product_id, p.product_name;

# Q66. Top 5 products by quantity sold find karo.

select product_name , sum(oi.quantity)  as total_quantity from products as p
join order_items as oi
on p.product_id = oi.product_id
group by p.product_name order by sum(oi.quantity) desc limit 5;

# Q67. Repeat customers find karo — 2+ orders.

select c.customer_name , count(o.order_id)  as total_order from customers as c
join orders as o
on o.customer_id = c.customer_id
group by c.customer_name
having total_order >= 2  order by total_order asc;

# Q68. Customers ko spending ke basis par segment karo:

# High → > ₹50,000
# Medium → ₹20,000–₹50,000
# Low → < ₹20,000

select c.customer_id , c.customer_name  , sum(p.amount) as Total_spending ,
case 
when sum(p.amount) > 50000 then 'High Value'
when sum(p.amount) between 20000 and 50000 then 'Medium Value'
else 'Low value'
end as customer_segment from customers as c
join orders as o
on o.customer_id = c.customer_id
join payments as p
on p.order_id = o.order_id
group by c.customer_id;

# Q69. Order status-wise:

# Total Orders
# Total Revenue

select o.order_status,
       count(distinct o.order_id) as total_orders,
       sum(p.amount) as total_revenue
from orders as o
join payments as p
on p.order_id = o.order_id
group by o.order_status;

# Q70. Overall business dashboard ke liye ek query banao jisme:

# Total Customers
# Total Orders
# Total Revenue
# AOV
# Completed Orders
# Cancelled Orders
# Repeat Customers


# 🔥 Part 8 — Final Portfolio-Level SQL (Q71–Q75)

select
(select count(*) from customers) as total_customers,
(select count(*) from orders) as total_orders ,
(select sum(amount) from payments) as Total_revenue ,
(select sum(amount) from payments) / (select count(*) from orders)  as avg_order_value ,
(select count(order_status) from orders where order_status = 'Completed') as Completed_orders,
(select count(order_status) from orders where order_status = 'Cancelled') as Cancelled_orders,
(select count(*) from (select customer_id from orders 
group by customer_id having count(order_id) >=2) as repeat_customers)as repeat_customers;

# 🔥 Part 8 — Final Portfolio-Level SQL (Q71–Q75)

# Q71 — Monthly Revenue Growth

# 2024 ke har month ke liye:

# Month
# Total Revenue
# Previous Month Revenue
# MoM Growth % - monthly revenue growth



#Hint: LAG() + CTE.

with monthly_revenue as (
select month(o.order_date) as month_no,monthname(o.order_date) as month,sum(p.amount) as total_revenue from orders as o
join payments as p
on o.order_id = p.order_id
where year(o.order_date) = 2024 and o.order_status = 'completed'
group by month(o.order_date),monthname(o.order_date))
select month,total_revenue,lag(total_revenue) over (order by month_no) as previous_month_revenue,
round((total_revenue- lag(total_revenue) over (order by month_no)
)/lag(total_revenue) over (order by month_no)* 100,2) as mom_growth_percentage
from monthly_revenue order by month_no;

#Q72 — Customer Retention Analysis

#Har customer ke liye:

#Customer Name
#First Order Date
# Latest Order Date
# Total Orders
# Total Spending
# Customer Type


# Customer Type:

# 1 order → New
# 2–3 orders → Repeat
# 4+ orders → Loyal

with customer_summary as (
select c.customer_name,min(o.order_date) as first_order_date,max(o.order_date) as latest_order_date,
count(o.order_id) as total_orders,sum(p.amount) as total_spending from customers as c
join orders as o
on c.customer_id = o.customer_id
join payments as p
on o.order_id = p.order_id
where o.order_status = 'completed' group by c.customer_id,c.customer_name)
select customer_name,first_order_date,latest_order_date,total_orders,total_spending,
case
when total_orders = 1 then 'new'
when total_orders between 2 and 3 then 'repeat'
when total_orders >= 4 then 'loyal'
end as customer_type
from customer_summary
order by total_spending desc;

# Q73 — Product Performance Ranking

# Har product ke liye:

# Product Name
# Quantity Sold
# Total Revenue
# Revenue Rank
# Quantity Rank


# Revenue ke basis par aur quantity ke basis par separate ranking honi chahiye.

with product_summary as (
select p.product_name,sum(oi.quantity) as quantity_sold,sum(oi.quantity * p.price) as total_revenue from products as p
join order_items as oi
on p.product_id = oi.product_id
join orders as o
on oi.order_id = o.order_id
where o.order_status = 'completed'
group by p.product_id,p.product_name)
select product_name,quantity_sold,total_revenue,rank() over(order by total_revenue desc) as revenue_rank,
rank() over(order by quantity_sold desc) as quantity_rank from product_summary order by revenue_rank;

# Q74 — Customer Revenue Contribution

# Har customer ke liye:

# Customer Name
# Total Spending
# Revenue Contribution %
# Overall Rank


# Revenue Contribution:

# Customer Revenue / Overall Revenue × 100

with customer_revenue as (
select c.customer_name,sum(p.amount) as total_spending from customers as c
join orders as o
on c.customer_id = o.customer_id
join payments as p
on o.order_id = p.order_id
where o.order_status = 'completed' group by c.customer_id,c.customer_name)
select customer_name,total_spending,
round(total_spending / (select sum(total_spending) from customer_revenue) * 100,2) as revenue_contribution_percentage,
rank() over(order by total_spending desc) as overall_rank
from customer_revenue
order by overall_rank;

# Q75 — 🏆 FINAL BUSINESS ANALYSIS

# Ek final SQL query/report banao jisme customer-level par:

# Customer Name
# City
# Total Orders
# Total Spending
# Average Order Value
# First Order Date
# Latest Order Date
# Customer Rank
# Customer Segment
# Repeat/One-time Customer

# show ho.

# Customer Segment:

# High → Spending > ₹50,000
# Medium → ₹20,000–₹50,000
# Low → < ₹20,000

# Bonus: City ke andar customer rank bhi add karo.

with customer_analysis as (
select c.customer_name,c.city,count(o.order_id) as total_orders,sum(p.amount) as total_spending,sum(p.amount) / count(o.order_id) as average_order_value,
min(o.order_date) as first_order_date,max(o.order_date) as latest_order_date from customers as c
join orders as o
on c.customer_id = o.customer_id
join payments as p
on o.order_id = p.order_id
where o.order_status = 'completed' group by c.customer_id,c.customer_name,c.city)
select customer_name,city,total_orders,total_spending,round(average_order_value,2) as average_order_value, first_order_date,latest_order_date,
rank() over(order by total_spending desc) as customer_rank,
case
when total_spending > 50000 then 'high'
when total_spending between 20000 and 50000 then 'medium'
else 'low'
end as customer_segment,
case
when total_orders = 1 then 'one-time'
else 'repeat'
end as customer_type
from customer_analysis order by customer_rank;

