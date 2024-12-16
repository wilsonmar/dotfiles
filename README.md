---
url: "https://github.com/wilsonmar/dotfiles/blob/main/README.md"
lastchange: "v005 + mac-setup flows :README.md"
---

<a target="_blank" href="https://github.com/wilsonmar/dotfiles/blob/main/README.md"><img align="right" width="100" height="100" alt="dotfiles.png" src="https://github.com/wilsonmar/dotfiles/blob/main/assets/readme-qr.png?raw=true" /></a>

WHY? This was created so that you can legitimately add to your resume and LinkedIn profile:

   <ul>Configured, on new Macs, from scratch, a large set of utilities, languages tools, local AI apps,
   and access to AWS, Azure, and Google cloud services.
   The custom automation reduces onboarding errors and time
   <strong>from days to less than an hour</strong>.
   Documentation of steps were validated by others.
   With a common set of tools, teams can now pair-program together efficiently.
   This makes it easy to achieve cybersecurity directives about keeping all software up-to-date frequently.
   </ul>


## Customize the Base dotfiles

This <a target="_blank" href="https://github.com/wilsonmar/dotfiles">wilsonmar/dotfiles repo</a> currently makes use of <a target="_blank" href="https://github.com/twpayne/chezmoi">open-source project</a> named <a target="_blank" href="https://www.chezmoi.io/#what-does-chezmoi-do">chezmoi</a> (pronounced /ʃeɪ mwa/ (shay-mwa), a French phrase for "my home"). Chozmoi was created in 2021 by Zurich-based paraglider Tom Payne. Like many others, I coverted to Tom's Chezmoi from the custom CLI shell scripts I refined over several years at <a target="_blank" href="https://wilsonmar.github.io/mac-setup">wilsonmar/mac-setup</a>, as described at <a target="_blank" href="https://wilsonmar.github.io/mac-setup">https://wilsonmar.github.io/mac-setup</a>. My approach used a clumsy way to initiate utilities on a new macOS machine:

<img alt="chezmoi-mac-setup-1710x780.png" src="https://res.cloudinary.com/dcajqrroq/image/upload/v1734371032/chezmoi-mac-setup-1710x780_vsp9sv.png" />

Both approaches makes use of the default internet browser app (Safari), and type in the URL of the sample dotfiles repository in GitHub to <strong>fork</strong> it under the GitHub account of the new user.
The browser can be used to <strong>edit (customize) the sample install files</strong>.

But the clumsy way of my mac-setup repo is to, on the new machine, 
click the "Code" button to click "Download.ZIP".
Open the Finder app to Navigate to the "Downloads" folder, then drag-and-drop custom installer scripts to the user's home directory. 

<hr />

## Advantages of Chezmoi

Use of Chezmoi similifies the above process solves several problems.
Chezmoi has several advantages:

   * More people know about how Chozmoi works than my mac-setup repo.
   * <a href="#Conventions">A pattern (naming conventions) for folders and files to specify configuration settings</a>.
   * <a href="#ChezmoiCLI">A simple CLI utility that works like <tt>git</tt></a>.
   * <a href="#TemplateLanguage">A template language</a> (explained <a target="_blank" href="https://budimanjojo.com/2021/12/13/managing-dotfiles-with-chezmoi/">here</a>)
   * <a href="#SingleCurlCommand">A single curl command to download, clone, and update configuration settings from a GitHub repo</a> (thanks to its use of Golang, which does not need dependencies to run).

With Chezmoi, a user simply opens the Terminal app and executes the following command:
```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```
This uses the <tt>curl</tt> command already on the macOS.

??? where <tt>$GITHUB_USERNAME</tt> is the user name of the GitHub account where the Dotfiles repo is stored.

The command above downloads and installs an editor and other utilities specified among "dotfiles".

managing multiple dotfiles across multiple machines.

## Conventions

### dotfiles repository

Chezmoi assumes that install configuration files are within a <tt><strong>dotfiles repository</strong></tt>, like other options to automate installation, such as the symlink farm manager <a target="_blank" href="https://www.gnu.org/software/stow/manual/stow.html">GNU Stow for Linux</a>.

