-- Jalankan di Supabase SQL Editor.
-- Row Level Security memastikan setiap pengguna hanya mengakses datanya sendiri.

create table if not exists public.tracker_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  accounts jsonb not null default '[]'::jsonb,
  followers_count integer not null default 0,
  following_count integer not null default 0,
  updated_at timestamptz not null default now()
);

create table if not exists public.tracker_activity (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  action text not null check (action in ('import','visited','undo')),
  username text,
  created_at timestamptz not null default now()
);

alter table public.tracker_data enable row level security;
alter table public.tracker_activity enable row level security;

drop policy if exists "Users manage own tracker data" on public.tracker_data;
create policy "Users manage own tracker data"
on public.tracker_data for all
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users read own activity" on public.tracker_activity;
create policy "Users read own activity"
on public.tracker_activity for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "Users insert own activity" on public.tracker_activity;
create policy "Users insert own activity"
on public.tracker_activity for insert
to authenticated
with check (auth.uid() = user_id);
