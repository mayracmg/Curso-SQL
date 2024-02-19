/*
Clase 29 - Jobs
*/
CREATE TABLE reports.job_log (
	jog_log_id serial NOT NULL,
	"comment" varchar(500) NULL,
	log_date timestamptz NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT job_log_pk PRIMARY KEY (jog_log_id)
);

INSERT INTO reports.job_log (comment) VALUES ('Test');

SELECT *
FROM daily_payments;

TRUNCATE TABLE daily_payments;

INSERT INTO payment VALUES (DEFAULT, 1, 1, 1, 10, CURRENT_TIMESTAMP);
INSERT INTO payment VALUES (DEFAULT, 1, 1, 1, 100, CURRENT_TIMESTAMP);
INSERT INTO payment VALUES (DEFAULT, 2, 2, 2, 20, CURRENT_TIMESTAMP);
INSERT INTO payment VALUES (DEFAULT, 2, 2, 2, 200, CURRENT_TIMESTAMP);

SELECT *
FROM pgagent.pga_job j
LEFT JOIN pgagent.pga_jobstep s ON j.jobid = s.jstjobid
ORDER BY j.jobid, s.jstname;

SELECT *
FROM pgagent.pga_jobsteplog
WHERE jslid >= 45
ORDER BY jslid DESC;

DO $$
DECLARE
    jid integer;
    scid integer;
BEGIN
-- Creating a new job
INSERT INTO pgagent.pga_job(
    jobjclid, jobname, jobdesc, jobhostagent, jobenabled
) VALUES (
    1, 'Generate_Daily_Report', '', '', true
) RETURNING jobid INTO jid;

-- Steps
-- Inserting a step (jobid: NULL)
INSERT INTO pgagent.pga_jobstep (
    jstjobid, jstname, jstenabled, jstkind,
    jstconnstr, jstdbname, jstonerror,
    jstcode, jstdesc
) VALUES (
    jid, 'Run stored procedure', true, 's'::character(1),
    ''::text, 'dvdrental'::name, 'f'::character(1),
    'CALL reports.generate_daily_report();', ''
) ;

-- Schedules
-- Inserting a schedule
INSERT INTO pgagent.pga_schedule(
    jscjobid, jscname, jscdesc, jscenabled,
    jscstart,     jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths
) VALUES (
    jid, 'Every Day at 11PM', '', true,
    '2024-02-17 00:00:00-06'::timestamp with time zone, 
    -- Minutes
    '{t,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::bool[]::boolean[],
    -- Hours
    '{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,t}'::bool[]::boolean[],
    -- Week days
    '{t,t,t,t,t,t,t}'::bool[]::boolean[],
    -- Month days
    '{t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t}'::bool[]::boolean[],
    -- Months
    '{t,t,t,t,t,t,t,t,t,t,t,t}'::bool[]::boolean[]
) RETURNING jscid INTO scid;
END
$$;


SELECT *
FROM pgagent.pga_job j
LEFT JOIN pgagent.pga_jobstep s ON j.jobid = s.jstjobid
ORDER BY j.jobid, s.jstname;

SELECT *
FROM pgagent.pga_jobsteplog
ORDER BY jslid DESC;