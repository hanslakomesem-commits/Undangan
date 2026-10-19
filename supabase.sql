-- Jalankan di Supabase SQL Editor.
create extension if not exists pgcrypto;
create table if not exists public.admins (user_id uuid primary key references auth.users(id) on delete cascade);
create table if not exists public.invitations (
 id uuid primary key default gen_random_uuid(),
 code text not null unique, name text not null, category text not null default 'Custom',
 description text default '', fold text default 'bifold', size text default '',
 paper text default '', price numeric(12,0), cover text, inside text,
 back text, detail text, published boolean not null default false,
 created_at timestamptz not null default now()
);
create or replace function public.is_showroom_admin() returns boolean language sql stable security definer set search_path = '' as $$
 select exists(select 1 from public.admins where user_id = (select auth.uid()));
$$;
revoke all on function public.is_showroom_admin() from public;
grant execute on function public.is_showroom_admin() to anon, authenticated;
alter table public.admins enable row level security;
alter table public.invitations enable row level security;
create policy "admins view self" on public.admins for select to authenticated using (user_id = (select auth.uid()));
create policy "public published catalog" on public.invitations for select to anon, authenticated using (published = true or public.is_showroom_admin());
create policy "admin add" on public.invitations for insert to authenticated with check (public.is_showroom_admin());
create policy "admin edit" on public.invitations for update to authenticated using (public.is_showroom_admin()) with check (public.is_showroom_admin());
create policy "admin delete" on public.invitations for delete to authenticated using (public.is_showroom_admin());
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('invitation-images','invitation-images',true,8388608,array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public=true,file_size_limit=8388608,allowed_mime_types=array['image/jpeg','image/png','image/webp'];
create policy "read invitation images" on storage.objects for select to public using (bucket_id='invitation-images');
create policy "admin upload images" on storage.objects for insert to authenticated with check (bucket_id='invitation-images' and public.is_showroom_admin());
create policy "admin remove images" on storage.objects for delete to authenticated using (bucket_id='invitation-images' and public.is_showroom_admin());
-- Setelah membuat user admin di Authentication > Users, jalankan secara manual:
-- insert into public.admins(user_id) values ('UUID-USER-ADMIN-DARI-AUTHENTICATION');
