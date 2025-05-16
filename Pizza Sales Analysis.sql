/*Check full table */
select * from pizza_sales;

/*For KPI's*/

/*Total Revenue*/
select round(sum(total_price),2) as `Total_Revenue` from Pizza_Sales;
/*Average Order value*/
select round((sum(total_price) / count(distinct order_iD)),2) as `Average_Order_value` from Pizza_Sales;
/*Total Pizza Sold*/
select sum(quantity) as `Total_Pizza_Sold` from Pizza_Sales;
/*Total Order Placed*/
select count(distinct order_id) as `Total_Order_Placed` from Pizza_Sales;
/*Average sale count Per Order*/
select round(cast(sum(quantity) as decimal(10,2)) / count(distinct order_id),0)  as `Average_sale_count_Per_Order` from Pizza_Sales;


/*For Charts*/

/*Daily Trend for Total Orders*/
select dayname(order_date) as Order_day, count(distinct order_id) as Order_count
from pizza_sales
group by order_day;

/*Hourly Trend for Total Orders*/
select hour(time(order_time)) as Order_Hour, count(distinct order_id) as Order_count from pizza_sales
group by Order_Hour;

/*Percentage of Sales by Pizza Category*/
select pizza_category, round(Sum(total_price),2) as Total_Sales,
round(sum(total_price) * 100/ (select sum(total_price) from pizza_sales),2) as Percent_of_Sales from pizza_sales
group by pizza_category;

/*Percentage of Sales by Pizza Size*/
select pizza_size, round(Sum(total_price),2) as Total_Sales,
round(sum(total_price) * 100/ (select sum(total_price) from pizza_sales),2) as Percent_of_Sales from pizza_sales
group by pizza_size
order by 
	case pizza_size
    when 'S' THEN 1
    when 'M' THEN 2
    when 'L' THEN 3
    when 'XL' THEN 4
    when 'XXL' THEN 5
    end;
     
/*Total Pizzas Sold by Pizza Category*/
select pizza_category, round(sum(quantity),2) as Total_Quantity,
round(sum(quantity) * 100/ (select sum(quantity) from pizza_sales),2) as Percent_of_Sales_quantity from pizza_sales
group by pizza_category;

/*Top 5 Best Sellers by Total Pizzas Sold*/
select pizza_name, sum(quantity) as Total_Quantity_sold from pizza_sales
group by pizza_name
order by Total_Quantity_sold desc
limit 5;

/*Bottom 5 Worst Sellers by Total Pizzas Sold*/
select pizza_name, sum(quantity) as Total_Quantity_sold from pizza_sales
group by pizza_name
order by Total_Quantity_sold asc
limit 5;




