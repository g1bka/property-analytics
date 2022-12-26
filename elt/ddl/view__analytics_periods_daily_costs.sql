/*
 DDL: analysis view `analytics.periods_daily_costs`
*/


CREATE OR REPLACE VIEW analytics.periods_daily_costs AS

WITH

  -- Get required fields from the staging table
  marketing_costs AS (
    SELECT
        ROW_NUMBER() OVER
          (ORDER BY date_from, date_to, campaign, "cost")     AS cost_id,
        date_from                                             AS date_from,
        date_to                                               AS date_to,
        campaign                                              AS campaign,
        "cost"                                                AS period_cost
    FROM
      staging.marketing_costs
  ),

  -- Perform conversions for dates and NULLs
  periods_dates AS (
    SELECT
      to_date(date_from, 'DD.MM.YY')                          AS date_from,
      to_date(date_to, 'DD.MM.YY')                            AS date_to,
      coalesce(
          campaign,
          'default_campaign'
      )                                                       AS campaign,
      period_cost                                             AS period_cost
    FROM
      marketing_costs
  ),

  -- Calculate duration for each campaign period
  periods_durations AS (
    SELECT
      date_from                                               AS date_from,
      date_to                                                 AS date_to,
      (date_to - date_from) + 1                               AS period_duration,
      period_cost                                             AS period_cost
    FROM
      periods_dates
  ),

  -- Calculate total duration and total cost for each period
  periods_totals AS (
    SELECT
      date_from                                               AS date_from,
      date_to                                                 AS date_to,
      sum(period_duration)                                    AS total_period_duration,
      sum(period_cost)                                        AS total_period_cost
    FROM
      periods_durations
    GROUP BY
      1, 2
  ),

  -- Campaign periods and daily cost for each period
  periods_daily_costs AS (
    SELECT
      date_from                                               AS date_from,
      date_to                                                 AS date_to,
      total_period_cost / total_period_duration               AS period_daily_cost
    FROM
      periods_totals
  )

SELECT * FROM periods_daily_costs;
