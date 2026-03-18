#!/bin/bash
# Write Claude Code session data to a file for tmux to read, output nothing to Claude Code
input=$(cat)

TMUX_PANE_ID="${TMUX_PANE:-default}"
STATUS_FILE="/tmp/claude-status-${TMUX_PANE_ID//[^a-zA-Z0-9_-]/_}"

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
FOLDER="${DIR##*/}"
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))
if [ "$MINS" -ge 60 ]; then
    HOURS=$((MINS / 60)); RMINS=$((MINS % 60))
    if [ "$RMINS" -gt 0 ]; then TIME_FMT="${HOURS}h ${RMINS}m"
    else TIME_FMT="${HOURS}h"; fi
else
    TIME_FMT="${MINS}m ${SECS}s"
fi
COST_FMT=$(printf '$%.2f' "$COST")

cat > "$STATUS_FILE" <<EOF
MODEL=$MODEL
COST=$COST_FMT
PCT=$PCT
TIME=$TIME_FMT
FOLDER=$FOLDER
UPDATED=$(date +%s)
EOF

# Output nothing — tmux handles display
echo ""
