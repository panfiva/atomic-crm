supabase db pull
supabase db dump --data-only > supabase/dump-data.sql
supabase start
psql -h localhost -p 5432 -U postgres -d postgres -f supabase/dump-data.sql