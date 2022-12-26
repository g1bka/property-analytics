/*
 DDL: analysis view `analytics.daily_visits`
*/


CREATE OR REPLACE VIEW analytics.daily_visits AS

WITH

  -- Get required fields from the staging table
  ga_sessions AS (
    SELECT
      visit_id                                                AS visit_id,
      to_date(visit_date, 'YYYYMMDD')                         AS visit_date,
      traffic_source #>> '{campaign}'                         AS campaign,
      client_id                                               AS client_id
    FROM
      staging.ga_sessions
  ),

  -- Daily visits mart: date, visit counts
  daily_visits AS (
    SELECT
      visit_date,
      count(visit_id)                                         AS visits_per_day,
      count(DISTINCT visit_id)                                AS unique_visits_per_day
    FROM
      ga_sessions
    GROUP BY 1
  )

SELECT * FROM daily_visits;
