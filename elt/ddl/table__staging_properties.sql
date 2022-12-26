/*
  DDL: table `staging.properties`
*/


CREATE TABLE IF NOT EXISTS staging.properties (
  property_id bigint not null,
  zip_code integer,
  apartment_type varchar(32),
  living_space numeric(10, 1),
  city varchar(64),
  created_at timestamp not null,
  uid varchar(32),
  updated_at timestamp not null,
  considers_to_sell varchar(64),
  slider_type varchar(32),
  property_type varchar(32),
  construction_year varchar(32),
  stage varchar(32),
  country varchar(2),
  utm_medium varchar(32),
  marketing_type varchar(32),
  loss_reason_id integer,
  admin_user_id integer,
  utm_campaign varchar(64),
  utm_source varchar(32),
  building_type varchar(32),
  landing_page varchar(512)
);

CREATE INDEX IF NOT EXISTS idx__property_id
  ON staging.properties(property_id);

CREATE INDEX IF NOT EXISTS idx__created_at
  ON staging.properties(created_at);
