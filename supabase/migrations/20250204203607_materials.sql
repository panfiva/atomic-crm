create table public.materials (
    "id" bigint generated by default as identity not null,
    "name" text not null,
    "active" boolean not null default true
);

alter table public.materials enable row level security;

CREATE UNIQUE INDEX materials_pkey ON public.materials USING btree (id);
alter table public.materials add constraint "materials_pkey" PRIMARY KEY using index "materials_pkey";


ALTER TABLE  public.materials add constraint "materials_uk" UNIQUE (name);


grant delete on table public.materials to "authenticated";
grant insert on table public.materials to "authenticated";
grant select on table public.materials to "authenticated";
grant update on table public.materials to "authenticated";

grant delete on table public.materials to "service_role";
grant insert on table public.materials to "service_role";
grant references on table public.materials to "service_role";
grant select on table public.materials to "service_role";
grant trigger on table public.materials to "service_role";
grant truncate on table public.materials to "service_role";
grant update on table public.materials to "service_role";

create policy "Enable insert for authenticated users only"
on public.materials
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for authenticated users"
on public.materials
as permissive
for select
to authenticated
using (true);


create policy "Enable update for authenticated users only"
on public.materials
as permissive
for update
to authenticated
using (true)
with check (true);

create policy "Enable delete for authenticated users only"
on public.materials
as permissive
for delete
to authenticated
using (true);