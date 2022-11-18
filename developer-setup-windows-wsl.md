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

Once you have LastPass installed, you can use that to remember your other
passphrases in use. You usually only really need to remember your system
login(s) and your lastpass in practice. For personal use, you might also
consider BitWarden as an alternative password manager.

# Configurations

You should step through the installations below this section first, but
afterward, will want to reference or directly copy

### Windows Powershell

- Window's Home is...
  - `C:\Users\YOURNAME`
    - You may want to create a shortcut to your wsl home in your Quick access
- Examples in `_docs/shell/windows-home`
  - `.gitconfig` - Git configuration file
    - Update to use your Email and Name.
  - `profile.*.ps1` - powershell profile
    - Run `code $PROFILE` to edit your current powershell profile.
  - `.wslconfig` - set max memory for wsl usage, may grow too big otherwise.
    - Try to leave ~8gb open for windows, more if using Visual Studio
    - Half of your physical ram is typical

### Ubuntu Bash

- Ubuntu's Home is...
  - `~/` or `/home/YOURNAME` inside the environment
  - `\\wsl$\Ubuntu\home\YOURNAME` inside windows file explorer
    - You may want to create a shortcut to your wsl home in your Quick access
    - Start with `\\wsl$` in your file explorer address bar as your specific
      location may vary.
- Examples in `_docs/shell/wsl-ubuntu-home`
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

### LastPass

https://www.lastpass.com/

- Create/Register an account with your `healthtrustpg.com` email address.
- Install the browser plugin for your browser, Edge, Firefox, Chrome etc should
  all be supported.
- There is also an app for use in Android and iOS.

### Powershell Scripts

Enable unrestricted powershell scripts (can disable later if desired)

- Open an administrator powershell prompt
- `Set-ExecutionPolicy unrestricted`
- Close the powershell prompt/window

### App Installer (aka WinGet)

https://github.com/microsoft/winget-cli

- Run latest .msixbundle - will redirect to Windows Store to Windows Store, to
  Install "App Installer"

### Visual Studio Code

- `winget install Microsoft.VisualStudioCode`

### Microsoft Windows Terminal

- `winget install Microsoft.WindowsTerminal`
- With the new terminal installed, you can close other sessions/terminals and
  pin this to your taskbar and start menu.
- Supports multi-tabs and different environments (powershell, wsl/ubuntu, git
  bash, etc)

### Powershell 7

- `winget install Microsoft.PowerShell`

### Git

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
- "None" (GCM installed separately after this)
  - Next...
- Extra Options:
  - Check "Enable file system caching"
  - Check "Enable symbolic links"
  - Next...
- Experimental Options:
  - Check: "Enable experimental support for psuedo consoles."
  - Check: "Enable experimental build-in file system monitor."
  - Next...

### Git Credential Manager

- `winget install Microsoft.GitCredentialManagerCore`

### Dotnet 6 SDK

- `winget install Microsoft.DotNet.SDK.6`
- `dotnet tool install -g dotnet-format`

### WSL

- `wsl --install`
- reboot

### Windows Updates

- Run windows updates until there are no more
- reboot

### Ubuntu (for WSL)

Unless otherwise specified, all further commands will be done in an "Ubuntu" WSL
shell inside Windows Terminal.

- `wsl --install -d Ubuntu-20.04`
- Note: Ubuntu user is _not_ your windows user
- `\\wsl$\Ubuntu\home\YOURUSER`

When first launching WSL/Ubuntu, you will be asked to create a user and a
passphrase, these are NOT your SSO/Windows account, you can use whatever you
like. Note that you will need the passphrase for every administrative action
under Ubuntu, and it you will need to remember this.

### Docker Desktop

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
```

Close and re-open your terminal tab.

### Docker Alternative: Rancher Desktop

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

### Starship.rs Prompt

https://starship.rs/

Best to use **Fira Code** font above.

- `winget install --id Starship.Starship`
- See **Configurations** section

### Fira Code - Font

https://github.com/tonsky/FiraCode

This is used with Starship to display most glyphs.

- Download the latest
- Open the .zip file
- Under TTF directory...
  - Open each TTF file
  - Click Install button
  - Close window
- See **Configurations** section

#### Visual Studio Code

- open File->Preferences->Settings
- Search for "Font"
- Prepend `'Fira Code Regular',` to the font list.
- Optional, enable font ligatures.

#### Windows Terminal

- Open Settings (down arrow next to plus sigm)
- Open JSON Settings
- Under `profiles`->`default`
  - `"fontFace": "Fira Code"`
- Save and Close

# WSL Ubuntu Environment

### Initial Bash Configuration

- `cp ~/.bashrc ~/.bashrc.default`
- `code ~/.bashrc`
  - comment out interactive lines (5-9)
- `touch ~/.bashrc.aliases`
- `touch ~/.bashrc`
  - Always at the top
    - `source ~/.bashrc.default`
    - `export EMAIl=YOUR.NAME@healthtrustpg.com`
  - Always at the bottom
    - `source ~/.bashrc.aliases`
- `mkdir ~/bin`

### Starship

```
curl -sS https://starship.rs/install.sh | sh
```

See **Configuration** - `_docs/shell/wsl-ubuntu-home/.bashrc`

### Updates and Dependencies

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
    libffi-dev liblzma-dev unixodbc odbcinst \
    git git-lfs lastpass-cli pip
```

### Lastpass CLI

- `lpass login YOUREMAIL`
- Enter your passphrase for lastpass

### pyenv

#### Clone pyenv

`git clone https://github.com/pyenv/pyenv.git ~/.pyenv`

#### Clone pyenv virtualenv

`git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv`

#### Setup local environment, register pyenv

See **Configuration** - `_docs/shell/wsl-ubuntu-home/.bashrc`

Run the commands below in your current terminal to activate pyenv, these will
also be needed in your `.bashrc`.

```
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

#### Install Python

Install the version of python to use and setup/configure global and local
environment(s)

_**NOTE:**_ Referencing `3.11.0` below, but any newer `3.x.x` release of Python
should work as well.

```
pyenv install 3.11.0
pyenv global 3.11.0
```

### Node.js, nvm and yarn

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

See **Configuration** - `_docs/shell/wsl-ubuntu-home/.bashrc`

### Dotnet 6

```
curl -L -o ~/bin/dotnet-install.sh https://dot.net/v1/dotnet-install.sh

chmod +x ~/bin/dotnet-install.sh

~/bin/dotnet-install.sh -c 6.0

dotnet tool install -g dotnet-format
```

See **Configuration** - `_docs/shell/wsl-ubuntu-home/.bashrc`

Can use `dotnet-format --fix-style` to correct (most) stylecop linting issues in
`api.shopping` and `api.shopping.tests`.

### Deno

```
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

curl -fsSL https://deno.land/x/install/install.sh | sh

deno --version
```

### Go

[check go website](https://golang.google.cn/dl/), for latest download url.

```
export PATH=$PATH:$HOME/.local/go/bin
export GOPATH=$HOME/src

wget https://golang.google.cn/dl/go1.19.3.linux-amd64.tar.gz
tar -C ~/.local -xzf go1.19.3.linux-amd64.tar.gz
rm go1.19.3.linux-amd64.tar.gz

go version
```

See **Configuration** - `_docs/shell/wsl-ubuntu-home/.bashrc`

### Rust

Default options should work...

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source "$HOME/.cargo/env"
```

See **Configuration** - `_docs/shell/wsl-ubuntu-home/.bashrc`
