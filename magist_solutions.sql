USE magist; 

select *
from orders;

select *
from order_reviews;

select *
from order_reviews
where review_comment_message like '%apple%';

-- 1. how many orders are there in the dataset (99441)
select count(order_id)
from orders;

-- 2.Are orders delivered? (96478)
select count(order_status)
from orders
where order_status like 'delivered';

-- 3.Is Magist having user growth? 
 
select 
  year(order_purchase_timestamp) as year_,
  month(order_purchase_timestamp) as month_,
  count(customer_id)
from orders
group by year_, month_
order by year_, month_; 

-- 4. How many products are there in the products table? (32951) 
-- ? Why we need here distinct if we use product_id! it is only ony id per product. 

select count(distinct product_id) as product_count
from products;

-- 5. Which are the categories with most products?
select product_category_name,  count(product_id)
from products
group by product_category_name
order by count(product_id) desc;

-- 6. How many of those products were present in actual transactions (32951)

select count(distinct product_id) 
from order_items;

-- 7.What is the price for the most expensive and cheapest products
select 
   min(price) as cheapest, 
   max(price) as most_expensive
from order_items;

 
 -- 8. What are the highest and lowest payment values
 select 
   min(payment_value) as lowest, 
   max(payment_value) as highest
from order_payments;


-- Is Magist a good fit for high-end tech products?
-- Are orders delivered on time?

-- Are orders delivered on time?
select count(*) -- 88649 were delivered earlier that estimated delivery
                -- 7827 were delivered later
from orders
 where order_delivered_customer_date <= order_estimated_delivery_date;
 
select count(*) -- 7827
from orders
 where order_delivered_customer_date > order_estimated_delivery_date;

select count(*) -- 99441 total orders
from orders;

select count(order_status)
from orders
where order_status = 'delivered'; -- 96478

select distinct order_status
from orders;

select * 
from orders;

select order_estimated_delivery_date, order_delivered_customer_date
case 
    when 10 > order_estimated_delivery_date - order_delivered_customer_date >= 9 then '<=10 days'
    when 9 > order_estimated_delivery_date - order_delivered_customer_date <= 8 then '<=9'
    else 'unknown'
end as 'delivery_days'
from orders
group by 'delivery_days'
having count ;

select * -- order_estimated_delivery_date, order_delivered_customer_date
from orders;
 -- order_delivered_customer_date - order_estimated_delivery_date;

-- How many (count) 'informatica_acessorios' are ordered from the total orders
 select count(distinct oi.order_id)   -- computers_accessories (informatica_acessorios)
 from product_category_name_translation pcn
    inner join products p on pcn.product_category_name = p.product_category_name
    inner join order_items oi on oi.product_id = p.product_id
    inner join orders o on o.order_id = oi.order_id
where  p.product_category_name = 'informatica_acessorios';

-- how many orders are made for each category
select count(distinct oi.order_id), p.product_category_name   -- computers_accessories (informatica_acessorios)
 from product_category_name_translation pcn
    inner join products p on pcn.product_category_name = p.product_category_name
    inner join order_items oi on oi.product_id = p.product_id
    inner join orders o on o.order_id = oi.order_id
where p.product_category_name in ('informatica_acessorios','audio','electronics')
group by p.product_category_name;

 select * -- count('informatica_acessorios') -- computers_accessories (informatica_acessorios)
 -- inner join with products, with order_items, with orders
 from product_category_name_translation pcn;
 
-- DATE --

-- select count(order_estimated_delivery_date), count(order_delivered_customer_date),
select count(order_id),
case
when
datediff(order_estimated_delivery_date, order_delivered_customer_date) > 0 then 'Fast delivery'
when
datediff(order_estimated_delivery_date, order_delivered_customer_date) = 0 then 'Normal delivery'
when
datediff(order_estimated_delivery_date, order_delivered_customer_date) < 0 then 'Delayed delivery'
else 'unknown'
end as delivery
count(order_id) / (count(*)) * 100 persantage
from orders
group by delivery;

select count(order_id)
from orders;

select * 
from order_items;

select (price) / (freight_value) * 100 persentage
from order_items;
