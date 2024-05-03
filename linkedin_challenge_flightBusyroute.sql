-- Problem statement:
-- For an airline company following are the ticket data points:
-- booking_date, pnr, origin ,destination, oneway_round, ticket_count
-- oneway_round ='O' -> One Way Trip
-- oneway_round ='R' -> Round Trip
-- Write a query to identify the busiest route.
--  Note: LAX -> JFK is different route from JFK -> LAX
create or replace table flights (booking_date date, pnr varchar(30), origin  varchar(30), destination  varchar(30), oneway_round  varchar(30), ticket_count int)
;

INSERT INTO flights (booking_date, pnr, origin, destination, oneway_round, ticket_count) VALUES
('2024-05-05', 'XYZ234', 'AUS', 'DFW', 'O', 2),
('2024-05-05', 'UVW567', 'DFW', 'LAX', 'R', 1),
('2024-05-06', 'RST890', 'LAX', 'JFK', 'O', 3),
('2024-05-06', 'OPQ123', 'JFK', 'AUS', 'R', 2),
('2024-05-07', 'LMN456', 'AUS', 'DFW', 'O', 4),
('2024-05-07', 'GHI789', 'DFW', 'LAX', 'O', 1),
('2024-05-08', 'DEF012', 'LAX', 'JFK', 'R', 2),
('2024-05-08', 'ABC345', 'JFK', 'AUS', 'O', 3),
('2024-05-09', 'KLM678', 'AUS', 'DFW', 'R', 5),
('2024-05-09', 'NOP901', 'DFW', 'LAX', 'O', 2),
('2024-05-10', 'QRS234', 'LAX', 'JFK', 'R', 8),
('2024-05-10', 'TUV567', 'JFK', 'AUS', 'O', 1),
('2024-05-11', 'WXY890', 'AUS', 'DFW', 'R', 3),
('2024-05-11', 'ZAB123', 'DFW', 'LAX', 'O', 2),
('2024-05-12', 'CDE456', 'LAX', 'JFK', 'R', 1),
('2024-05-12', 'FGH789', 'JFK', 'AUS', 'O', 4);

WITH cte1
AS (
	SELECT booking_date,pnr,
	CASE WHEN oneway_round = 'R' THEN destination END AS origin,
	CASE WHEN oneway_round = 'R' THEN origin END AS destination,
	oneway_round,
	ticket_count
	FROM flights
	WHERE oneway_round = 'R'
	)
SELECT origin,
destination,
sum(ticket_count) AS total_tickets
FROM (
	SELECT 'f' tbl		,*	FROM flights
	UNION ALL
	SELECT 'cte1'		,*	FROM cte1
	) un
GROUP BY origin	,destination
ORDER BY total_tickets DESC LIMIT 1
	;

