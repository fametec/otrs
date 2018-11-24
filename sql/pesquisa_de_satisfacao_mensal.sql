select 
 DATE_FORMAT(sv.create_time, "%Y") as Ano,
 DATE_FORMAT(sv.create_time, "%m") as Mes, 
 sa.answer as respostas, 
 count(sa.answer) as votos 
from 
 survey_answer sa,
 survey_vote sv   
where 
 sa.id = sv.vote_value and 
 sv.question_id = 1 
group by sa.answer, DATE_FORMAT(sv.create_time, "%Y-%m")
order by Ano, Mes desc;