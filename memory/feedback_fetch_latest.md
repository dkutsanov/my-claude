---
name: Always fetch latest before investigating a repo
description: Before analyzing or reasoning about any repo under ~/Workspace, fetch the most recent version from remote
type: feedback
originSessionId: f1aa132d-f09f-4bf7-91f7-371885919808
---
Before looking at any repository under `~/Workspace`, fetch the most recent version from its remote (e.g. `git fetch` / pull the default branch as appropriate).

**Why:** The user uses these repos for research, debugging, and understanding across many projects, and stale local state leads to incorrect conclusions and wasted investigation time.

**How to apply:** When a task involves reading, analyzing, or explaining code in a specific repo under `~/Workspace`, run a fetch (or pull) on that repo first before drawing conclusions. Do this for any of the main repos (backend, ui, sysdigcloud-harness-cd, secure-backend, plotter, monitor-backend-shared-libs) or other repos inside Workspace that the task touches.
