#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

# Colors mapped from .p10k.zsh (classic powerline style)
BG_BASE='\033[48;5;238m'       # Background (POWERLEVEL9K_BACKGROUND=238)
FG_DIR='\033[38;5;31m'         # Directory (POWERLEVEL9K_DIR_FOREGROUND=31)
FG_DIR_ANCHOR='\033[1;38;5;39m' # Last folder bold (POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=39)
FG_BRANCH='\033[38;5;76m'     # Git branch (POWERLEVEL9K_VCS_CLEAN_FOREGROUND=76)
FG_MODEL='\033[38;5;134m'     # Model name (purple accent)
FG_COST='\033[38;5;178m'      # Cost (gold, matches p10k modified accent)
FG_TIME='\033[38;5;66m'       # Time (POWERLEVEL9K_TIME_FOREGROUND=66)
FG_SEP='\033[38;5;246m'       # Subsegment separator color
FG_ARROW='\033[38;5;238m'     # Arrow color (fg matches segment bg for transition)
RESET='\033[0m'

# Powerline glyphs
LEFT_SEP=''    # U+E0B1 thin right-pointing (between left segments)
LEFT_END=''    # U+E0B0 right-pointing arrow (left prompt end)
RIGHT_START=''  # U+E0B2 left-pointing arrow (right prompt start)
RIGHT_SEP=''    # U+E0B3 thin left-pointing (between right segments)

# Terminal width - try multiple methods since stdin is piped
if [ -n "$COLUMNS" ]; then
    COLS=$COLUMNS
elif [ -e /dev/tty ]; then
    COLS=$(stty size </dev/tty 2>/dev/null | cut -d' ' -f2)
fi
COLS=${COLS:-$(tput cols 2>/dev/null)}
COLS=${COLS:-120}

# Formatting - split path so last folder is bold (p10k anchor style)
T_DIR="${DIR/#$HOME/~}"
DIR_PARENT="${T_DIR%/*}/"
DIR_LAST="${T_DIR##*/}"
if [ "$T_DIR" = "~" ]; then DIR_PARENT=""; DIR_LAST="~"; fi
MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))
if [ "$MINS" -ge 60 ]; then
    HOURS=$((MINS / 60)); RMINS=$((MINS % 60))
    if [ "$RMINS" -gt 0 ]; then TIME_FMT="${HOURS}h ${RMINS}m"
    else TIME_FMT="${HOURS}h"; fi
else
    TIME_FMT="${MINS}m ${SECS}s"
fi
COST_FMT=$(printf '$%.2f' "$COST")

# Branch logic
BRANCH_NAME=$(git branch --show-current 2>/dev/null)

# Context usage color logic
if [ "$PCT" -ge 90 ]; then PCT_COLOR='\033[38;5;196m'    # Red
elif [ "$PCT" -ge 70 ]; then PCT_COLOR='\033[38;5;214m'  # Orange
else PCT_COLOR='\033[38;5;76m'; fi                        # Green (matches branch/OK color)

# Build left side: [BG] DIR > BRANCH [RESET][arrow>]
LEFT_PLAIN=" $DIR_PARENT$DIR_LAST "
LEFT_FMT="${BG_BASE} ${FG_DIR}${DIR_PARENT}${FG_DIR_ANCHOR}${DIR_LAST}\033[22m"
if [ -n "$BRANCH_NAME" ]; then
    LEFT_PLAIN="${LEFT_PLAIN}. $BRANCH_NAME "
    LEFT_FMT="${LEFT_FMT} ${FG_SEP}${LEFT_SEP} ${FG_BRANCH}${BRANCH_NAME}"
fi
LEFT_PLAIN="${LEFT_PLAIN}."
LEFT_FMT="${LEFT_FMT} ${RESET}${FG_ARROW}${LEFT_END}"

# Build right side: [<arrow][BG] MODEL > PCT% > COST > TIME [RESET]
RIGHT_PLAIN=". $MODEL . ${PCT}% . $COST_FMT . ${TIME_FMT} "
RIGHT_FMT="${FG_ARROW}${RIGHT_START}${BG_BASE} ${FG_MODEL}${MODEL} ${FG_SEP}${RIGHT_SEP} ${PCT_COLOR}${PCT}% ${FG_SEP}${RIGHT_SEP} ${FG_COST}${COST_FMT} ${FG_SEP}${RIGHT_SEP} ${FG_TIME}${TIME_FMT} ${RESET}"

# Calculate gap (no background in the middle)
LEFT_LEN=${#LEFT_PLAIN}
RIGHT_LEN=${#RIGHT_PLAIN}
GAP_LEN=$((COLS - LEFT_LEN - RIGHT_LEN - 4))
if [ "$GAP_LEN" -lt 1 ]; then GAP_LEN=1; fi
GAP=$(printf "%${GAP_LEN}s" "")

echo -e "${LEFT_FMT}${RESET}${GAP}${RIGHT_FMT}"
