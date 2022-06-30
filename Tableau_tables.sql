select *
from  [housing data ]..[housing data]


select *
from  [housing data ]..[housing data]
where SalePrice is null
--nonulls

--table1
select YEAR(conv_date) as year_,AVG(SalePrice) as avg_price_of_property_wrt_buyers,COUNT([UniqueID ]) as no_of_sales
from  [housing data ]..[housing data]
group by YEAR(conv_date)
order by YEAR(conv_date)


--table2
select distinct ownercity,COUNT([UniqueID ]) as no_of_sales
from  [housing data ]..[housing data]
where ownercity is not null
group by ownercity


--table 3

select conv_date,SUM(LandValue)/SUM(Acreage) as avg_value_per_acreage
from  [housing data ]..[housing data]
where Acreage is not null
group by conv_date
order by conv_date


--table4
select ownercity,conv_date,LandValue,Acreage
from  [housing data ]..[housing data]
where Acreage is not null
order by ownercity,conv_date

