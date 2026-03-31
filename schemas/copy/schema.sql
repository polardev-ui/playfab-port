CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
    custom_id TEXT UNIQUE NOT NULL, 
    display_name TEXT DEFAULT 'gorilla',
    
    red_value FLOAT4 DEFAULT 0.0,
    green_value FLOAT4 DEFAULT 0.0,
    blue_value FLOAT4 DEFAULT 0.0,
    
=    stick_turning TEXT DEFAULT 'SNAP', 
    turn_factor INT4 DEFAULT 4,
    ptt_type TEXT DEFAULT 'ALL CHAT',
    voice_chat_on BOOLEAN DEFAULT TRUE,
    current_queue TEXT DEFAULT 'DEFAULT', 
    allowed_in_competitive BOOLEAN DEFAULT FALSE,
    
    last_login TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.bans (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users ON DELETE CASCADE,
    reason TEXT NOT NULL,
    expires_at TIMESTAMPTZ, 
    is_ip_ban BOOLEAN DEFAULT FALSE,
    banned_ip TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bans ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own profile" 
ON public.profiles FOR SELECT 
USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" 
ON public.profiles FOR UPDATE 
USING (auth.uid() = id);

CREATE POLICY "Users can view own bans" 
ON public.bans FOR SELECT 
USING (auth.uid() = user_id);

CREATE OR REPLACE FUNCTION public.handle_new_user() 
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, custom_id, display_name)
  VALUES (
    NEW.id, 
    NEW.raw_user_meta_data->>'custom_id', 
    COALESCE(NEW.raw_user_meta_data->>'display_name', 'gorilla')
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
