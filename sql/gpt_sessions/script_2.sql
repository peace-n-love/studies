/*
	Для каждого пользователя посчитай:
	
	сумму “дорогих” платежей (amount > 10);
	
	сумму “дешёвых” (amount ≤ 10).
 */

select au.user_id,
	   sum(case when p.amount > 10 then p.amount else 0 end) as expensive_payments,
	   sum(case when p.amount <= 10 then p.amount else 0 end) as cheap_payments
from app_users au
join payments p on au.user_id = p.user_id 
group by au.user_id
order by au.user_id