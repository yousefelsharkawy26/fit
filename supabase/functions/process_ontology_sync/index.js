import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  // CORS Preflight
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '' // Used to bypass RLS for aggregation
    );

    const { syncItems } = await req.json();

    if (!syncItems || syncItems.length === 0) {
      return new Response(JSON.stringify({ success: true, message: 'Empty queue' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    let processedCount = 0;

    for (const item of syncItems) {
      try {
        const payload = JSON.parse(item.payload);

        switch (item.action) {
          case 'report_flywheel': {
            // User actively indicated a substitute was poor ("Bad Match").
            // Downrank this edge logically in our global scoring metric.
            const { source_exercise_id, rejected_exercise_id, user_id } = payload;
            
            await supabaseClient.from('flywheel_rejections').insert({
              source_id: source_exercise_id,
              rejected_id: rejected_exercise_id,
              user_id: user_id,
              // DB trigger automatically aggregates to global_penalty_score
            });
            break;
          }

          case 'infer_metadata': {
            // User added a custom exercise (Tier 2).
            // Track consensus. If enough users define the exact same custom properties, 
            // trigger Promotion to Tier 1.
            const { exercise_name, metadata, user_id } = payload;

            // Normalize names for consensus tracking (e.g., "Lat Pull Down" vs "lat pulldown")
            const normalizedName = exercise_name.trim().toLowerCase().replace(/[^a-z0-9]/g, '');

            await supabaseClient.from('inferred_exercises').insert({
              original_name: exercise_name,
              normalized_name: normalizedName,
              user_id: user_id,
              metadata: metadata // JSONB containing MovementPattern, MuscleRole, etc.
            });

            // Promotion logic is best handled via Postgres Trigger or periodic CRON check
            // that checks: if count(normalized_name) > consensous_threshold, then promote 
            // to global Tier 1 'exercises' table.
            break;
          }

          default:
            console.warn(`Unknown sync action: ${item.action}`);
        }
        processedCount++;
      } catch (err) {
        console.error(`Failed to process item ${item.id}:`, err);
        // Continue processing others even if one format was corrupt
      }
    }

    return new Response(JSON.stringify({ success: true, processed: processedCount }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    });

  } catch (error) {
    console.error('Edge Function Error:', error.message);
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    });
  }
});
