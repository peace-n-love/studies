/*
 Создай список всех платежей с категорией:

'low', если amount < 9;

'medium', если 9–11;

'high', если > 11.

Отсортируй по user_id и дате.
*/

select au.user_id,
	   p.created_at,
	   case
		   when p.amount < 9 then 'low'
		   when p.amount between 9 and 11 then 'medium'
		   when p.amount > 11 then 'high'
	   end as amount_size
from app_users au 
join payments p on au.user_id = p.user_id
order by au.user_id, p.created_at;