/*
 DDL: analysis view `analytics.campaigns_costs`
*/


CREATE OR REPLACE VIEW analytics.campaigns_costs AS

WITH

  -- Get required fields from the staging table
  marketing_costs AS (
    SELECT
        date_from                                             AS date_from,
        date_to                                               AS date_to,
        campaign                                              AS campaign,
        "cost"                                                AS period_cost
    FROM
      staging.marketing_costs
  ),

  -- Perform conversions for dates and NULLs
  campaigns_dates AS (
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

  campaigns_costs AS (
    SELECT
      campaign                                                AS campaign,
      sum(period_cost)                                        AS total_cost
    FROM
      campaigns_dates
    GROUP BY 1
  )

SELECT * FROM campaigns_costs;
