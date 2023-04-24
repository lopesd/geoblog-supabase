drop table subscribers;

create table subscribers (
  subscriber_id uuid not null default uuid_generate_v4(),
  email varchar not null unique,

  primary key (subscriber_id)
);