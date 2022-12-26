/*
  DDL: table `staging.property_events`
*/


CREATE TABLE IF NOT EXISTS staging.property_events (
  event_id bigint primary key,
  updated_at timestamp not null,
  object_type varchar(32),
  action varchar(64),
  created_at timestamp not null,
  object_id bigint not null
);

CREATE INDEX IF NOT EXISTS idx__event_id
  ON staging.property_events(event_id);

CREATE INDEX IF NOT EXISTS idx__object_id
  ON staging.property_events(object_id);