File <a target="_blank" href="https://github.com/wilsonmar/dotfiles/blob/main/.chezmoi.yaml">dotfiles/.chezmoi.yaml</a> at the repository's root specifies the repository's structure of folders and files.

Chozmoi looks for a Bash shell script file named <tt>install.sh</tt> to define folders on the machine.

This would include the variable <strong>script_folder</strong> which defines the location (file path)of the script.

The <tt>install.sh</tt> script is executed by the <tt>chezmoi</tt> utility.


## Fork chezmoi dotfiles repo

1. In an internet browser, click this URL to open it:

   <a target="_blank" href="https://github.com/twpayne/chezmoi">https://github.com/twpayne/chezmoi</a>

1. You need to have created your own GitHub account.

1. Click the "Start" if you find it helpful.

1. Click "Fork" on the upper-right corner so that you have the version of the utility if the repo ever goes away.

   <a name="ReleaseVersion"></a>

1. Note the release version identifier. At time of writing, it was "v2.50.0".


## Single curl command

This automation script is idempotent. The script detects what has already been installed, then verifies the success of each step. It performs workarounds for known issues.

Chezmoi's approach has users craft a <strong>single curl command</strong> on the Terminal of a new, empty machine, Chezmoi retrieves the <strong>dotfiles</strong> repository of a named GitHub.com user. Specifications and scripts in that repo  controls all Chezmoi installs.

The <tt>curl</tt> is built-in to macOS. But if you prefer to use <tt>wget</tt>:
1. Install Apple's Command Line Tools using this built-in command:
   ```
   xcode-select --install
   ```
1. Install Homebrew at https://brew.sh. <a target="_blank" href="https://www.youtube.com/watch?v=QDV204YYi9Y">VIDEO</a>:
1. Use brew to install wget:
   ```
   brew install wget
   ```
1. Verify install of wget:
   ```
   wget -V
   ```

NOTE: wget references a certificate at default location at <tt>/etc/ssl/cert.pem</tt>


## Public Dotfiles

Chezmoi uses the value within system variable <tt>$GITHUB_USERNAME</tt> to construct the
<strong>Dotfiles</strong> repository URL where it obtains configuration files controlling installation.

   <ul>REMEMBER: The user's GitHub repository must be named "Dotfiles".
   </ul>


Manual actions described below make use of the most simplistic Dotfiles repo at:
   * <a target="_blank" href="https://github.com/wmojmt/Dotfiles">https://github.com/wmojmt/Dotfiles</a>

Chezmoi is widely used, so it's interesting to explore the different hacks, configurations, and time-saving automations developers have in their dotfiles.
Search for "dotfiles chezmoi" onx GitHub:
```
https://github.com/search?q=dotfiles%20chezmoi&type=repositories
```
   * Chezmoi author Tom Payne's own dotfiles repository is at:<br /><a target="_blank" href="https://github.com/twpayne/dotfiles">https://github.com/twpayne/dotfiles</a>

   * https://github.com/lazappi/chezmoi-dotfiles/
   * https://github.com/halostatue/dotfiles
   * https://github.com/ryanb/dotfiles
   * https://github.com/henrik/dotfiles

   * https://github.com/jasonmorganson/dotfiles
   * https://github.com/evanchiu/dotfiles
   * https://github.com/jeffreyjackson/mac-apps
   * https://github.com/jaywcjlove/awesome-mac/blob/master/README.md

   * https://github.com/bkerley/zshkit
   * https://github.com/mattfoster/zshkit
   * https://github.com/robbyrussell/oh-my-zsh


The simplest case is if the Dotfiles repository is <strong>public</strong>. Then, the <tt>https://</tt> protocol is used to install into the default folder <tt>$HOME/.local/bin</tt> (which Chezmoi creates):
```
GITHUB_USERNAME="johndoe"
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

<a name="Init"></a>

## Chezmoi Commands

https://www.chezmoi.io/user-guide/command-overview/

Once Chezmoi is installed, <tt>chezmoi init</tt> creates chezmoi's source directory and a git repo on a new machine.


<a name="ConfigFiles"></a>

## Chezmoi Config files

By default, Chezmoi stores machine-specific config file at <tt>~/.config/chezmoi/chezmoi.toml</tt>
It contains entries such as this to set the default text editor to use Visual Studio Code:
```
[edit]
    command = "code"
    args = ["--wait"]
