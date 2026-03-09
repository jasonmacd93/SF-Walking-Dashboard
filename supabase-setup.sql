-- SF Street Walker — run this once in your Supabase SQL Editor
-- Creates a single table to store walked street IDs per user

create table if not exists walked_streets (
  id           bigint generated always as identity primary key,
  uid          text not null,
  way_id       text not null,
  walked_at    timestamptz default now(),
  unique (uid, way_id)
);

-- Index for fast lookups by uid
create index if not exists walked_streets_uid_idx on walked_streets (uid);

-- Enable Row Level Security (open read/write since we're using secret UIDs)
alter table walked_streets enable row level security;

create policy "allow all by uid"
  on walked_streets
  for all
  using (true)
  with check (true);
