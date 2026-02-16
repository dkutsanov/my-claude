# Statusline Rainbow Theme + Theme Switching

**Date:** 2026-02-16
**Status:** Approved

## Context

The p10k prompt was changed from the "classic" preset (uniform dark background, colored text) to the "rainbow" preset (per-segment colored backgrounds with contrasting text). The Claude Code statusline should match the new p10k style while preserving the ability to switch back to the original dark theme.

## Design

### Rainbow Color Mapping

Each segment gets its own background color, matching the p10k rainbow palette (basic ANSI 0-7):

| Segment | Background | Foreground | Source |
|---|---|---|---|
| Directory | `4` (blue) | `254` / `255` (bold anchor) | p10k DIR exact match |
| Git branch | `2` (green) | `0` (black) | p10k VCS_CLEAN exact match |
| Model | `5` (magenta) | `254` (light gray) | Custom - distinct purple accent |
| Context % | dynamic (see below) | dynamic | Status-aware coloring |
| Cost | `3` (yellow) | `0` (black) | Matches p10k "modified" warm tone |
| Time | `7` (white) | `0` (black) | p10k TIME exact match |

**Context % dynamic colors:**
- `<70%`: bg `2` (green), fg `0` (black) - healthy
- `70-90%`: bg `3` (yellow), fg `0` (black) - warning
- `90%+`: bg `1` (red), fg `255` (white) - critical

### Powerline Arrow Transitions

In rainbow mode, the powerline arrow glyphs transition between segment colors:
- Arrow foreground = previous segment's background color
- Arrow background = next segment's background color

This creates the signature rainbow "flow" effect matching p10k.

### Theme Switching

**Mechanism:** Environment variable `CLAUDE_STATUSLINE_THEME`

- Values: `classic` | `rainbow`
- Default: `rainbow` (new preference)
- Set in `.zshrc` for persistence: `export CLAUDE_STATUSLINE_THEME=rainbow`
- Override per-session: `export CLAUDE_STATUSLINE_THEME=classic`

### Script Structure

The refactored `statusline.sh` maintains a single file:

1. Parse JSON input (unchanged)
2. Read `CLAUDE_STATUSLINE_THEME` env var (default: `rainbow`)
3. Theme-specific color definitions:
   - `classic`: uniform bg `238` + colored foreground text (current behavior)
   - `rainbow`: per-segment bg/fg pairs from table above
4. Powerline glyphs (unchanged)
5. Terminal width detection (unchanged)
6. Theme-specific format string assembly:
   - `classic`: uniform background, thin separators between segments
   - `rainbow`: per-segment background blocks with transition arrows
7. Gap calculation and echo output (shared)

### Classic Theme Colors (preserved as-is)

| Variable | Color | Value |
|---|---|---|
| BG_BASE | Background | `238` |
| FG_DIR | Directory | `31` |
| FG_DIR_ANCHOR | Last folder (bold) | `39` |
| FG_BRANCH | Git branch | `76` |
| FG_MODEL | Model name | `134` |
| FG_COST | Cost | `178` |
| FG_TIME | Time | `66` |
| FG_SEP | Separator | `246` |
| FG_ARROW | Arrow | `238` |

## Implementation Notes

- No new files needed - single file modification to `statusline.sh`
- No config files - env var only
- Shared logic (JSON parsing, width calculation, gap) stays DRY
- Theme branching at two points: color definitions and format string assembly
