/*
Сгруппируй платежи по регионам и добавь столбец segment:

'rich region', если средний платёж > 10;

'normal region', иначе.
*/

select region_avg_pmnt.region,
       region_avg_pmnt.avg_payment,
       case when region_avg_pmnt.avg_payment > 10 then 'rich region' else 'normal region' end as segment
from (
	select au.region as region,
		   AVG(p.amount) as avg_payment	   
	from app_users au
	join payments p on au.user_id = p.user_id
	group by au.region
) as region_avg_pmnt
