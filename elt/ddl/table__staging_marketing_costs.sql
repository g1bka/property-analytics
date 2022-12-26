/*
  DDL: table `staging.marketing_costs`
*/


CREATE TABLE IF NOT EXISTS staging.marketing_costs (
  date_from varchar(8) not null,
  date_to varchar(8) not null,
  cost_type varchar(32) not null,
  medium varchar(32) not null,
  source varchar(32),
  campaign varchar(256),
  term varchar(32),
  content varchar(32),
  cost numeric(12, 4) not null
);

CREATE INDEX IF NOT EXISTS idx__cost
  ON staging.marketing_costs(cost);
