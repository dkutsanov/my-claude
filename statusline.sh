#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

THEME="${CLAUDE_STATUSLINE_THEME:-rainbow}"
RESET='\033[0m'

if [ "$THEME" = "classic" ]; then
    # Classic: uniform dark background with colored foreground text
    BG_BASE='\033[48;5;238m'
    FG_DIR='\033[38;5;31m'
    FG_DIR_ANCHOR='\033[1;38;5;39m'
    FG_BRANCH='\033[38;5;76m'
    FG_MODEL='\033[38;5;134m'
    FG_COST='\033[38;5;178m'
    FG_TIME='\033[38;5;66m'
    FG_SEP='\033[38;5;246m'
    FG_ARROW='\033[38;5;238m'
else
    # Rainbow left, tmux grey gradient right
    # Left side: p10k rainbow colors
    CN_DIR=4; CN_BRANCH=2

    BG_DIR="\033[48;5;${CN_DIR}m"
    FG_DIR='\033[38;5;254m'
    FG_DIR_ANCHOR='\033[1;38;5;255m'

    BG_BRANCH="\033[48;5;${CN_BRANCH}m"
    FG_BRANCH='\033[38;5;0m'

    # Right side: tmux-matching grey gradient (light→dark, white text)
    CN_MODEL=244; CN_COST=239; CN_TIME=237

    BG_MODEL="\033[48;5;${CN_MODEL}m"
    FG_MODEL='\033[38;5;254m'

    BG_COST="\033[48;5;${CN_COST}m"
    FG_COST='\033[38;5;254m'

    BG_TIME="\033[48;5;${CN_TIME}m"
    FG_TIME='\033[38;5;254m'
fi

# Powerline glyphs
LEFT_SEP=''    # U+E0B1 thin right-pointing (between left segments)
LEFT_END=''    # U+E0BC slanted right separator (left prompt end)
RIGHT_START=''  # U+E0BA slanted left separator (right prompt start)
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
if [ "$PCT" -ge 90 ]; then PCT_LEVEL=critical
elif [ "$PCT" -ge 70 ]; then PCT_LEVEL=warning
else PCT_LEVEL=healthy; fi

if [ "$THEME" = "classic" ]; then
    case $PCT_LEVEL in
        critical) PCT_COLOR='\033[38;5;196m' ;;
        warning)  PCT_COLOR='\033[38;5;214m' ;;
        healthy)  PCT_COLOR='\033[38;5;76m' ;;
    esac
else
    case $PCT_LEVEL in
        critical) BG_PCT='\033[48;5;1m'; FG_PCT='\033[38;5;255m'; PCT_BG_NUM=1 ;;
        warning)  BG_PCT='\033[48;5;3m'; FG_PCT='\033[38;5;0m';   PCT_BG_NUM=3 ;;
        healthy)  BG_PCT='\033[48;5;241m'; FG_PCT='\033[38;5;254m'; PCT_BG_NUM=241 ;;
    esac
fi

if [ "$THEME" = "classic" ]; then
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
else
    # Rainbow: each segment has its own background, arrows transition between colors
    # Transition arrow: fg=prev_bg, bg=next_bg

    # Left side: [DIR_BG] dir [arrow DIR>BRANCH] branch [arrow BRANCH>reset]
    LEFT_PLAIN=" $DIR_PARENT$DIR_LAST "
    LEFT_FMT="${BG_DIR} ${FG_DIR}${DIR_PARENT}${FG_DIR_ANCHOR}${DIR_LAST}\033[22m "
    if [ -n "$BRANCH_NAME" ]; then
        LEFT_PLAIN="${LEFT_PLAIN}. $BRANCH_NAME "
        LEFT_FMT="${LEFT_FMT}${RESET}\033[38;5;${CN_DIR}m${BG_BRANCH}${LEFT_END}${FG_BRANCH} ${BRANCH_NAME} ${RESET}\033[38;5;${CN_BRANCH}m${LEFT_END}"
    else
        LEFT_FMT="${LEFT_FMT}${RESET}\033[38;5;${CN_DIR}m${LEFT_END}"
    fi
    LEFT_PLAIN="${LEFT_PLAIN}."

    # Right side: [◀MODEL] model [◀PCT] pct [◀COST] cost [◀TIME] time [│]
    RIGHT_PLAIN=". $MODEL . ${PCT}% . $COST_FMT . ${TIME_FMT} "
    RIGHT_FMT="\033[38;5;${CN_MODEL}m${RIGHT_START}${BG_MODEL}${FG_MODEL} ${MODEL} "
    RIGHT_FMT="${RIGHT_FMT}${RESET}\033[38;5;${PCT_BG_NUM}m${BG_MODEL}${RIGHT_START}${BG_PCT}${FG_PCT} ${PCT}% "
    RIGHT_FMT="${RIGHT_FMT}${RESET}\033[38;5;${CN_COST}m${BG_PCT}${RIGHT_START}${BG_COST}${FG_COST} ${COST_FMT} "
    RIGHT_FMT="${RIGHT_FMT}${RESET}\033[38;5;${CN_TIME}m${BG_COST}${RIGHT_START}${BG_TIME}${FG_TIME} ${TIME_FMT} ${RESET}"
fi

# Calculate gap — reserve right margin for Claude Code's auto-compact indicator
LEFT_LEN=${#LEFT_PLAIN}
RIGHT_LEN=${#RIGHT_PLAIN}
if [ "$PCT" -ge 80 ]; then
    MARGIN=41
else
    MARGIN=5
fi
GAP_LEN=$((COLS - LEFT_LEN - RIGHT_LEN - MARGIN))
if [ "$GAP_LEN" -lt 1 ]; then GAP_LEN=1; fi
GAP=$(printf "%${GAP_LEN}s" "")

echo -e "${LEFT_FMT}${RESET}${GAP}${RIGHT_FMT}"
