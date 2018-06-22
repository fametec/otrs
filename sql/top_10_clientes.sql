select 
	cc.name as CLIENTE, 
	count(*) as TICKETS 
from 
	ticket t, 
	queue q, 
	ticket_state ts, 
	customer_company cc 
where 
	cc.customer_id = t.customer_id and 
	t.queue_id = q.id and 
	t.ticket_state_id = ts.id and 
	q.name <> 'Lixo' 
group by 
	t.customer_id 
order by 
	TICKETS desc 
limit 10;