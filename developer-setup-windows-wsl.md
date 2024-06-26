# Developer Workstation Setup Guide for Windows + WSL2

### Passphrases

On passphrases, WSL, LastPass and any SSH/PGP keys will have separate
passphrases from your Windows/Domain SSO account(s), use a long passphrase that
you will remember.

It's best to use a short sentence, such as `I am not man, but Superman.`
including punctuation, you want 15+ characters. The typical
upper/lower/special/number combination requirements are no longer current best
practice suggestions from NIST and other security advisories. It's also best to
keep it until/unless there is a belief of a breach of security.

Once you have Bitwarden, LastPass or another password manager installed, you can
use that to remember your other passphrases in use. You usually only really need
to remember your system login(s) and your password manager in practice.

# Configurations

You should step through the installations below this section first, but
afterward, will want to reference or directly copy

## Windows Powershell

- Window's Home is...
  - `C:\Users\YOURNAME`
    - You may want to create a shortcut to your wsl home in your Quick access
- Examples in `shell/windows-home`
  - `.gitconfig` - Git configuration file
    - Update to use your Email and Name.
  - `profile.*.ps1` - powershell profile
    - Run `code $PROFILE` to edit your current powershell profile.
  - `.wslconfig` - set max memory for wsl usage, may grow too big otherwise.
    - Try to leave ~8gb open for windows, more if using Visual Studio
    - Half of your physical ram is typical

## Ubuntu Bash

- Ubuntu's Home is...
  - `~/` or `/home/YOURNAME` inside the environment
  - `\\wsl$\Ubuntu\home\YOURNAME` inside windows file explorer
    - You may want to create a shortcut to your wsl home in your Quick access
    - Start with `\\wsl$` in your file explorer address bar as your specific
      location may vary.
- Examples in `shell/wsl-ubuntu-home`
  - `.gitconfig` - configured git configuration
    - Update to use your Email and Name.
  - `.bashrc.default` - edited default ubuntu bashrc file _**NOTE:**_ Update the
    `export EMAIL=` statement to your address
  - `.bashrc.aliases` - file with helpful aliases defined for this project
    - _**NOTE:**_ update the `cdog` alias to your actual directory being used.
  - `.bashrc` - configured bashrc file
  - `bin/` - usefull command scripts - added to path in `.bashrc`

# Windows Applications

Note: Windows install commands below should be done from PowerShell (non-admin),
unless specified otherwise.

## Powershell Scripts

Enable unrestricted powershell scripts (can disable later if desired)

- Open an administrator powershell prompt
- `Set-ExecutionPolicy unrestricted`
- Close the powershell prompt/window

## App Installer (aka WinGet)

https://github.com/microsoft/winget-cli

- Run latest .msixbundle - will redirect to Windows Store to Windows Store, to
  Install "App Installer"

## Visual Studio Code

- `winget install Microsoft.VisualStudioCode`

Once visual studio code is installed, run it. On the left will be an extensions
side tab, about the 5th item down.

Under extensions search, look for `Remote Development` You will want to install
the Remote Development extension pack from Microsoft.

## Microsoft Windows Terminal

- `winget install Microsoft.WindowsTerminal`
- With the new terminal installed, you can close other sessions/terminals and
  pin this to your taskbar and start menu.
- Supports multi-tabs and different environments (powershell, wsl/ubuntu, git
  bash, etc)

## Powershell 7

- `winget install Microsoft.PowerShell`

## Git

```
winget install Git.Git --override '/COMPONENTScomponents="ext,ext\shellhere,ext\guihere,gitlfs,assoc,assoc_sh,windowsterminal,scalar"'
```

If this is a (re)install, uncheck the "Only show new options".

- Options:
  - Check: "Windows Explorer integration" (all)
  - Check: "Git LFS"
  - Check: "Associeate .git* ..."
  - Check: "Associate .sh ..." (optional)
  - Check: "Add Git Bash Profile to Windows Terminal"
  - Check "Scalar ..." (optional)
  - Next...
- "Use Visual Studio Code as Git's Default Editor"
  - Next...
- "Let Git Decide"
  - Next...
- "Use Git and optional Unix tools from Command Prompt"
  - Next...
- "Use bundled OpenSSH"
  - Next...
- "Use the native Windows Secure Channel Library"
  - Next...
