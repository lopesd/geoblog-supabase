create table "public"."chapters" (
    "chapter_id" character varying not null,
    "chapter_header" text not null,
    "chapter_name" text not null,
    "summary" text,
    "chapter_index" double precision not null
);


create table "public"."checkins" (
    "checkin_id" character varying not null,
    "chapter_id" character varying not null,
    "latitude" double precision not null,
    "longitude" double precision not null,
    "title" text not null,
    "location_name" text not null,
    "checkin_time" text not null,
    "blurb" text not null,
    "spotify_song_id" text,
    "upload_time" timestamp with time zone not null,
    "allow_peep" boolean not null,
    "media" jsonb,
    "routes" jsonb
);


create table "public"."peeps" (
    "peep_id" character varying not null,
    "peeper_name" text not null,
    "peeper_leaderboard_name" text,
    "checkin_id" character varying not null,
    "comment" text,
    "peep_time" timestamp with time zone
);


create table "public"."subscribers" (
    "subscriber_id" character varying not null,
    "email" character varying not null
);


CREATE UNIQUE INDEX chapters_pkey ON public.chapters USING btree (chapter_id);

CREATE UNIQUE INDEX checkins_pkey ON public.checkins USING btree (checkin_id);

CREATE UNIQUE INDEX peeps_checkin_id_key ON public.peeps USING btree (checkin_id);

CREATE UNIQUE INDEX peeps_pkey ON public.peeps USING btree (peep_id);

CREATE UNIQUE INDEX subscribers_email_key ON public.subscribers USING btree (email);

alter table "public"."chapters" add constraint "chapters_pkey" PRIMARY KEY using index "chapters_pkey";

alter table "public"."checkins" add constraint "checkins_pkey" PRIMARY KEY using index "checkins_pkey";

alter table "public"."peeps" add constraint "peeps_pkey" PRIMARY KEY using index "peeps_pkey";

alter table "public"."checkins" add constraint "checkins_chapter_id_fkey" FOREIGN KEY (chapter_id) REFERENCES chapters(chapter_id) ON DELETE CASCADE not valid;

alter table "public"."checkins" validate constraint "checkins_chapter_id_fkey";

alter table "public"."peeps" add constraint "peeps_checkin_id_fkey" FOREIGN KEY (checkin_id) REFERENCES checkins(checkin_id) ON DELETE CASCADE not valid;

alter table "public"."peeps" validate constraint "peeps_checkin_id_fkey";

alter table "public"."peeps" add constraint "peeps_checkin_id_key" UNIQUE using index "peeps_checkin_id_key";

alter table "public"."subscribers" add constraint "subscribers_email_key" UNIQUE using index "subscribers_email_key";


set check_function_bodies = off;

CREATE OR REPLACE FUNCTION storage.extension(name text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return split_part(_filename, '.', 2);
END
$function$
;

CREATE OR REPLACE FUNCTION storage.filename(name text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$function$
;

CREATE OR REPLACE FUNCTION storage.foldername(name text)
 RETURNS text[]
 LANGUAGE plpgsql
AS $function$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$function$
;


