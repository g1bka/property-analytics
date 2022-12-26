/*
 DDL: analysis view `analytics.properties`
*/


CREATE OR REPLACE VIEW analytics.properties AS

WITH

  -- Get required fields from the properties inventory
  properties AS (
    SELECT
      property_id                                             AS property_id,
      created_at                                              AS converted_at,
      updated_at                                              AS updated_at,
      utm_campaign                                            AS campaign
    FROM
      staging.properties
  ),

  -- Property events log
  property_events AS (
    SELECT
      event_id                                                AS event_id,
      created_at                                              AS created_at,
      updated_at                                              AS updated_at,
      "action"                                                AS property_action,
      object_id                                               AS property_id
    FROM
      staging.property_events
  ),

  -- Qualified properties
  properties_converted_qualified AS (
    SELECT
      p.property_id                                           AS property_id,
      p.converted_at                                          AS converted_at,
      e.updated_at                                            AS qualified_at,
      p.campaign                                              AS campaign
    FROM
      properties p
      LEFT JOIN property_events e
        ON p.property_id = e.property_id
          AND e.property_action = 'StatusQualifiedProperties'
  )

SELECT * FROM properties_converted_qualified;
