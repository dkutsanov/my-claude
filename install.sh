#!/usr/bin/env bash
# Sync this repo's customizations into ~/.claude (and ~/.codex if installed).
# Idempotent: re-running fixes drift, picks up new entries, and removes stale
# symlinks for sources that no longer exist.
#
# Usage:
#   ./install.sh           # sync only
#   ./install.sh --pull    # git pull --ff-only first, then sync

set -euo pipefail

REPO_ROOT=$(cd "$(dirname "$0")" && pwd)

PULL=0
for arg in "$@"; do
    case "$arg" in
        --pull) PULL=1 ;;
        -h|--help) sed -n '2,11p' "$0"; exit 0 ;;
        *) echo "unknown arg: $arg" >&2; exit 2 ;;
    esac
done

# Whole-path link: ensure $tgt is a symlink to $src, or remove a broken link if
# $src is gone. Refuses to clobber a real file/dir at $tgt.
link_one() {
    local src="$1" tgt="$2"

    if [[ ! -e "$src" ]]; then
        if [[ -L "$tgt" ]] && [[ "$(readlink "$tgt")" == "$src" ]]; then
            rm "$tgt"
            echo "[clean] $tgt (source removed)"
        fi
        return
    fi

    if [[ -L "$tgt" ]] && [[ "$(readlink "$tgt")" == "$src" ]]; then
        echo "[skip ] $tgt -> $src"
        return
    fi

    if [[ -e "$tgt" && ! -L "$tgt" ]]; then
        echo "[error] $tgt exists as a real file/dir — refusing to overwrite" >&2
        return
    fi

    rm -f "$tgt"
    ln -s "$src" "$tgt"
    echo "[link ] $tgt -> $src"
}

# Per-entry sync: for each child of $src_dir, link it under $tgt_dir; then
# remove any symlink in $tgt_dir that points back into $src_dir but is broken.
# Non-symlink files in $tgt_dir (other tools' content) are untouched.
sync_per_entry() {
    local src_dir="$1" tgt_dir="$2"

    if [[ ! -d "$src_dir" ]]; then
        return
    fi

    mkdir -p "$tgt_dir"

    local entry name
    for entry in "$src_dir"/* "$src_dir"/.[!.]*; do
        [[ -e "$entry" ]] || continue
        name=$(basename "$entry")
        link_one "$entry" "$tgt_dir/$name"
    done

    local link target
    for link in "$tgt_dir"/* "$tgt_dir"/.[!.]*; do
        [[ -L "$link" ]] || continue
        target=$(readlink "$link")
        case "$target" in
            "$src_dir"/*)
                if [[ ! -e "$target" ]]; then
                    rm "$link"
                    echo "[clean] $link (source removed)"
                fi
                ;;
        esac
    done
}

install_claude() {
    mkdir -p "$HOME/.claude"
    link_one "$REPO_ROOT/agents"        "$HOME/.claude/agents"
    link_one "$REPO_ROOT/commands"      "$HOME/.claude/commands"
    link_one "$REPO_ROOT/skills"        "$HOME/.claude/skills"
    link_one "$REPO_ROOT/memory"        "$HOME/.claude/memory"
    link_one "$REPO_ROOT/settings.json" "$HOME/.claude/settings.json"
    link_one "$REPO_ROOT/statusline.sh" "$HOME/.claude/statusline.sh"
    link_one "$REPO_ROOT/my-CLAUDE.md"  "$HOME/.claude/CLAUDE.md"
    sync_per_entry "$REPO_ROOT/hooks"   "$HOME/.claude/hooks"
}

install_codex() {
    mkdir -p "$HOME/.codex"
    link_one "$REPO_ROOT/agents"   "$HOME/.codex/agents"
    link_one "$REPO_ROOT/commands" "$HOME/.codex/commands"
    link_one "$REPO_ROOT/skills"   "$HOME/.codex/skills"
}

main() {
    if [[ $PULL -eq 1 ]]; then
        echo "[pull ] git pull --ff-only"
        git -C "$REPO_ROOT" pull --ff-only
    fi

    install_claude

    if command -v codex >/dev/null 2>&1; then
        install_codex
    else
        echo "[skip ] codex CLI not installed — ~/.codex/ untouched"
    fi

    echo "[done ] sync complete"
}

main
