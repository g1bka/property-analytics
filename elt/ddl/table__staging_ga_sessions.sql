/*
  DDL: table `staging.ga_sessions`
*/


CREATE TABLE IF NOT EXISTS staging.ga_sessions (
  file varchar(256) not null,
  visit_id bigint not null,
  visit_start_time timestamp not null,
  visit_date varchar(8) not null,
  totals jsonb not null,
  traffic_source jsonb not null,
  device jsonb not null,
  custom_dimensions varchar(256) not null,
  hits jsonb not null,
  client_id bigint not null
);

CREATE INDEX IF NOT EXISTS idx__visit_id
  ON staging.ga_sessions(visit_id);

CREATE INDEX IF NOT EXISTS idx__client_id
  ON staging.ga_sessions(client_id);
