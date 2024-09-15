/*
1. turn 순으로 정렬
2. weight 누적
3. 1000 이하 중 가장 큰 값의 이름 구하기

1. order by turn
2. sum(weight) over (order by turn)
3. max() where
*/

-- 1
select 
    q.*, sum(weight) over (order by turn) as cumul
from 
    Queue q
order by turn;
/*
| person_id | person_name | weight | turn | cumul |
| --------- | ----------- | ------ | ---- | ----- |
| 5         | Alice       | 250    | 1    | 250   |
| 3         | Alex        | 350    | 2    | 600   |
| 6         | John Cena   | 400    | 3    | 1000  |
| 2         | Marie       | 200    | 4    | 1200  |
| 4         | Bob         | 175    | 5    | 1375  |
| 1         | Winston     | 500    | 6    | 1875  |
*/

-- 2
with sub as (
    select 
        q.*, 
        sum(weight) over (order by turn) as cumul
    from 
        Queue q
)
select
    sub.*
from
    sub
where
    cumul <= 1000
order by
    cumul desc
;
/*
| person_id | person_name | weight | turn | cumul |
| --------- | ----------- | ------ | ---- | ----- |
| 6         | John Cena   | 400    | 3    | 1000  |
| 3         | Alex        | 350    | 2    | 600   |
| 5         | Alice       | 250    | 1    | 250   |
*/

-- 3
with sub as (
    select 
        q.*, 
        sum(weight) over (order by turn) as cumul
    from 
        Queue q
)
select
    person_name
from
    sub
where
    cumul <= 1000
order by
    cumul desc
limit 1;
/*
| person_name |
| ----------- |
| John Cena   |
*/