- "Checkout as-is, commit Unix-style line endings"
  - Next...
- "Use Windows' default console window"
  - Next...
- "Default (fast-forward or merge)"
  - Can use "Rebase" if you prefer and understand this
  - Next...
- "Git Credential Manager"
  - Next...
- Extra Options:
  - Check "Enable file system caching"
  - Check "Enable symbolic links"
  - Next...
- Experimental Options:
  - Check: "Enable experimental support for psuedo consoles."
  - Check: "Enable experimental build-in file system monitor."
  - Next...

## Dotnet 6 SDK

- `winget install Microsoft.DotNet.SDK.6`
- `winget install Microsoft.DotNet.SDK.7`
- `dotnet tool install -g dotnet-format`
- `dotnet tool install -g grate`

## SQL Server Management Studio

- `winget install Microsoft.SQLServerManagementStudio`

## WSL

- `wsl --install`
- reboot

## Windows Updates

- Run windows updates until there are no more
- reboot

## Ubuntu (for WSL)

Unless otherwise specified, all further commands will be done in an "Ubuntu" WSL
shell inside Windows Terminal.

- `wsl --install -d Ubuntu-20.04`
- Note: Ubuntu user is _not_ your windows user
- `\\wsl$\Ubuntu\home\YOURUSER`

When first launching WSL/Ubuntu, you will be asked to create a user and a
passphrase, these are NOT your SSO/Windows account, you can use whatever you
like. Note that you will need the passphrase for every administrative action
under Ubuntu, and it you will need to remember this.

## Docker Desktop

- `winget install --exact --id Docker.DockerDesktop --accept-source-agreements --accept-package-agreements`
- Once installed you may need to reboot
- Under settings...
  - Use dockerd (moby)
  - ensure you have WSL2 integration with your Ubuntu environment
  - Kubernetes (optional)
- Set Docker Desktop to start with user
- Reboot

After reboot, check that it works under Ubuntu.

`docker ps`

If there's an error that you don't have permissions, run the following commands.

```
sudo groupadd docker
sudo usermod -aG docker ${USER}
newgrp docker
```

Close and re-open your terminal tab.

## Docker Alternative: Rancher Desktop

_**DO NOT INSTALL THIS IF YOU INSTLLED DOCKER DESKTOP**_

If you cannot use Docker Desktop, because of workplace/licensing restrictions,
you can use Rancher Desktop as a nearly drop-in replacement. You'll need to add
it to your startup by hand as there isn't currently a configuration option.

- `winget install suse.RancherDesktop`
- Once installed you may need to reboot
- Under settings...
  - Use dockerd (moby)
  - ensure you have WSL2 integration with your Ubuntu environment
  - Kubernetes (optional)
- Setup Rancher Desktop to start with user
  - Win+R
  - `shell:startup`
  - copy the launch shortcut to the startup dir
- Reboot

## Fira Code - Font

This will be used for displaying glyphs in the Starship prompt.

https://github.com/tonsky/FiraCode

This is used with Starship to display most glyphs.

- Download the latest
- Open the .zip file
- Under TTF directory...
  - Open each TTF file
  - Click Install button
  - Close window

### Configure Visual Studio Code

- open File->Preferences->Settings
- Search for "Font"
- Prepend `'Fira Code Regular',` to the font list.
- Optional, enable font ligatures.

### Configure Windows Terminal

- Open Settings (down arrow next to plus sigm)
- Open JSON Settings
- Inside `profiles`->`default`
  - add `"font": { "face": "Fira Code" }`
- Save and Close

## Starship.rs Prompt

https://starship.rs/

Best to use **Fira Code** font above.

- `winget install --id Starship.Starship`

## Configure Windows Environment

- Powershell 6
  - From a powershell 6 prompt, `code $profile`
  - Paste the contents from `shell/windows-home/profile.v6.ps1`
  - Save and exit
- Powershell 7
  - From a powershell 7 prompt, `code $profile`
  - Paste the contents from `shell/windows-home/profile.v7.ps1`
  - Save and exit
- Home Environment
  - From a powershell prompt, `code $env:userprofile`
  - Create/replace `.gitconfig`
    - contents from `shell/windows-home/.gitconfig`
    - Update name and email address
  - Create `.wslconfig`
    - contents from `shell/windows-home/.wslconfig`

