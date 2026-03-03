select * from customers
select * from products
select * from orders
select * from order_items
select * from payments

-- 1 List All Customers From Mumbai --

select * from customers where city = 'Mumbai'

-- 2 Show products with price > 50,000. --

select * from products where price > 50000

-- 3 Find orders placed between '2024-06-01' and '2024-09-30'. --

select * from orders where order_date >= '2024-06-01' and order_date <= '2024-09-30'

-- 4 Get customers who signed up after 2024-07-01. --

select * from customers where signup_date > '2024-07-01'

-- 5 Show products where stock < 20. --

select * from products where stock < 20

-- 6 Find orders with total_amount between 10,000 and 50,000. --

select * from orders where total_amount >= 10000 and total_amount < 50000

-- 7 Get customers whose name starts with 'R' (LIKE) --

select * from customers where name like 'R%'

-- 8 Find emails ending with '@gmail.com'. --

select * from customers where email like '%@gmail.com'

-- 9 List payments done using UPI or Credit Card. --

select * from payments where payment_mode in ('UPI', 'Credit Card')

-- 10 Show top 10 most expensive products. --

select top 10 * from products order by price desc

-- 11 Total number of customers. --

select count(customer_id) from customers

-- 12 Total revenue generated. --

select sum(total_amount) from orders

-- 13 Average order value. --

select avg(total_amount) from orders

-- 14 Total orders per city. --

select city, count(order_id) as total_id from customers, orders group by city

-- 15 Revenue per category --

select category, sum(total_amount) as revenue from products, orders group by category

-- 16 Number of products per category. --

select category, count(product_name) as no_of_products from products group by category

-- 17 Find categories having revenue > 5,00,000 (HAVING). --

select category, sum(total_amount) from products, orders group by
category having sum(total_amount) > 500000

-- 18 Cities with more than 50 customers. --

select city, count(customer_id) from customers group by city having count(customer_id) > 50

-- 19 Monthly sales summary. --

select month(payment_date) as months, sum(total_amount)  as monthly_sales
from payments, orders group by month(payment_date) order by month(payment_date)

-- 20 Highest selling product by quantity. --

select top 20 product_id, sum(quantity) from order_items group by product_id 
order by sum(quantity) desc

-- 21 Show customer name with their total spending. --

select c.name, sum(o.total_amount) as total_spending
from customers c inner join orders o
on c.customer_id = o.customer_id 
group by c.name order by total_spending desc

-- 22 List all orders with customer city. --

select c.city, count(o.order_id)
from customers c inner join orders o
on c.customer_id = o.customer_id 
group by c.city order by count(o.order_id) desc

-- 23 Show product name with order quantity. -- 

select p.product_name, sum(oi.quantity) as quantity
from products p inner join order_items oi
on p.product_id = oi.product_id 
group by p.product_name order by sum(oi.quantity) desc

-- 24 Find payment mode used for each order. --

select o.order_id, pm.payment_mode
from orders o
inner join 
payments pm
on o.order_id = pm.order_id

-- 25 List customers who never placed any order --

select c.customer_id, o.order_id, o.customer_id 
from customers c left join orders o
on c.customer_id = o.customer_id 
where o.order_id is null

-- 26 Show top 5 customers by purchase value. --

select top 5 c.customer_id, sum(o.total_amount) 
from customers c 
inner join 
orders o
on c.customer_id = o.customer_id
group by c.customer_id order by sum(o.total_amount) desc

-- 27 Show products never purchased. --

select p.product_id, p.product_name, 
oi.order_id, oi.product_id
from products p left join order_items oi
on oi.product_id = p.product_id
where oi.product_id is null

-- 28 Display each order with number of items bought. --

select o.order_id, sum(oi.quantity) as no_of_items
from orders o  inner join order_items oi
on o.order_id = oi.order_id 
group by o.order_id order by sum(oi.quantity) desc

-- 29 Find category-wise revenue using joins. --

select p.category, sum(oi.price * oi.quantity) as revenue
from products p inner join order_items oi
on p.product_id = oi.product_id
group by p.category order by revenue desc

-- 30 Show customer + order + payment details in one result. --

select c.customer_id, c.name,
o.order_id,
pm.payment_id, pm.payment_mode
from customers c inner join orders o
on c.customer_id = o.customer_id
inner join payments pm
on o.order_id = pm.order_id


-- 31 Rank customers based on spending (RANK()). --

select customer_id, sum(total_amount), rank() over(order by sum(total_amount) desc)
as customer_rank from orders 
group by customer_id

-- 32 Top 3 customers in each city (PARTITION BY). --

select * from (select c.customer_id, c.city,
sum(o.total_amount) as total_amt, row_number() over(partition by c.city order by
sum(o.total_amount) desc) as rank_num
from customers c inner join orders o
on c.customer_id = o.customer_id 
group by c.customer_id, c.city)t where rank_num <= 3

-- 33 Running total of daily sales (SUM OVER). --

select order_date, sum(total_amount), sum(sum(total_amount))
over(order by order_date) as running_total from orders group by order_date

