---
name: No Co-Authored-By in commits
description: Never add Co-Authored-By trailer lines to git commits
type: feedback
---

Do NOT add `Co-Authored-By` lines to git commit messages.
**Why:** User does not want AI attribution in commits. The commit skill was created specifically to avoid this, but the rule must also apply when committing directly outside the skill.
**How to apply:** When creating any git commit (whether via `/commit` skill or raw git commands), never include `Co-Authored-By` trailers.
