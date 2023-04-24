CREATE UNIQUE INDEX unique_email ON public.subscribers USING btree (email);

alter table "public"."subscribers" add constraint "unique_email" UNIQUE using index "unique_email";


