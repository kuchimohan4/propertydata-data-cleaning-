/*

Data cleaning
*/

select * 
from [housing data ]..[housing data]


--standadinzing date
select SaleDate,CONVERT(date,saledate)
from [housing data ]..[housing data]

--update [housing data ]..[housing data]
--set SaleDate=CONVERT(date,saledate)

alter table [housing data ]..[housing data]
add conv_date date

update [housing data ]..[housing data]
set conv_date=CONVERT(date,SaleDate)

select conv_date,CONVERT(date,saledate)
from [housing data ]..[housing data]


--populating property adreess data

select *
from [housing data ]..[housing data]

where PropertyAddress is null



select a.[UniqueID ],a.PropertyAddress,b.[UniqueID ],b.PropertyAddress,isnull(a.PropertyAddress,b.PropertyAddress)
from [housing data ]..[housing data] a
join [housing data ]..[housing data] b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


update a
set a.PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)--if we want to set value 
from [housing data ]..[housing data] a
join [housing data ]..[housing data] b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


--#breaking adress into diff columns

select PropertyAddress
from [housing data ]..[housing data]

--separeting based n deliminator ,

select 
SUBSTRING(PropertyAddress,1,CHARINDEX(',',propertyaddress)-1) as address-- -1 is used so that we can remove , at end
,SUBSTRING(PropertyAddress,CHARINDEX(',',propertyaddress)+1,len(propertyaddress)) as address-- +1 is used so that we can remove , at start
from [housing data ]..[housing data]

alter table [housing data ]..[housing data]
add property_adress varchar(225)

update [housing data ]..[housing data]
set property_adress=SUBSTRING(PropertyAddress,1,CHARINDEX(',',propertyaddress)-1)-- -1 is used so that we can remove , at end


alter table [housing data ]..[housing data]
add city   varchar(225)

update [housing data ]..[housing data]
set city=SUBSTRING(PropertyAddress,CHARINDEX(',',propertyaddress)+1,len(propertyaddress))-- +1 is used so that we can remove , at start




select *
from [housing data ]..[housing data]

--anouth way of doing 



select 
PARSENAME(replace(OwnerAddress,',','.'),3)
,PARSENAME(replace(OwnerAddress,',','.'),2)
,PARSENAME(replace(OwnerAddress,',','.'),1)
from [housing data ]..[housing data]

alter table [housing data ]..[housing data]
add owneradresssplit varchar(225)

update [housing data ]..[housing data]
set owneradresssplit=PARSENAME(replace(OwnerAddress,',','.'),3)


alter table [housing data ]..[housing data]
add ownercity varchar(225)

update [housing data ]..[housing data]
set ownercity=PARSENAME(replace(OwnerAddress,',','.'),2)

alter table [housing data ]..[housing data]
add ownerstate varchar(225)

update [housing data ]..[housing data]
set ownerstate=PARSENAME(replace(OwnerAddress,',','.'),1)

select * 
from [housing data ]..[housing data]

--changing y and n to yes and no 

select distinct(SoldAsVacant),count(SoldAsVacant)
from [housing data ]..[housing data]
group by SoldAsVacant
order by 2



select SoldAsVacant
,case when SoldAsVacant = 'Y' then 'YES'
      when SoldAsVacant = 'N' then 'NO'
	  else SoldAsVacant
	  END
from [housing data ]..[housing data]


update [housing data ]..[housing data]
set SoldAsVacant=case when SoldAsVacant = 'Y' then 'YES'
                      when SoldAsVacant = 'N' then 'NO'
	                  else SoldAsVacant
	                   END



--removing dublicates


select *,
ROW_NUMBER() over (partition by parcelID,saledate,saleprice,Legalreference order by UniqueID ) as row_num
from [housing data ]..[housing data]
--order by [UniqueID ]
--where row_num >2 --we cant use this

with dublicate as (
select *,
ROW_NUMBER() over (partition by parcelID,saledate,saleprice,Legalreference order by UniqueID ) as row_num
from [housing data ]..[housing data]
--order by [UniqueID ]
--where row_num >2 --we cant use this
)

delete
from dublicate
where row_num>1


--removing unused columns

select * 
from [housing data ]..[housing data]



alter table [housing data ]..[housing data]
drop column  saledate,propertyAddress,owneraddress









