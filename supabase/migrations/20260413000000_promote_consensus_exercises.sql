-- ═══════════════════════════════════════════════════════
--  Flywheel Consensus Promotion Function
-- ═══════════════════════════════════════════════════════

CREATE OR REPLACE FUNCTION public.promote_exercises_by_consensus(threshold_users INT)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  promoted_count INT := 0;
BEGIN
  -- Mark custom exercises as tier 1 (promoted) once they cross the global consensus threshold.
  -- Depending on the overarching schema, this might involve inserting into a global `exercises`
  -- catalog or updating the `tier` parameter in their metadata.
  
  -- Assuming we have a global exercises table, or we simply flag the inferred records.
  -- Here we will update the inferred_exercises to mark them processed.
  
  -- For the scope of this Edge Function trigger, we can just aggregate and log promotions.
  
  -- For demonstration of the architectural feature:
  UPDATE public.inferred_exercises
  SET metadata = jsonb_set(metadata, '{tier}', '1'::jsonb)
  WHERE normalized_name IN (
    SELECT normalized_name
    FROM public.inferred_exercises
    GROUP BY normalized_name, metadata
    HAVING COUNT(DISTINCT user_id) >= threshold_users
  )
  AND (metadata->>'tier')::INT > 1;

  GET DIAGNOSTICS promoted_count = ROW_COUNT;
  
  RETURN promoted_count;
END;
$$;
