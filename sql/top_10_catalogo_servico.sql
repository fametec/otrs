select
	sv.name as "SERVIÇO", 
	count(t.id) as "TICKETS"
from
	ticket t,
	queue q,
	ticket_state ts,
	service sv
where
	t.service_id = sv.id and
	t.queue_id = q.id and
	t.ticket_state_id = ts.id and
	q.name <> 'Lixo' 
group by
	sv.name
order by 
	TICKETS desc;