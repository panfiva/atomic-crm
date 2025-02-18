create table public.company_material_fees (
    "id" bigint generated by default as identity not null,
    "company_id" bigint not null,
    "material_id" bigint not null,
    "fee" numeric(10,2) not null 
);

alter table public.company_material_fees enable row level security;

CREATE UNIQUE INDEX company_material_fees_pkey ON public.company_material_fees USING btree (id);
alter table public.company_material_fees add constraint "company_material_fees_pkey" PRIMARY KEY using index "company_material_fees_pkey";

alter table public.company_material_fees add constraint "company_material_fees_material_id_fkey" FOREIGN KEY (material_id) REFERENCES materials(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;
alter table public.company_material_fees validate constraint "company_material_fees_material_id_fkey";

alter table public.company_material_fees add constraint "company_material_fees_company_id_fkey" FOREIGN KEY (company_id) REFERENCES companies(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;
alter table public.company_material_fees validate constraint "company_material_fees_company_id_fkey";

ALTER TABLE  public.company_material_fees add constraint "company_material_fees_uk" UNIQUE (company_id, material_id);

grant delete on table public.company_material_fees to "authenticated";
grant insert on table public.company_material_fees to "authenticated";
grant select on table public.company_material_fees to "authenticated";
grant update on table public.company_material_fees to "authenticated";

grant delete on table public.company_material_fees to "service_role";
grant insert on table public.company_material_fees to "service_role";
grant references on table public.company_material_fees to "service_role";
grant select on table public.company_material_fees to "service_role";
grant trigger on table public.company_material_fees to "service_role";
grant truncate on table public.company_material_fees to "service_role";
grant update on table public.company_material_fees to "service_role";


create policy "Enable insert for authenticated users only"
on public.company_material_fees
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for authenticated users"
on public.company_material_fees
as permissive
for select
to authenticated
using (true);


create policy "Enable update for authenticated users only"
on public.company_material_fees
as permissive
for update
to authenticated
using (true)
with check (true);

create policy "Enable delete for authenticated users only"
on public.company_material_fees
as permissive
for delete
to authenticated
using (true)
