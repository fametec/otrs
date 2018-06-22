select
	-- (s.solution_time * 60) as SOLUTION_TIME, 
	-- ((s.solution_notify * (s.solution_time * 60))/100) as SOLUTION_NOTIFY, 
	t.tn as TICKET,
	t.title as TÍTULO,
	s.name as SLA,
	q.name as FILA,
	t.create_time ABERTURA,
	subtime(from_unixtime(t.escalation_solution_time),'3:00:00') as "PRAZO SOLUÇÃO" 
	-- sec_to_time(to_seconds(from_unixtime(t.escalation_solution_time))-to_seconds(now())) as "TEMPO RESTANTE"
from
	ticket t,
	queue q,
	ticket_state ts,
	sla s
where
	t.queue_id = q.id and
	t.ticket_state_id = ts.id and
	t.sla_id = s.id and
	q.name <> 'Lixo' and
	ts.id not in (2,3,10) and
	from_unixtime(t.escalation_solution_time) > NOW() and
	t.escalation_solution_time > 0 and 
	(to_seconds(from_unixtime(t.escalation_solution_time))-to_seconds(now())) < ((s.solution_notify * (s.solution_time * 60))/100); 