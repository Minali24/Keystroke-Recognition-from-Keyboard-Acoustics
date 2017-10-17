#!/bin/bash

train_cmd="utils/run.pl"
decode_cmd="utils/run.pl"

train_yesno=train_yesno
test_base_name=test_yesno

rm -rf data exp mfcc

# Data preparation

local/prepare_data.sh split_data
local/prepare_dict.sh
utils/prepare_lang.sh --position-dependent-phones false data/local/dict "<sil>" data/local/lang data/lang
local/prepare_lm.sh

# Feature extraction
for x in train_yesno test_yesno; do 
 steps/make_mfcc.sh --nj 1 data/$x exp/make_mfcc/$x mfcc
 steps/compute_cmvn_stats.sh data/$x exp/make_mfcc/$x mfcc
 utils/fix_data_dir.sh data/$x
done

# Mono training
steps/train_mono.sh --nj 1 --cmd "$train_cmd" \
  --totgauss 400 \
  data/train_yesno data/lang exp/mono0a 
  
# Graph compilation  
utils/mkgraph.sh data/lang_test_tg exp/mono0a exp/mono0a/graph_tgpr

# Decoding
steps/decode.sh --nj 1 --cmd "$decode_cmd" \
    exp/mono0a/graph_tgpr data/test_yesno exp/mono0a/decode_test_yesno

for x in exp/*/decode*; do [ -d $x ] && grep WER $x/wer_* | utils/best_wer.sh; done