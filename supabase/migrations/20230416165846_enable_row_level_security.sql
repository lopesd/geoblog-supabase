alter table "public"."chapters" enable row level security;

alter table "public"."checkins" enable row level security;

alter table "public"."peeps" enable row level security;

alter table "public"."subscribers" enable row level security;

create policy "Enable read access for all users"
on "public"."chapters"
as permissive
for select
to public
using (true);


create policy "Enable read access for all users"
on "public"."checkins"
as permissive
for select
to public
using (true);


create policy "Enable read access for all users"
on "public"."peeps"
as permissive
for select
to public
using (true);


create policy "Enable read access for all users"
on "public"."subscribers"
as permissive
for select
to public
using (true);



