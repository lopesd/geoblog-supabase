alter table "public"."subscribers" add column "subscribed_at" timestamp without time zone not null default now();


