-- ═══════════════════════════════════════════════════════
--  FitOS Data Flywheel - Supabase Schema setup
-- ═══════════════════════════════════════════════════════

-- Table: flywheel_rejections
-- Tracks whenever a user "rejects" a vector substitution match.
CREATE TABLE IF NOT EXISTS public.flywheel_rejections (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    source_id TEXT NOT NULL,
    rejected_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table: inferred_exercises
-- Tracks when a user creates a custom (Tier 2) exercise.
-- The Flywheel reads this to promote to Tier 1 upon gaining global consensus.
CREATE TABLE IF NOT EXISTS public.inferred_exercises (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    original_name TEXT NOT NULL,
    normalized_name TEXT NOT NULL,
    user_id TEXT NOT NULL,
    metadata JSONB NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexing for fast consensus aggregation
CREATE INDEX IF NOT EXISTS idx_inferred_normalized ON public.inferred_exercises(normalized_name);
CREATE INDEX IF NOT EXISTS idx_flywheel_pairs ON public.flywheel_rejections(source_id, rejected_id);

-- Optional: Create a materialized view or scheduled function to find promotions
-- For example, identifying exercises inputted > 100 times consistently by different users
CREATE OR REPLACE VIEW public.consensus_promotions AS
SELECT 
    normalized_name,
    metadata,
    COUNT(DISTINCT user_id) as inference_count
FROM public.inferred_exercises
GROUP BY normalized_name, metadata
HAVING COUNT(DISTINCT user_id) >= 50;