```

The above configuration entry can also be set using CLI command:
```
export EDITOR="code --wait"
```

Rather than using a text editor, Chezmoi provides commands:

chezmoi data prints the available template data.

chezmoi add --template $FILE adds $FILE as a template.

chezmoi chattr +template $FILE makes an existing file a template.

chezmoi cat $FILE prints the target contents of $FILE, without changing $FILE.

chezmoi execute-template for testing and debugging templates.

<a name="Templates"></a>

## Chezmoi Template files


## folders

By default, Chezmoi stores the source state at <tt>~/.local/share/chezmoi</tt>

The config file is used to configure the source state used to generate the destination state. 

The target state is the desired state of the destination directory.

The target state includes regular files and directories, and may also include symbolic links, scripts to be run, and targets to be removed.


### Private Dotfiles

If the user's dotfiles repository is <strong>private</strong>, and git has been configured, the <tt>git@</tt> protocol is used in the command:
```
GITHUB_USERNAME="johndoe"
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin \
   init --apply git@github.com:$GITHUB_USERNAME/dotfiles.git
```

Use of <tt>sh</tt> (shell) means the command is portable to any machine which has the POSIX shell provided by default on popular operating systems (macOS, Linux, Windows).

Chezmoi has 4 areas where it stores data: "Remote repo", "Working copy", "Home directory", "local repo".

   * Like other Git-controlled projects, the "Working copy" area is the local copy of the remote repo in GitHub.

   * Also like Git, <tt><strong>chezmoi init</strong></tt> creates the "Working copy" area.

   * If a $GITHUB_USERNAME is specified with <tt><strong>chezmoi init</strong></tt>, that user's "dotfiles" repo is cloned into the "Working copy" area.
   
   * As with other Git repos, the "git commit" commits changes from the "Working copy" area to the <strong>local repo</strong> area, from which the "git push" pushes changes from the "Working copy" area to the remote GitHub repo.

   * QUESTION: What is there a <tt>chezmoi add</tt> command like git add?

   * <tt><strong>chezmoi init --apply $GITHUB_USERNAME</strong></tt> clones the remote repo into the "Home direcotry" area.

   * <tt><strong>chezmoi update $GITHUB_USERNAME</strong></tt> updates the remote dotfiles repo into the "Home direcotry".
   
<a target="_blank" href="https://www.chezmoi.io/user-guide/setup/#use-a-hosted-repo-to-manage-your-dotfiles-across-multiple-machines"><img alt="chezmoi-setup-1690x500.png" src="https://res.cloudinary.com/dcajqrroq/image/upload/v1734148511/chezmoi-setup-1690x500_kmjnlt.png" /></a>

   * The <tt><strong>apply</strong></tt> parameter copies the remote repo into the "Home directory" area.
   * The <tt><strong>apply</strong></tt> parameter without the remote repo copies from "Working copy" to "Home directory".

<a target="_blank" href="https://www.chezmoi.io/user-guide/setup/#use-a-hosted-repo-to-manage-your-dotfiles-across-multiple-machines"><img alt="chezmoi-git-1686x465.png" src="https://res.cloudinary.com/dcajqrroq/image/upload/v1734368291/chezmoi-git-cmds-1691x517_mmaciq.png" /></a>

The <tt><strong>-b</strong></tt> parameter tells the script to install in a folder other than the default <tt>~/.local/bin</tt> <tt>~/bin</tt> which does not require root (sudo) access and the need to type in a password.

So we download that as the starting point to adapt it for our own use.

   * In the assets folder, I don't have a Keychron K2 Pro Wireless Mechanical Keyboard, so I don't need his <tt>keychron</tt> json files.
   * I replaced his <tt>twpayne@gmail.com.jpg</tt> photo file with my own.
   * In folder Documents/WindowsPowerShell <tt>Microsoft.PowerShell_profile.ps1</tt> file containing:
   ```
   $env:Path += ";$env:UserProfile\bin"
   Set-Alias -Name g -Value git
   ```

### Operating Systems

In folder <tt>home/.chezmoiscripts</tt> is a file for each operating system:
   * darwin
   * linux
   * windows

File <tt>run_onchange_after_configure-dock.sh</tt> lists Apple apps to remove from the Dock.
   QUESTION: DOes this remove files of apps not wanted (to save disk space)?

Within <tt>home/.chezmoiscripts/darwin</tt> are:
   * run_onchange_before_install-google-earth-pro.sh updates rosetta as well
   * run_onchange_before_install-packages.sh.tmpl lists brew packages to install

   * run_onchange_after_configure-defaults.sh lists commands instead of Apple System Settings GUI. TODO: replace with mac-setup/mydotfile.sh which lists commands by System Settings GUI menu order.
   * run_onchange_after_configure-notificationcenter.sh
   * run_onchange_after_configure-desktop.sh says "osascript -e 'tell application "System Events" to tell every desktop to set picture to "/System/Library/Desktop Pictures/Solid Colors/Space Gray Pro.png" as POSIX file'

~/Library/Fonts/ contains .ttf files

### Automation using Lua

Hammerspoon is a desktop automation tool bridges the macOS operating system to the Lua scripting language in .lua files. It's installed using:
```
brew install --cask hammerspoon
```
which creates a .hammerspoon folder containing <tt>init.lua</tt> - the primary configuration file where users can write custom automation scripts.

### Aliases (Keyboard shortcuts)

In file <tt>home/dot_bash_aliases.tmpl</tt>
   * <tt>dot_bash_aliases.tmpl</tt> sets keyboard aliases. TODO: macsetup/aliases.sh

### VSCode Extensions

File <tt>home/.chezmoiscripts/run_onchange_after_configure-vscode.sh.tmpl</tt> adds extentions. TODO: Reconcile list at <tt>vscode-ext-all.txt</tt>.


Tom's <tt>install.sh</tt> script sets chemoi's installation folder
```
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
echo $script_dir
```
On a macOS Silicon machine, the output is:
```
/opt/homebrew/bin
```
On a macOS Intel machine, the output is:
```
/usr/local/bin
```

Tom's <tt>home/private_dot_config</tt> folder contains repository a file for each CLI package to install:
* forge
* git
* homebrew
* nvim
* private_karabiner
* psql
* readline
* ripgrep
* tmux
* wezterm - A GPU-accelerated cross-platform terminal emulator and multiplexer written by @wez and implemented in Rust

I add:
* warp <em>(improved CLI)</em>
* gh <em>(GitHub.com CLI)</em>
* ???

QUESTION: What about apps?


### Secrets handling

Chezmoi's functionality include integration with password manager 1Password app.

See https://www.chezmoi.io/user-guide/tools/editor/

1. TODO: Install 1Password app
1. TODO: Install the 1Password CLI

1. Edit file <tt>home/dot_zshrc.tmpl</tt>
   ```
   {{- if .personal }}
   export CHEZMOI_GITHUB_ACCESS_TOKEN={{ onepasswordRead "op://chezmoi/chezmoi GitHub API Token/credential" .onepasswordAccount | trim }}
   {{-   if eq .chezmoi.os "darwin" }}
   {{-   end }}
   {{- end }}
   ```
1. Invoke 1Password's "op" command for signing into 1Password as API:
```
eval $(op signin)
```

Files which vary from machine to machine are executed as templates, typically using data from the local machine's config file to tune the final contents specific to the local machine.

Edit each ".tmpl" (template) file in <tt>home/private_dot_ssh</tt> folder:

Edit file <tt>authorized_keys.tmpl</tt> to change "twpayne" to your own GitHub user name (which TODO: should be templatized):
```
{{ range (gitHubKeys "twpayne") -}}
{{   .Key }}
{{ end -}}
```
Also edit the name TODO: exchange with a variable? at:
   * <tt>home/private_dot_config/git/config.tmpl</tt>
   * <tt>home/.chezmoiscripts/run_onchange_after_configure-vscode.sh.tmpl</tt>

Although you can use JSON or YAML:
   * home/private_dot_config/forge/forge.toml.tmpl
   * home/.chezmoi.toml.tmpl
   * home/.chezmoiexternal.toml.tmpl contains several external websites specific to twpayne

Edit file <tt>home/private_dot_ssh/config.tmpl</tt> to contain only the web properties you use (github.com), and remove the others.

Files <tt>home/private_dot_ssh/id_rsa.pub.tmpl</tt> and <tt>private_id_rsa.tmpl</tt> contains
the <tt>onepasswordRead</tt> function to read secrets from 1Password:
```
{{ if .flarm -}}
{{   onepasswordRead "op://FLARM/SSH Key/public key" .onepasswordAccount }}
{{ else if .personal -}}
{{   onepasswordRead "op://Personal/SSH Key/public key" .onepasswordAccount }}
{{ end -}}
```
Replace "FLARM" and "flarm" (which stands for "FLight alARM"), the enterprise work machine Tom uses for,
with the keyword for your work machine.

Also edit:
   * home/.chezmoi.toml.tmpl defines boolean feature tags used by other Chezmoi template files.

   * home/dot_zshrc.tmpl to configure .zshrc
   * home/dot_p10k.zsh.tmpl to configure the Powerlevel10k theme customization tool specified in file .zshrc for Zshell on top of "Oh My ZSH" already installed. CAUTION: As of 2024, the project is reportedly in "life support mode", with some developers suggesting alternatives like Oh My Posh.

   * home/private_dot_ssh/config.tmpl
   * home/private_dot_config/forge/forge.toml.tmpl
   * home/private_dot_ssh/private_id_rsa.tmpl

### Dotfiles locally

By default, Chezmoi stores the desired state of your dotfiles in the directory
```
~/.local/share/chezmoi
```

Dotfiles are <strong>idempotent</strong>.


### Base on Golang

Unlike Python and Java, which first require a compiler to be installed,  Chezmoi's binary was created using the Go language, which has no dependencies.

The <tt>internal/uv.lock</tt> file is used by the package manager UV to prevent concurrent access to the Go runtime.



### Variables in .gitconfig

<tt>~/.gitconfig</tt> that controls Git is an example of a dotfile.

Within the dotfiles repository, <strong>Variables</strong> can be used to vary configuration settings for different environments (such as work and personal machines).

<a target="_blank" href="https://devblog.jpcaparas.com/dotfiles-managing-machine-specific-gitconfig-with-chezmoi-user-defined-template-variables-400071f663c0">BLOG</a>:
This sample file uses Go’s text/template syntax to first check if email and name variables exist using the hasKey function so that it can fall back to default values if a custom value is not provided.
```
[user]
    email = {{ if hasKey . "email" }}{{ .email | quote }}{{ else }}"hey@johndoespersonalspace.com"{{ end }}
    name = {{ if hasKey . "name" }}{{ .name | quote }}{{ else }}"John Doe"{{ end }}
[core]
    excludesFile = "{{ .chezmoi.homeDir }}/.gitignore_global"
[pull]
    rebase = false
[init]
    defaultbranch = main
[merge]
    ff = no
    commit = no
```
Go's <tt>hasKey</tt> function references values in Chezmoi's config file at
```
~/.config/chezmoi/chezmoi.toml
```


## Google Sign-in pop-up

To disable Google sign-in prompts across your accounts:

1. Go to https://myaccount.google.com
1. Click "Security" on the left menu.
1. Click "See All Connections"
1. Click the gear icon
1. Turn off the "Google Account Sign-in Prompts" toggle

The above needs to repeated for each of your Google accounts:

## Fonts

   * https://github.com/ryanoasis/nerd-fonts
   * https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Inconsolata
   * https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/InconsolataLGC

