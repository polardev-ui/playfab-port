-- ################################################################
-- GENERAL UNITY GAME BACKEND SCHEMA (SUPABASE / POSTGRES)
-- Designed for scalability and Row Level Security (RLS)
-- Please edit this for your need before putting it into Supabase.
-- ################################################################

-- EXTENSIONS: Enable UUID support for unique IDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- 1. PLAYER PROFILES
-- ============================================================
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
    username TEXT UNIQUE,
    avatar_url TEXT,
    xp INTEGER DEFAULT 0,
    level INTEGER DEFAULT 1,
    currency_soft INTEGER DEFAULT 0, -- Earnable currency
    currency_hard INTEGER DEFAULT 0, -- Premium currency
    last_seen TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    
    metadata JSONB DEFAULT '{}'::jsonb,
    
    CONSTRAINT username_length CHECK (char_length(username) >= 3)
);

-- ============================================================
-- 2. INVENTORY SYSTEM
-- ============================================================
CREATE TABLE IF NOT EXISTS public.items (
    id SERIAL PRIMARY KEY,
    item_key TEXT UNIQUE NOT NULL,
    item_name TEXT NOT NULL,
    item_type TEXT, -- e.g., "consumable", "cosmetic"
    rarity TEXT DEFAULT 'common'
);

CREATE TABLE IF NOT EXISTS public.player_inventory (
    id BIGSERIAL PRIMARY KEY,
    player_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    item_id INTEGER REFERENCES public.items(id),
    quantity INTEGER DEFAULT 1,
    is_equipped BOOLEAN DEFAULT FALSE,
    acquired_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 3. GLOBAL LEADERBOARDS
-- ============================================================
CREATE TABLE IF NOT EXISTS public.leaderboards (
    id BIGSERIAL PRIMARY KEY,
    player_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    stat_name TEXT NOT NULL, -- e.g., "high_score", "kills"
    stat_value BIGINT DEFAULT 0,
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(player_id, stat_name)
);

-- ============================================================
-- 4. SECURITY (Row Level Security)
-- ============================================================
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.player_inventory ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.leaderboards ENABLE ROW LEVEL SECURITY;

-- Profiles: Anyone can read a profile (for friends/leaderboards), but only owner can update
CREATE POLICY "Public profiles are viewable by everyone" ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING (auth.uid() = id);

-- Inventory: Only the player can see or modify their own items
CREATE POLICY "Users can view own inventory" ON public.player_inventory FOR SELECT USING (auth.uid() = player_id);

-- Leaderboards: Everyone can see scores, but only the system/player can update
CREATE POLICY "Leaderboards are public" ON public.leaderboards FOR SELECT USING (true);
CREATE POLICY "Users can update own scores" ON public.leaderboards FOR UPSERT WITH CHECK (auth.uid() = player_id);

-- ============================================================
-- 5. AUTOMATION (Trigger for new players)
-- ============================================================
CREATE OR REPLACE FUNCTION public.handle_new_player() 
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, username, metadata)
  VALUES (
    NEW.id, 
    NEW.raw_user_meta_data->>'username',
    '{"first_login": true}'::jsonb
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_player();