---

# WSL Ubuntu Environment

In this repository under `shell/wsl-ubuntu-home`, you should copy the following
files into your WSL environment...

## Initial Bash Configuration

- `cp ~/.bashrc ~/.bashrc.default`
- `code ~/.bashrc`
  - comment out interactive lines (5-9)
- `touch ~/.bashrc.aliases`
- `mkdir ~/bin`

From here, you will be copying content from `shell/wsl-ubuntu-home` into your
environment. From your Ubuntu/bash shell, enter `code ~/` which should open VS
Code into your environment.

- `.bashrc` - this will be your new bash startup file, it's preconfigured for
  your environment once complete, and you should edit the `EMAIL` address export
  near the top to match your address.
- `.bashrc.default` - copy of original bashrc file, minor change/comment
- `.bashrc.aliases` - you can put useful shortcuts here.
- `.bashrc.proxy` - these are utility methods for turning the proxy settings
  on/off as necessary.
- `.gitconfig` - these are configuration options for git in the WSL environment.
  Update the email address and real name.

Once you have created/saved these files, you may close VS Code and any terminal
windows. From here you can open a fresh ubuntu window in terminal.

## Updates and Dependencies

Run the following commands to update your WSL Ubuntu Linux environment, as well
as install pre-requisites for other packages.

```
sudo apt-get update

sudo apt-get upgrade

sudo apt-get install -yqq \
    lzma gcc make zlib1g-dev libreadline-dev \
    libreadline8 sqlite3 libsqlite3-dev libbz2-dev \
    python-tk python3-tk tk-dev build-essential \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
    libsqlite3-dev wget curl llvm libncurses5-dev \
    xz-utils tk-dev libxml2-dev libxmlsec1-dev \
    libffi-dev liblzma-dev unixodbc unixodbc-dev odbcinst \
    git git-lfs libsecret-1-0 unzip zip pass gnupg2 pip
```

## Starship

```
curl -sS https://starship.rs/install.sh | sh
```

## GPG Key (For Rancher Auth)

```
gpg2 --gen-key

gpg_id="$(gpg --list-keys | grep "expires" -A1 | awk 'NR==2' | sed -e 's/^[ \t]*//')"
pass init $gpg_id
```

## SQL ODBC Driver

```
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > ~/microsoft.gpg

sudo install -o root -g root -m 644 ~/microsoft.gpg /etc/apt/trusted.gpg.d/

rm ~/microsoft.gpg

curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | sudo tee -a /etc/apt/sources.list.d/mssql-release.list

sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -yqq msodbcsql18 msodbcsql17 mssql-tools
```

## pyenv

### Clone pyenv

`git clone https://github.com/pyenv/pyenv.git ~/.pyenv`

### Clone pyenv virtualenv

`git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv`

### Setup local environment, register pyenv

Run the commands below in your current terminal to activate pyenv, these will
also be needed in your `.bashrc`.

```
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

### Install Python

Install the version of python to use and setup/configure global and local
environment(s)

_**NOTE:**_ Referencing `3.11.2` below, but any newer `3.x.x` release of Python
should work as well.

```
pyenv install 3.11.2
pyenv global 3.11.2
```

## Node.js, nvm and yarn

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm i 18
nvm alias default 18
nvm use 18

npm i -g npm
npm i -g yarn
```

## Dotnet 6

```
curl -L -o ~/bin/dotnet-install.sh https://dot.net/v1/dotnet-install.sh

chmod +x ~/bin/dotnet-install.sh

~/bin/dotnet-install.sh -c 6.0

dotnet tool install -g dotnet-format
```

Can use `dotnet-format --fix-style` to correct (most) stylecop linting issues in
`api.shopping` and `api.shopping.tests`.

## Deno

```
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

curl -fsSL https://deno.land/x/install/install.sh | sh

deno --version
```

## Go

[check go website](https://go.dev/dl/), for latest download url.

```
export PATH=$PATH:$HOME/.local/go/bin
export GOPATH=$HOME/src

wget https://go.dev/dl/go1.19.4.linux-amd64.tar.gz
tar -C ~/.local -xzf go1.19.4.linux-amd64.tar.gz
rm go1.19.4.linux-amd64.tar.gz

go version
```

## Rust

Default options should work...

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source "$HOME/.cargo/env"
```
