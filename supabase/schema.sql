create extension if not exists "pgcrypto";

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  code text not null,
  description text not null,
  quantity integer not null default 1 check (quantity >= 0),
  length_cm numeric not null default 0,
  width_cm numeric not null default 0,
  height_cm numeric not null default 0,
  weight_kg numeric not null default 0,
  max_stack integer not null default 1,
  created_at timestamptz not null default now(),
  unique(user_id, code)
);

create table if not exists public.vehicles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  length_cm numeric not null default 0,
  width_cm numeric not null default 0,
  height_cm numeric not null default 0,
  capacity_kg numeric not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.loads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  vehicle_id uuid references public.vehicles(id) on delete set null,
  name text not null default 'Novo carregamento',
  status text not null default 'rascunho',
  created_at timestamptz not null default now()
);

create table if not exists public.load_items (
  id uuid primary key default gen_random_uuid(),
  load_id uuid not null references public.loads(id) on delete cascade,
  product_id uuid references public.products(id) on delete set null,
  quantity integer not null default 1,
  pos_x numeric,
  pos_y numeric,
  pos_z numeric,
  rot_x numeric default 0,
  rot_y numeric default 0,
  rot_z numeric default 0
);

alter table public.products enable row level security;
alter table public.vehicles enable row level security;
alter table public.loads enable row level security;
alter table public.load_items enable row level security;

create policy "products own" on public.products for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "vehicles own" on public.vehicles for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "loads own" on public.loads for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "load items own" on public.load_items for all
using (exists(select 1 from public.loads l where l.id=load_id and l.user_id=auth.uid()))
with check (exists(select 1 from public.loads l where l.id=load_id and l.user_id=auth.uid()));