#!/usr/bin/env bats

SCRIPT="$BATS_TEST_DIRNAME/statusline.sh"

strip_ansi() {
    perl -pe 's/\e\[[0-9;]*m//g'
}

make_json() {
    local pct="${1:-50}"
    cat <<EOF
{
    "model": {"display_name": "Opus"},
    "workspace": {"current_dir": "/tmp/testdir"},
    "cost": {"total_cost_usd": 1.23, "total_duration_ms": 65000},
    "context_window": {"used_percentage": $pct}
}
EOF
}

visible_width() {
    strip_ansi | tr -d '\n' | wc -m | tr -d ' '
}

@test "defaults to rainbow theme with per-segment backgrounds" {
    output=$(make_json 50 | COLUMNS=200 bash "$SCRIPT" 2>/dev/null)
    # Rainbow theme uses blue background (48;5;4) for directory segment
    [[ "$output" == *$'\033[48;5;4m'* ]]
}

@test "classic theme uses uniform dark background" {
    output=$(make_json 50 | COLUMNS=200 CLAUDE_STATUSLINE_THEME=classic bash "$SCRIPT" 2>/dev/null)
    # Classic theme uses uniform gray background (48;5;238) for all segments
    [[ "$output" == *$'\033[48;5;238m'* ]]
    # Classic theme should NOT have blue background segments
    [[ "$output" != *$'\033[48;5;4m'* ]]
}

@test "leaves 40-char right margin when context usage >= 80%" {
    output=$(make_json 85 | COLUMNS=200 CLAUDE_STATUSLINE_THEME=classic bash "$SCRIPT" 2>/dev/null)
    width=$(echo "$output" | visible_width)
    expected=159  # 200 - 41 (40 margin + 1 to prevent terminal wrap)
    [ "$width" -eq "$expected" ]
}

@test "fills full width when context usage < 80%" {
    output=$(make_json 50 | COLUMNS=200 CLAUDE_STATUSLINE_THEME=classic bash "$SCRIPT" 2>/dev/null)
    width=$(echo "$output" | visible_width)
    expected=195  # 200 - 5 (4 margin + 1 to prevent terminal wrap)
    [ "$width" -eq "$expected" ]
}

@test "rainbow theme respects width constraints" {
    output=$(make_json 50 | COLUMNS=200 bash "$SCRIPT" 2>/dev/null)
    width=$(echo "$output" | visible_width)
    [ "$width" -eq 195 ]
}

@test "rainbow theme reserves right margin at high context usage" {
    output=$(make_json 85 | COLUMNS=200 bash "$SCRIPT" 2>/dev/null)
    width=$(echo "$output" | visible_width)
    [ "$width" -eq 159 ]
}

@test "rainbow context % uses green background when healthy" {
    output=$(make_json 50 | COLUMNS=200 bash "$SCRIPT" 2>/dev/null)
    # bg green (48;5;2) for context percentage segment
    [[ "$output" == *$'\033[48;5;2m'* ]]
}

@test "rainbow context % uses yellow background when warning" {
    output=$(make_json 75 | COLUMNS=200 bash "$SCRIPT" 2>/dev/null)
    # bg yellow (48;5;3) for context percentage segment at warning level
    # Must also have model magenta bg (48;5;5) to confirm rainbow mode
    [[ "$output" == *$'\033[48;5;5m'* ]]
    [[ "$output" == *$'\033[48;5;3m'* ]]
}

@test "rainbow context % uses red background when critical" {
    output=$(make_json 95 | COLUMNS=200 bash "$SCRIPT" 2>/dev/null)
    # bg red (48;5;1) for context percentage segment
    [[ "$output" == *$'\033[48;5;1m'* ]]
}

@test "rainbow right-side separators all point left" {
    output=$(make_json 50 | COLUMNS=80 bash "$SCRIPT" 2>/dev/null)
    stripped=$(echo "$output" | strip_ansi)
    # Extract right side (everything from first U+E0B2 onwards)
    right_side=$(echo "$stripped" | perl -ne 'print $1 if /(\xee\x82\xb2.*)/')
    # Count left-pointing arrows (U+E0B2) - should be 4 (start + 3 between segments)
    left_arrows=$(echo "$right_side" | perl -ne 'print scalar(() = /\xee\x82\xb2/g)')
    [ "$left_arrows" -eq 4 ]
    # No right-pointing arrows (U+E0B0) on the right side
    right_arrows=$(echo "$right_side" | perl -ne 'print scalar(() = /\xee\x82\xb0/g)')
    [ "$right_arrows" -eq 0 ]
}
