
-- 1. faks numaras� olmayan m��terilerime fax numaras� atanmas�
select * into #1 from Customers
update #1
set Fax = '(5) 555-3745'
 from #1 c
where c.Fax is null

select * from #1


-- 2. en �ok sat�� yap�lan 3 m��teri ve en �ok sat�n alma yapt���m 3 m��teriye VIP m��teri tan�mlanmas�
select * into #2 from Customers
alter table #2
add VIP bit

update #2
set cm.VIP = 1
from #2 cm where cm.CustomerID in (
(select top 3 c.CustomerID, count(*) from Customers c
inner join Orders o 
on c.CustomerID = o.CustomerID
group by c.CustomerID
order by count(*) desc)
union
(
select * from
)
) 

select * from #2
