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
FG_BRANCH='\033[38;5;76m'     # Git branch (POWERLEVEL9K_VCS_CLEAN_FOREGROUND=76)
FG_MODEL='\033[38;5;134m'     # Model name (purple accent)
FG_COST='\033[38;5;178m'      # Cost (gold, matches p10k modified accent)
FG_TIME='\033[38;5;66m'       # Time (POWERLEVEL9K_TIME_FOREGROUND=66)
FG_SEP='\033[38;5;246m'       # Subsegment separator (POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR color)
FG_END='\033[38;5;238m'       # End arrow (fg matches bar bg for pointy effect)
RESET='\033[0m'

# Powerline glyphs (literal UTF-8 characters)
SEP_CHAR=''  # U+E0B1 thin separator
END_CHAR=''  # U+E0B0 pointy end arrow

# Formatting
T_DIR="${DIR/#$HOME/~}"
SEP=" ${FG_SEP}${SEP_CHAR} "
MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))
COST_FMT=$(printf '$%.2f' "$COST")

# Branch logic
BRANCH_NAME=$(git branch --show-current 2>/dev/null)
BRANCH_STR=""
if [ -n "$BRANCH_NAME" ]; then
    BRANCH_STR="${SEP}${FG_BRANCH}${BRANCH_NAME}"
fi

# Context usage color logic
if [ "$PCT" -ge 90 ]; then PCT_COLOR='\033[38;5;196m'    # Red
elif [ "$PCT" -ge 70 ]; then PCT_COLOR='\033[38;5;214m'  # Orange
else PCT_COLOR='\033[38;5;76m'; fi                        # Green (matches branch/OK color)

# Constructing the bar
# Sequence: [DIR] > [BRANCH] > [MODEL] > [PCT%] > [COST] > [TIME] ▶
echo -e "${BG_BASE} ${FG_DIR}${T_DIR}${BRANCH_STR}${SEP}${FG_MODEL}${MODEL}${SEP}${PCT_COLOR}${PCT}%${SEP}${FG_COST}${COST_FMT}${SEP}${FG_TIME}${MINS}m ${SECS}s ${RESET}${FG_END}${END_CHAR}${RESET}"
