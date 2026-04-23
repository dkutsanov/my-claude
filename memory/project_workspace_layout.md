---
name: Workspace directory layout
description: ~/Workspace is the base folder containing all repositories the user works on; lists main repos and their purpose
type: project
originSessionId: f1aa132d-f09f-4bf7-91f7-371885919808
---
`~/Workspace` is the base folder for every project the user works on or contributes to. Main repositories inside it:

- `backend` — monitor backend repository
- `ui` — secure and monitor frontend repository
- `sysdigcloud-harness-cd` — configurations repository for all environments
- `secure-backend` — secure backend repository
- `plotter` — plotter repository
- `monitor-backend-shared-libs` — shared libraries repository

Other folders may also be present inside `~/Workspace` and can be inspected when additional context is needed.

**Why:** The user anchors all research, debugging, and understanding sessions at this directory, so knowing the layout avoids asking where things live.

**How to apply:** When the user refers to a repo by short name (e.g. "backend", "ui"), resolve it against this list. When looking for related code, configs, or shared utilities across the stack, feel free to look in sibling folders under `~/Workspace`.
