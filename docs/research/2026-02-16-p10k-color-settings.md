# Research Findings: Powerlevel10k Color Settings

## Research Scope
Extracted all color-related settings from `/Users/dmytro.kutsanov/.p10k.zsh` to understand the current color scheme and configuration.

## Configuration Overview

### Base Configuration
- **Source**: `~/.p10k.zsh:2` - Based on `romkatv/powerlevel10k/config/p10k-rainbow.zsh` (checksum 57633)
- **Style**: Rainbow theme with powerline separators
- **Mode**: `nerdfont-v3` (`~/.p10k.zsh:122`)
- **Features**: Small icons, unicode, 24h time, angled separators, sharp heads, flat tails, 2 lines, dotted, no frame, lightest-ornaments, sparse, few icons, concise
- **Instant Prompt**: verbose (`~/.p10k.zsh:1823`)
- **Transient Prompt**: off (`~/.p10k.zsh:1811`)

## Core Color Settings

### General Segment Colors

#### OS Icon
- `POWERLEVEL9K_OS_ICON_FOREGROUND=232` (dark gray) - `~/.p10k.zsh:194`
- `POWERLEVEL9K_OS_ICON_BACKGROUND=7` (white) - `~/.p10k.zsh:195`

#### Prompt Character
- `POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=` (transparent) - `~/.p10k.zsh:201`
- `POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76` (bright green) - `~/.p10k.zsh:203`
- `POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196` (bright red) - `~/.p10k.zsh:205`

### Directory Colors

#### Main Directory Settings
- `POWERLEVEL9K_DIR_BACKGROUND=4` (blue) - `~/.p10k.zsh:224`
- `POWERLEVEL9K_DIR_FOREGROUND=254` (light gray) - `~/.p10k.zsh:226`
- `POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=250` (gray) - `~/.p10k.zsh:233`
- `POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=255` (white) - `~/.p10k.zsh:236`
- `POWERLEVEL9K_DIR_ANCHOR_BOLD=true` - `~/.p10k.zsh:238`

### VCS (Git) Colors

#### VCS Background Colors
- `POWERLEVEL9K_VCS_CLEAN_BACKGROUND=2` (green) - `~/.p10k.zsh:364`
- `POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=3` (yellow) - `~/.p10k.zsh:365`
- `POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=2` (green) - `~/.p10k.zsh:366`
- `POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=3` (yellow) - `~/.p10k.zsh:367`
- `POWERLEVEL9K_VCS_LOADING_BACKGROUND=8` (gray) - `~/.p10k.zsh:368`

