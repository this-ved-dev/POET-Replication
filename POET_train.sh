#!/bin/bash

CONFIG="config/nturgbd-cross-subject/temp_24nov.yaml"
DEVICE="0"
EXP_NAME="POET_repl_fullrun"

for var in "$@"
do
  echo "Running few-shot set ${var}"

  # Create a separate subfolder for each set
  OUT_DIR="work_dir/ntu60/csub/ctrgcn_prompt/set${var}"
  mkdir -p ${OUT_DIR}

  # ---------- Step 1 ----------
  python poet_main.py \
    --config $CONFIG --device $DEVICE \
    --IL_step 1 --labels_prev_step 40 --maxlabelid_curr_step 45 \
    --k_shot 5 \
    --few_shot_data_file few_shot_splits/NTU60_5shots_set${var}.npz \
    --weights work_dir/ntu60/csub/ctrgcn_prompt/Prompt_642564step0_add_cosinecls_wsig-50.pt \
    --query_checkpoint work_dir/ntu60/csub/ctrgcn_prompt/Prompt_642564step0_add_cosinecls_wsig-query-50.pt \
    --save_name_args "Prompt_POET_multiple_runs_step1" \
    --classifier_average_init --prompt_sim_reg --save_numbers_to_csv \
    --experiment_name $EXP_NAME --train_eval


  # ---------- Step 2 ----------
  python poet_main.py \
    --config $CONFIG --device $DEVICE \
    --IL_step 2 --labels_prev_step 45 --maxlabelid_curr_step 50 \
    --k_shot 5 \
    --few_shot_data_file few_shot_splits/NTU60_5shots_set${var}.npz \
    --weights work_dir/ntu60/csub/ctrgcn_prompt/Prompt_POET_multiple_runs_step1-5.pt \
    --query_checkpoint work_dir/ntu60/csub/ctrgcn_prompt/Prompt_POET_multiple_runs_step1-query-5.pt \
    --save_name_args "Prompt_POET_multiple_runs_step2" \
    --classifier_average_init --prompt_sim_reg --save_numbers_to_csv \
    --experiment_name $EXP_NAME --train_eval


  # ---------- Step 3 ----------
  python poet_main.py \
    --config $CONFIG --device $DEVICE \
    --IL_step 3 --labels_prev_step 50 --maxlabelid_curr_step 55 \
    --k_shot 5 \
    --few_shot_data_file few_shot_splits/NTU60_5shots_set${var}.npz \
    --weights work_dir/ntu60/csub/ctrgcn_prompt/Prompt_POET_multiple_runs_step2-5.pt \
    --query_checkpoint work_dir/ntu60/csub/ctrgcn_prompt/Prompt_POET_multiple_runs_step2-query-5.pt \
    --save_name_args "Prompt_POET_multiple_runs_step3" \
    --classifier_average_init --prompt_sim_reg --save_numbers_to_csv \
    --experiment_name $EXP_NAME --train_eval


  # ---------- Step 4 ----------
  python poet_main.py \
    --config $CONFIG --device $DEVICE \
    --IL_step 4 --labels_prev_step 55 --maxlabelid_curr_step 60 \
    --k_shot 5 \
    --few_shot_data_file few_shot_splits/NTU60_5shots_set${var}.npz \
    --weights work_dir/ntu60/csub/ctrgcn_prompt/Prompt_POET_multiple_runs_step3-5.pt \
    --query_checkpoint work_dir/ntu60/csub/ctrgcn_prompt/Prompt_POET_multiple_runs_step3-query-5.pt \
    --save_name_args "Prompt_POET_multiple_runs_step4" \
    --classifier_average_init --prompt_sim_reg --save_numbers_to_csv \
    --experiment_name $EXP_NAME --train_eval

done