/*
select * from customers
select * from products
select * from orders
select * from order_items
select * from payments
*/

-- 34 Find first order date for each customer. --

select * from (select customer_id, order_id, order_date, rank() over(partition by 
customer_id order by order_id) as fst_ord_id
from orders)t where fst_ord_id = 1

-- 35 Find most recent order using ROW_NUMBER(). --

select * from (select customer_id, order_id, order_date, rank() over(partition by 
customer_id order by order_id desc) as fst_ord_id
from orders)t where fst_ord_id = 1

-- 36 Calculate month-over-month growth %. --

create table monthly_sales (
    months int,
    total_amt float,
    prev_monthly_amt float
);


insert into monthly_sales

select month(order_date) as months, sum(total_amount) as total_amt from orders
group by month(order_date) order by months

alter table monthly_sales add prev_monthly_amt float

insert into monthly_sales
select months, total_amt, lag(total_amt, 1, 0) over(order by months) from monthly_sales
 
delete from monthly_sales where prev_monthly_amt is NULL

select * from monthly_sales

select total_amt - prev_monthly_amt from monthly_sales as total_diff

/*
select * from customers
select * from products
select * from orders
select * from order_items
select * from payments
*/

-- 37 Find highest order per customer. --

select * from(
select c.customer_id, c.name,
o.order_id, o.total_amount, row_number()over(partition by 
c.customer_id order by total_amount desc) as rank_wise
from customers c inner join orders o
on c.customer_id = o.customer_id)t where rank_wise = 1          

-- 38 Rank products by quantity sold. --

select product_id, sum(quantity), rank() over(order by sum(quantity) desc)
from order_items group by product_id

dense_rank

-- 39 Divide customers into 4 spending groups (NTILE). --

create table customer_spending_grps(
cust_id int,
total_spending float
)

insert into customer_spending_grps
select customer_id, sum(total_amount) from orders group by 
customer_id order by sum(total_amount) desc

alter table customer_spending_grps
add spending_group int

insert into customer_spending_grps
select cust_id, total_spending, ntile(4) over(order by total_spending desc)
from customer_spending_grps

delete from customer_spending_grps where spending_group is NULL

select * from customer_spending_grps  

-- 40 Find repeat customers using COUNT OVER. --

select * from(
select c.customer_id, c.name,
o.order_id, row_number()over(partition by c.customer_id order by c.customer_id)
as repeat_customer from customers c inner join
orders o on c.customer_id =o.customer_id)t where repeat_customer = 2

 /*  41 Categorize customers:

1 lakh → Premium

50k–1 lakh → Gold

else → Regular (CASE)    */

create table categories(
c_id int,
total_spending int
)

insert into categories

select c.customer_id, sum(o.total_amount) from customers c 
inner join orders o on c.customer_id = o.customer_id
group by c.customer_id

select * from categories

select c_id, total_spending,
	 case
	     when total_spending >= 100000 then 'Premium'
		 when total_spending < 100000 and total_spending > 50000 then 'Gold'
		 else 'Regular'
	 end as spending_category
from categories

-- 42 Mask email addresses (string functions). --

select replicate('*', len(email) - 10) + substring(email, len(email) - 9) from customers

-- 43 Extract domain from email. -- 

select substring(email, 1, len(email) - 10) from customers

-- 44 Convert customer names to uppercase. -- 

select upper(name) from customers as NAMES

/* 45 Show payment status:

COD → Pending

Others → Paid  */ 

select distinct(payment_mode) from payments

select payment_mode ,
	case 
		when payment_mode = 'Cash On Delivery' then 'Pending'
		else 'Paid'
	end as payment_status
	from payments

-- 46 Calculate discount: quantity >= 3 → 10% off -- 

select * from (select quantity from order_items where quantity >= 3)t
where 

select order_id, quantity, price, 
	case 
		when quantity >= 3 then price - (price / 100) * 10
		else price
	end as discounted_price
	from order_items


-- 47 Show weekend vs weekday sales. -- 

alter table orders add days int, months int, years int

update o
set 
    days = day(p.payment_date),
    months = month(p.payment_date),
    years = year(p.payment_date)
from orders o
join payments p
    ON o.order_id = p.order_id;

select * from orders

select sum(total_amount) / 48 from orders where days % 7 = 0

select sum(total_amount) / 48 from orders where days % 7 != 0

alter table orders drop column months

alter table orders drop column years

-- 48 Find products containing word "Electronics". -- 

select * from products where category = 'Electronics'

-- 49 Generate invoice id like: 'INV-1001'. --

alter table orders
alter column order_id varchar(10)
update orders
set order_id = 'INV-' + order_id 

select * from orders

/* 50 Create a final report showing 
customer | total_orders | total_spent | rank | segment */

select * from orders

select c.customer_id, count(o.order_id) as total_orders, sum(total_amount) 
as spending_amt, rank() over(order by sum(total_amount) desc) as ranking into 
dashboard_summary from customers c join
orders o on c.customer_id = o.customer_id group by c.customer_id 

select * from dashboard_summary