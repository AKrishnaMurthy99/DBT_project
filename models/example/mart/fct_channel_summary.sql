{%set min_date = '2021-01-01'%}

select order_channel, count(*), sum(order_total) from ref({'stg_orders'}) 
where order_ts >= '{{min_date}}'
group by 1
