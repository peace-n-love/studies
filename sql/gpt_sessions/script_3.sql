/*
Добавь к таблице subscriptions поле status с пометкой:

'active', если end_at >= '2025-01-01';

'expired', иначе.
*/

select *,
       case when s.end_at >= '2025-01-01' then 'active' else 'expired' end as status
from subscriptions s;