#### VCS Foreground Colors (Custom Formatter)
VCS uses custom color codes defined in the `my_git_formatter()` function at `~/.p10k.zsh:396-400`:
- `meta='%7F'` - white foreground (for metadata like @, #, :) - `~/.p10k.zsh:396`
- `clean='%0F'` - black foreground (for clean/main content) - `~/.p10k.zsh:397`
- `modified='%0F'` - black foreground (for modified indicators) - `~/.p10k.zsh:398`
- `untracked='%0F'` - black foreground (for untracked indicators) - `~/.p10k.zsh:399`
- `conflicted='%1F'` - red foreground (for conflicts) - `~/.p10k.zsh:400`

#### VCS Configuration
- `POWERLEVEL9K_VCS_BRANCH_ICON=` (empty) - `~/.p10k.zsh:371`
- `POWERLEVEL9K_VCS_UNTRACKED_ICON='?'` - `~/.p10k.zsh:375`
- `POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true` - `~/.p10k.zsh:497`
- `POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_EXPANSION=` (empty) - `~/.p10k.zsh:504`

### Time Colors
- `POWERLEVEL9K_TIME_FOREGROUND=0` (black) - `~/.p10k.zsh:1757`
- `POWERLEVEL9K_TIME_BACKGROUND=7` (white) - `~/.p10k.zsh:1758`
- `POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'` - `~/.p10k.zsh:1760`
- `POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION=` (empty) - `~/.p10k.zsh:1766`

### Status Colors

#### Status OK
- `POWERLEVEL9K_STATUS_OK_FOREGROUND=2` (green) - `~/.p10k.zsh:522`
- `POWERLEVEL9K_STATUS_OK_BACKGROUND=0` (black) - `~/.p10k.zsh:523`
- `POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=2` (green) - `~/.p10k.zsh:529`
- `POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND=0` (black) - `~/.p10k.zsh:530`

#### Status Error
- `POWERLEVEL9K_STATUS_ERROR_FOREGROUND=3` (yellow) - `~/.p10k.zsh:536`
- `POWERLEVEL9K_STATUS_ERROR_BACKGROUND=1` (red) - `~/.p10k.zsh:537`
- `POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=3` (yellow) - `~/.p10k.zsh:544`
- `POWERLEVEL9K_STATUS_ERROR_SIGNAL_BACKGROUND=1` (red) - `~/.p10k.zsh:545`
- `POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=3` (yellow) - `~/.p10k.zsh:551`
- `POWERLEVEL9K_STATUS_ERROR_PIPE_BACKGROUND=1` (red) - `~/.p10k.zsh:552`

### Command Execution Time
- `POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=0` (black) - `~/.p10k.zsh:556`
- `POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=3` (yellow) - `~/.p10k.zsh:557`

### Background Jobs
- `POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=6` (cyan) - `~/.p10k.zsh:571`
- `POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=0` (black) - `~/.p10k.zsh:572`
- `POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false` - `~/.p10k.zsh:574`

## Additional Segment Colors

### VI Mode
- `POWERLEVEL9K_VI_MODE_FOREGROUND=0` (black) - `~/.p10k.zsh:841`
- `POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND=2` (green) - `~/.p10k.zsh:844`
- `POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND=4` (blue) - `~/.p10k.zsh:847`
- `POWERLEVEL9K_VI_MODE_OVERWRITE_BACKGROUND=3` (yellow) - `~/.p10k.zsh:850`
- `POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND=8` (gray) - `~/.p10k.zsh:853`

### System Monitors

#### RAM
- `POWERLEVEL9K_RAM_FOREGROUND=0` (black) - `~/.p10k.zsh:859`
- `POWERLEVEL9K_RAM_BACKGROUND=3` (yellow) - `~/.p10k.zsh:860`

#### SWAP
- `POWERLEVEL9K_SWAP_FOREGROUND=0` (black) - `~/.p10k.zsh:866`
- `POWERLEVEL9K_SWAP_BACKGROUND=3` (yellow) - `~/.p10k.zsh:867`

#### Load
- `POWERLEVEL9K_LOAD_NORMAL_FOREGROUND=0` (black) - `~/.p10k.zsh:875`
- `POWERLEVEL9K_LOAD_NORMAL_BACKGROUND=2` (green) - `~/.p10k.zsh:876`
- `POWERLEVEL9K_LOAD_WARNING_FOREGROUND=0` (black) - `~/.p10k.zsh:878`
- `POWERLEVEL9K_LOAD_WARNING_BACKGROUND=3` (yellow) - `~/.p10k.zsh:879`
- `POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND=0` (black) - `~/.p10k.zsh:881`
- `POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND=1` (red) - `~/.p10k.zsh:882`

#### Disk Usage
- `POWERLEVEL9K_DISK_USAGE_NORMAL_FOREGROUND=3` (yellow) - `~/.p10k.zsh:825`
- `POWERLEVEL9K_DISK_USAGE_NORMAL_BACKGROUND=0` (black) - `~/.p10k.zsh:826`
- `POWERLEVEL9K_DISK_USAGE_WARNING_FOREGROUND=0` (black) - `~/.p10k.zsh:827`
- `POWERLEVEL9K_DISK_USAGE_WARNING_BACKGROUND=3` (yellow) - `~/.p10k.zsh:828`
- `POWERLEVEL9K_DISK_USAGE_CRITICAL_FOREGROUND=7` (white) - `~/.p10k.zsh:829`
- `POWERLEVEL9K_DISK_USAGE_CRITICAL_BACKGROUND=1` (red) - `~/.p10k.zsh:830`

### Battery
- `POWERLEVEL9K_BATTERY_LOW_FOREGROUND=1` (red) - `~/.p10k.zsh:1717`
- `POWERLEVEL9K_BATTERY_{CHARGING,CHARGED}_FOREGROUND=2` (green) - `~/.p10k.zsh:1719`
- `POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=3` (yellow) - `~/.p10k.zsh:1721`
- `POWERLEVEL9K_BATTERY_BACKGROUND=0` (black) - `~/.p10k.zsh:1726`

### Context (User/Host)
- `POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=1` (red) - `~/.p10k.zsh:975`
- `POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=0` (black) - `~/.p10k.zsh:976`
- `POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=3` (yellow) - `~/.p10k.zsh:978`
- `POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_BACKGROUND=0` (black) - `~/.p10k.zsh:979`
- `POWERLEVEL9K_CONTEXT_FOREGROUND=3` (yellow) - `~/.p10k.zsh:981`
- `POWERLEVEL9K_CONTEXT_BACKGROUND=0` (black) - `~/.p10k.zsh:982`

### Development Environments

#### Python (Virtualenv)
- `POWERLEVEL9K_VIRTUALENV_FOREGROUND=0` (black) - `~/.p10k.zsh:1002`
- `POWERLEVEL9K_VIRTUALENV_BACKGROUND=4` (blue) - `~/.p10k.zsh:1003`

#### Python (Anaconda)
- `POWERLEVEL9K_ANACONDA_FOREGROUND=0` (black) - `~/.p10k.zsh:1016`
- `POWERLEVEL9K_ANACONDA_BACKGROUND=4` (blue) - `~/.p10k.zsh:1017`

#### Python (Pyenv)
- `POWERLEVEL9K_PYENV_FOREGROUND=0` (black) - `~/.p10k.zsh:1050`
- `POWERLEVEL9K_PYENV_BACKGROUND=4` (blue) - `~/.p10k.zsh:1051`

#### Go (Goenv)
- `POWERLEVEL9K_GOENV_FOREGROUND=0` (black) - `~/.p10k.zsh:1077`
- `POWERLEVEL9K_GOENV_BACKGROUND=4` (blue) - `~/.p10k.zsh:1078`

#### Go Version
- `POWERLEVEL9K_GO_VERSION_FOREGROUND=255` (white) - `~/.p10k.zsh:1137`
- `POWERLEVEL9K_GO_VERSION_BACKGROUND=2` (green) - `~/.p10k.zsh:1138`

#### Node (Nodenv)
- `POWERLEVEL9K_NODENV_FOREGROUND=2` (green) - `~/.p10k.zsh:1091`
- `POWERLEVEL9K_NODENV_BACKGROUND=0` (black) - `~/.p10k.zsh:1092`

#### Node (NVM)
- `POWERLEVEL9K_NVM_FOREGROUND=0` (black) - `~/.p10k.zsh:1105`
- `POWERLEVEL9K_NVM_BACKGROUND=5` (magenta) - `~/.p10k.zsh:1106`

#### Node (Nodeenv)
- `POWERLEVEL9K_NODEENV_FOREGROUND=2` (green) - `~/.p10k.zsh:1117`
- `POWERLEVEL9K_NODEENV_BACKGROUND=0` (black) - `~/.p10k.zsh:1118`

#### Node Version
- `POWERLEVEL9K_NODE_VERSION_FOREGROUND=7` (white) - `~/.p10k.zsh:1128`
- `POWERLEVEL9K_NODE_VERSION_BACKGROUND=2` (green) - `~/.p10k.zsh:1129`

#### Ruby (Rbenv)
- `POWERLEVEL9K_RBENV_FOREGROUND=0` (black) - `~/.p10k.zsh:1180`
- `POWERLEVEL9K_RBENV_BACKGROUND=1` (red) - `~/.p10k.zsh:1181`

#### Ruby (RVM)
- `POWERLEVEL9K_RVM_FOREGROUND=0` (black) - `~/.p10k.zsh:1220`
- `POWERLEVEL9K_RVM_BACKGROUND=240` (dark gray) - `~/.p10k.zsh:1221`

#### Rust Version
- `POWERLEVEL9K_RUST_VERSION_FOREGROUND=0` (black) - `~/.p10k.zsh:1146`
- `POWERLEVEL9K_RUST_VERSION_BACKGROUND=208` (orange) - `~/.p10k.zsh:1147`

#### Java Version
- `POWERLEVEL9K_JAVA_VERSION_FOREGROUND=1` (red) - `~/.p10k.zsh:1194`
- `POWERLEVEL9K_JAVA_VERSION_BACKGROUND=7` (white) - `~/.p10k.zsh:1195`

#### .NET Core
- `POWERLEVEL9K_DOTNET_VERSION_FOREGROUND=7` (white) - `~/.p10k.zsh:1155`
- `POWERLEVEL9K_DOTNET_VERSION_BACKGROUND=5` (magenta) - `~/.p10k.zsh:1156`

#### PHP
- `POWERLEVEL9K_PHP_VERSION_FOREGROUND=0` (black) - `~/.p10k.zsh:1164`
- `POWERLEVEL9K_PHP_VERSION_BACKGROUND=5` (magenta) - `~/.p10k.zsh:1165`

#### Laravel
- `POWERLEVEL9K_LARAVEL_VERSION_FOREGROUND=1` (red) - `~/.p10k.zsh:1173`
- `POWERLEVEL9K_LARAVEL_VERSION_BACKGROUND=7` (white) - `~/.p10k.zsh:1174`

### ASDF Tool Versions

#### ASDF Generic
- `POWERLEVEL9K_ASDF_FOREGROUND=0` (black) - `~/.p10k.zsh:589`
- `POWERLEVEL9K_ASDF_BACKGROUND=7` (white) - `~/.p10k.zsh:590`

#### ASDF Ruby
- `POWERLEVEL9K_ASDF_RUBY_FOREGROUND=0` (black) - `~/.p10k.zsh:648`
- `POWERLEVEL9K_ASDF_RUBY_BACKGROUND=1` (red) - `~/.p10k.zsh:649`

#### ASDF Python
- `POWERLEVEL9K_ASDF_PYTHON_FOREGROUND=0` (black) - `~/.p10k.zsh:654`
- `POWERLEVEL9K_ASDF_PYTHON_BACKGROUND=4` (blue) - `~/.p10k.zsh:655`

#### ASDF Go
- `POWERLEVEL9K_ASDF_GOLANG_FOREGROUND=0` (black) - `~/.p10k.zsh:660`
- `POWERLEVEL9K_ASDF_GOLANG_BACKGROUND=4` (blue) - `~/.p10k.zsh:661`

#### ASDF Node
- `POWERLEVEL9K_ASDF_NODEJS_FOREGROUND=0` (black) - `~/.p10k.zsh:666`
- `POWERLEVEL9K_ASDF_NODEJS_BACKGROUND=2` (green) - `~/.p10k.zsh:667`

#### ASDF Rust
- `POWERLEVEL9K_ASDF_RUST_FOREGROUND=0` (black) - `~/.p10k.zsh:672`
- `POWERLEVEL9K_ASDF_RUST_BACKGROUND=208` (orange) - `~/.p10k.zsh:673`

#### ASDF Java
- `POWERLEVEL9K_ASDF_JAVA_FOREGROUND=1` (red) - `~/.p10k.zsh:696`
- `POWERLEVEL9K_ASDF_JAVA_BACKGROUND=7` (white) - `~/.p10k.zsh:697`

#### ASDF Other Languages
- Dotnet Core: FG=0, BG=5 (`~/.p10k.zsh:678-679`)
- Flutter: FG=0, BG=4 (`~/.p10k.zsh:684-685`)
- Lua: FG=0, BG=4 (`~/.p10k.zsh:690-691`)
- Perl: FG=0, BG=4 (`~/.p10k.zsh:702-703`)
- Erlang: FG=0, BG=1 (`~/.p10k.zsh:708-709`)
- Elixir: FG=0, BG=5 (`~/.p10k.zsh:714-715`)
- Postgres: FG=0, BG=6 (`~/.p10k.zsh:720-721`)
- PHP: FG=0, BG=5 (`~/.p10k.zsh:726-727`)
- Haskell: FG=0, BG=3 (`~/.p10k.zsh:732-733`)
- Julia: FG=0, BG=2 (`~/.p10k.zsh:738-739`)

### Cloud & Infrastructure

#### Terraform
- `POWERLEVEL9K_TERRAFORM_OTHER_FOREGROUND=4` (blue) - `~/.p10k.zsh:1363`
- `POWERLEVEL9K_TERRAFORM_OTHER_BACKGROUND=0` (black) - `~/.p10k.zsh:1364`
- `POWERLEVEL9K_TERRAFORM_VERSION_FOREGROUND=4` (blue) - `~/.p10k.zsh:1369`
- `POWERLEVEL9K_TERRAFORM_VERSION_BACKGROUND=0` (black) - `~/.p10k.zsh:1370`

#### Kubernetes
- `POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=7` (white) - `~/.p10k.zsh:1410`
- `POWERLEVEL9K_KUBECONTEXT_DEFAULT_BACKGROUND=5` (magenta) - `~/.p10k.zsh:1411`

#### AWS
- `POWERLEVEL9K_AWS_DEFAULT_FOREGROUND=7` (white) - `~/.p10k.zsh:1495`
- `POWERLEVEL9K_AWS_DEFAULT_BACKGROUND=1` (red) - `~/.p10k.zsh:1496`
- `POWERLEVEL9K_AWS_EB_ENV_FOREGROUND=2` (green) - `~/.p10k.zsh:1507`
- `POWERLEVEL9K_AWS_EB_ENV_BACKGROUND=0` (black) - `~/.p10k.zsh:1508`

#### Azure
- `POWERLEVEL9K_AZURE_OTHER_FOREGROUND=7` (white) - `~/.p10k.zsh:1547`
- `POWERLEVEL9K_AZURE_OTHER_BACKGROUND=4` (blue) - `~/.p10k.zsh:1548`

#### Google Cloud
- `POWERLEVEL9K_GCLOUD_FOREGROUND=7` (white) - `~/.p10k.zsh:1557`
- `POWERLEVEL9K_GCLOUD_BACKGROUND=4` (blue) - `~/.p10k.zsh:1558`
- `POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_FOREGROUND=7` (white) - `~/.p10k.zsh:1629`
- `POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_BACKGROUND=4` (blue) - `~/.p10k.zsh:1630`

### Network & Tools

#### Public IP
- `POWERLEVEL9K_PUBLIC_IP_FOREGROUND=7` (white) - `~/.p10k.zsh:1662`
- `POWERLEVEL9K_PUBLIC_IP_BACKGROUND=0` (black) - `~/.p10k.zsh:1663`

#### VPN IP
- `POWERLEVEL9K_VPN_IP_FOREGROUND=0` (black) - `~/.p10k.zsh:1669`
- `POWERLEVEL9K_VPN_IP_BACKGROUND=6` (cyan) - `~/.p10k.zsh:1670`

#### IP
- `POWERLEVEL9K_IP_FOREGROUND=0` (black) - `~/.p10k.zsh:1687`
- `POWERLEVEL9K_IP_BACKGROUND=4` (blue) - `~/.p10k.zsh:1686`

#### WiFi
- `POWERLEVEL9K_WIFI_FOREGROUND=0` (black) - `~/.p10k.zsh:1730`
- `POWERLEVEL9K_WIFI_BACKGROUND=4` (blue) - `~/.p10k.zsh:1731`

#### Proxy
- `POWERLEVEL9K_PROXY_FOREGROUND=4` (blue) - `~/.p10k.zsh:1709`
- `POWERLEVEL9K_PROXY_BACKGROUND=0` (black) - `~/.p10k.zsh:1710`

#### NordVPN
- `POWERLEVEL9K_NORDVPN_FOREGROUND=7` (white) - `~/.p10k.zsh:745`
- `POWERLEVEL9K_NORDVPN_BACKGROUND=4` (blue) - `~/.p10k.zsh:746`

### File Managers & Shells

#### Ranger
- `POWERLEVEL9K_RANGER_FOREGROUND=3` (yellow) - `~/.p10k.zsh:755`
- `POWERLEVEL9K_RANGER_BACKGROUND=0` (black) - `~/.p10k.zsh:756`

#### Yazi
- `POWERLEVEL9K_YAZI_FOREGROUND=3` (yellow) - `~/.p10k.zsh:762`
- `POWERLEVEL9K_YAZI_BACKGROUND=0` (black) - `~/.p10k.zsh:763`

#### NNN
- `POWERLEVEL9K_NNN_FOREGROUND=0` (black) - `~/.p10k.zsh:769`
- `POWERLEVEL9K_NNN_BACKGROUND=6` (cyan) - `~/.p10k.zsh:770`

#### LF
- `POWERLEVEL9K_LF_FOREGROUND=0` (black) - `~/.p10k.zsh:776`
- `POWERLEVEL9K_LF_BACKGROUND=6` (cyan) - `~/.p10k.zsh:777`

#### XPLR
- `POWERLEVEL9K_XPLR_FOREGROUND=0` (black) - `~/.p10k.zsh:783`
- `POWERLEVEL9K_XPLR_BACKGROUND=6` (cyan) - `~/.p10k.zsh:784`

#### Vim Shell
- `POWERLEVEL9K_VIM_SHELL_FOREGROUND=0` (black) - `~/.p10k.zsh:790`
- `POWERLEVEL9K_VIM_SHELL_BACKGROUND=2` (green) - `~/.p10k.zsh:791`

#### Midnight Commander
- `POWERLEVEL9K_MIDNIGHT_COMMANDER_FOREGROUND=3` (yellow) - `~/.p10k.zsh:797`
- `POWERLEVEL9K_MIDNIGHT_COMMANDER_BACKGROUND=0` (black) - `~/.p10k.zsh:798`

#### Nix Shell
- `POWERLEVEL9K_NIX_SHELL_FOREGROUND=0` (black) - `~/.p10k.zsh:804`
- `POWERLEVEL9K_NIX_SHELL_BACKGROUND=4` (blue) - `~/.p10k.zsh:805`

#### Chezmoi Shell
- `POWERLEVEL9K_CHEZMOI_SHELL_FOREGROUND=0` (black) - `~/.p10k.zsh:818`
- `POWERLEVEL9K_CHEZMOI_SHELL_BACKGROUND=4` (blue) - `~/.p10k.zsh:819`

#### Direnv
- `POWERLEVEL9K_DIRENV_FOREGROUND=3` (yellow) - `~/.p10k.zsh:580`
- `POWERLEVEL9K_DIRENV_BACKGROUND=0` (black) - `~/.p10k.zsh:581`

#### Toolbox
- `POWERLEVEL9K_TOOLBOX_FOREGROUND=0` (black) - `~/.p10k.zsh:1651`
- `POWERLEVEL9K_TOOLBOX_BACKGROUND=3` (yellow) - `~/.p10k.zsh:1652`

### Task Management

#### TODO
- `POWERLEVEL9K_TODO_FOREGROUND=0` (black) - `~/.p10k.zsh:888`
- `POWERLEVEL9K_TODO_BACKGROUND=8` (gray) - `~/.p10k.zsh:889`

#### Timewarrior
- `POWERLEVEL9K_TIMEWARRIOR_FOREGROUND=255` (white) - `~/.p10k.zsh:913`
- `POWERLEVEL9K_TIMEWARRIOR_BACKGROUND=8` (gray) - `~/.p10k.zsh:914`

#### Taskwarrior
- `POWERLEVEL9K_TASKWARRIOR_FOREGROUND=0` (black) - `~/.p10k.zsh:927`
- `POWERLEVEL9K_TASKWARRIOR_BACKGROUND=6` (cyan) - `~/.p10k.zsh:928`

### Other Segments

#### Per Directory History
- `POWERLEVEL9K_PER_DIRECTORY_HISTORY_LOCAL_FOREGROUND=0` (black) - `~/.p10k.zsh:948`
- `POWERLEVEL9K_PER_DIRECTORY_HISTORY_LOCAL_BACKGROUND=5` (magenta) - `~/.p10k.zsh:949`
- `POWERLEVEL9K_PER_DIRECTORY_HISTORY_GLOBAL_FOREGROUND=0` (black) - `~/.p10k.zsh:950`
- `POWERLEVEL9K_PER_DIRECTORY_HISTORY_GLOBAL_BACKGROUND=3` (yellow) - `~/.p10k.zsh:951`

#### CPU Architecture
- `POWERLEVEL9K_CPU_ARCH_FOREGROUND=0` (black) - `~/.p10k.zsh:963`
- `POWERLEVEL9K_CPU_ARCH_BACKGROUND=3` (yellow) - `~/.p10k.zsh:964`

#### Package Version
- `POWERLEVEL9K_PACKAGE_FOREGROUND=0` (black) - `~/.p10k.zsh:1205`
- `POWERLEVEL9K_PACKAGE_BACKGROUND=6` (cyan) - `~/.p10k.zsh:1206`

## Prompt Layout

### Left Prompt Elements
From `~/.p10k.zsh:33`:
```zsh
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  os_icon
  dir
  vcs
  prompt_char
)
```

### Right Prompt Elements
From `~/.p10k.zsh:47`:
```zsh
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status
  command_execution_time
  background_jobs
  direnv
  asdf
  virtualenv
  anaconda
  pyenv
  goenv
  nodenv
  nvm
  nodeenv
  rbenv
  rvm
  fvm
  luaenv
  jenv
  plenv
  perlbrew
  phpenv
  scalaenv
  haskell_stack
  kubecontext
  terraform
  aws
  aws_eb_env
  azure
  gcloud
  google_app_cred
  toolbox
  context
  nordvpn
  ranger
  yazi
  nnn
  lf
  xplr
  vim_shell
  midnight_commander
  nix_shell
  chezmoi_shell
  vi_mode
  vpn_ip
  load
  disk_usage
  ram
  swap
  todo
  timewarrior
  taskwarrior
  per_directory_history
  cpu_arch
  time
  newline
)
```

## Separator Configuration

From `~/.p10k.zsh:171-188`:
- `POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\uE0B1'` (powerline thin right arrow)
- `POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='\uE0B3'` (powerline thin left arrow)
- `POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B0'` (powerline right arrow)
- `POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B2'` (powerline left arrow)
- `POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B0'`
- `POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B2'`
- `POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''` (empty)
- `POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=''` (empty)

## Multiline Prompt Settings

From `~/.p10k.zsh:158-163`:
- `POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND=` (transparent)
- `POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_GAP_BACKGROUND=` (transparent)
- `POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=244` (gray) - when applicable

## Icon Configuration

From `~/.p10k.zsh:125`:
- `POWERLEVEL9K_ICON_PADDING=none`

## Color Number Reference

Standard terminal color codes used throughout the configuration:
- **0** = black
- **1** = red
- **2** = green
- **3** = yellow
- **4** = blue
- **5** = magenta
- **6** = cyan
- **7** = white
- **8** = gray (bright black)

Extended 256-color codes used:
- **76** = bright green (lime)
- **196** = bright red (crimson)
- **208** = orange
- **232** = very dark gray (almost black)
- **240** = dark gray
- **244** = medium gray
- **250** = light gray
- **254** = very light gray (almost white)
- **255** = white (brightest)

## Summary

The configuration uses the **rainbow preset** from Powerlevel10k, which features:
- Colorful segment backgrounds using standard terminal colors (0-8)
- Mostly black (0) or white/light gray (254-255) foregrounds for readability
- Custom VCS formatting with distinct colors for different git states
- Extensive color customization for 50+ different segments
- Powerline separators with nerdfont-v3 icons
- Two-line prompt layout with sparse, concise information display

The configuration was generated by the p10k configuration wizard on 2026-02-16 at 11:10 CET based on the rainbow theme template.
