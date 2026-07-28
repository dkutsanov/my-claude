#!/bin/bash
# Auto-approve compound Bash commands — &&/||/;/| chains, newlines, env-var
# prefixes (VAR=x cmd), and for/while/until loops — when every constituent
# command is on the safe list below. Anything unrecognized falls through
# silently to the normal permission flow, so false negatives only cost a prompt.

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
[ -z "$COMMAND" ] && exit 0

# Engage only on forms the built-in prefix matcher can't approve.
if ! echo "$COMMAND" | grep -qE '&&|\|\||;|\||^[A-Za-z_][A-Za-z0-9_]*=' && [[ "$COMMAND" != *$'\n'* ]]; then
    exit 0
fi

# Constructs that can smuggle arbitrary execution past the per-part check.
case "$COMMAND" in
    *\`*|*'<('*|*'>('*|*'<<'*) exit 0 ;;
esac

# File-writing redirects: only the noise-suppression forms are acceptable.
REDIRECT_CHECK=$(echo "$COMMAND" | sed -E 's/2>&1//g; s/[012&]?>{1,2}[[:space:]]*\/dev\/null//g')
case "$REDIRECT_CHECK" in
    *'>'*) exit 0 ;;
esac

# Pull out $(...) substitutions; each inner command gets validated like any
# other part. Nested substitutions are unparsable here — never approved.
WORK=${COMMAND//$'\n'/;}
SUBSTS=""
while [[ "$WORK" == *'$('* ]]; do
    TOKEN=$(echo "$WORK" | grep -oE '\$\([^()]*\)' | head -1)
    [ -z "$TOKEN" ] && exit 0
    SUBSTS="$SUBSTS;${TOKEN:2:${#TOKEN}-3}"
    WORK="${WORK/"$TOKEN"/__SUBST__}"
done

is_safe_part() {
    local part="$1"
    # control-flow keywords prefix a command; validate what they wrap
    while true; do
        case "$part" in
            do\ *|then\ *|else\ *|if\ *|elif\ *|while\ *|until\ *|!\ *) part="${part#* }" ;;
            *) break ;;
        esac
    done
    part="${part#"${part%%[![:space:]]*}"}"
    part="${part%"${part##*[![:space:]]}"}"
    [ -z "$part" ] && return 0
    case "$part" in
        do|done|then|else|fi|:) return 0 ;;
        for\ *) return 0 ;;  # loop header iterates over data words only
    esac
    # leading VAR=value assignments (substitution content already screened)
    while echo "$part" | grep -qE '^[A-Za-z_][A-Za-z0-9_]*='; do
        case "$part" in
            *[[:space:]]*) part="${part#*[[:space:]]}" ;;
            *) return 0 ;;  # pure assignment
        esac
        part="${part#"${part%%[![:space:]]*}"}"
        [ -z "$part" ] && return 0
    done
    local base="${part%% *}"
    case "$base" in
        cd|pwd|ls|echo|printf|cat|head|tail|grep|egrep|fgrep|test|true|false|wc|sort|uniq|tr|cut|jq|basename|dirname|readlink|which|date|sleep|read|exit|break|continue|shift|wait|git|./gradlew|\[|\[\[)
            return 0 ;;
        sed)  case "$part" in *-i*) return 1 ;; *) return 0 ;; esac ;;
        find) case "$part" in *-delete*|*-exec*|*-ok*) return 1 ;; *) return 0 ;; esac ;;
        gh)   case "$part" in gh\ pr\ *|gh\ api\ *|gh\ repo\ *|gh\ run\ *|gh\ issue\ *|gh\ search\ *) return 0 ;; *) return 1 ;; esac ;;
        *) return 1 ;;
    esac
}

ALL_SAFE=true
while IFS= read -r part; do
    part=$(echo "$part" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//;s/[[:space:]]*&$//')
    [ -z "$part" ] && continue
    is_safe_part "$part" || { ALL_SAFE=false; break; }
done < <(printf '%s\n' "$WORK$SUBSTS" | sed -E 's/&&/\n/g; s/\|\|/\n/g; s/;/\n/g; s/\|/\n/g')

if [ "$ALL_SAFE" = "true" ]; then
    jq -n '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"allow","permissionDecisionReason":"All parts of compound command are on the safe list"}}'
fi
exit 0
