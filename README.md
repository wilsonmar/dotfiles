---
url: "https://github.com/wilsonmar/dotfiles/blob/main/README.md"
lastchange: "v001 + start again with chezmoi :README.md"
---

<a target="_blank" href="https://github.com/wilsonmar/dotfiles/blob/main/README.md "><img align="right" width="100" height="100" alt="dotfiles.png" src="https://github.com/wilsonmar/dotfiles/blob/main/assets/README-qr.png?raw=true" />
These settings have been refined over several years at <a target="_blank" href="https://wilsonmar.github.io/mac-setup">wilsonmar/mac-setup</a> based on afranken/dotfiles.

This now uses Swiss paraglider Tom Payne's <a target="_blank" href="https://github.com/twpayne/chezmoi">open-source project</a> <a target="_blank" href="https://www.chezmoi.io/#what-does-chezmoi-do">chezmoi</a>, pronounced /ʃeɪ mwa/ (shay-mwa), a French phrase for "my home".

After you complete the steps below, you can legitimately add to your resume or LinkedIn profile:

   <ul>Configured, on new Macs, from scratch, a large set of utilities, languages tools, local AI apps,
   and access to AWS, Azure, and Google cloud services.
   The custom automation reduces onboarding errors and time
   <strong>from days to less than an hour</strong>.
   Documentation of steps were validated by others.
   With a common set of tools, the entire team can now pair program together efficiently.
   This makes it easy to achieve cybersecurity directives to keep all software up-to-date frequently.
   </ul>

This automation script is idempotent. The script detects what has already been installed, then verifies the success of each step. It performs workarounds for known issues.


## Single Line Chezmoi Install

Chezmoi installs utilities and apps onto a new, empty machine with a single command on the user's $HOME folder.

The <tt>curl</tt> is built-in to macOS. But if you prefer to use <tt>wget</tt>, first install Apple's Command Line Tools (xcode-select --install), then install Homebrew at https://brew.sh. <a target="_blank" href="https://www.youtube.com/watch?v=QDV204YYi9Y">VIDEO</a>:
```
brew install wget
wget -V
```
PROTIP: wget references a certificate at default location
<tt>/etc/ssl/cert.pem</tt>

### Private vs Public Dotfiles

If the user's repository is <strong>private</strong>, and git has been configured, the <tt>git@</tt> protocol can be used:
```
GITHUB_USERNAME="johndoe"
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin \
   init --apply git@github.com:$GITHUB_USERNAME/dotfiles.git
```
If a repository is <strong>public</strong>, the <tt>https://</tt> protocol can be used instead:
```
GITHUB_USERNAME="johndoe"
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin \
   init --apply $GITHUB_USERNAME
```
Use of <tt>sh</tt> means the command is portable to any machine which has the POSIX shell provided by default on popular operating systems (macOS, Linux, Windows).

The <tt><strong>init</strong></tt> parameter tells the script to run.

The <tt><strong>-b</strong></tt> parameter tells the script to install in folder <tt>~/.local/bin</tt> instead of the default <tt>~/bin</tt> which does not require root (sudo) access and the need to type in a password.

Chezmoi uses the value of <tt>$GITHUB_USERNAME</tt> provided to construct a URL where it obtains configuration files to control the installation within a repository everyone names <strong>dotfiles</strong>.

Chezmoi is widely used, so it's interesting to explore the different hacks, configurations, and time-saving automations developers have in their dotfiles.
Search for "dotfiles chezmoi" on GitHub:
```
https://github.com/search?q=dotfiles%20chezmoi&type=repositories
```
   * https://github.com/jasonmorganson/dotfiles
   * https://github.com/andrewconnell/dotfiles
   * https://github.com/evanchiu/dotfiles
   * https://github.com/jeffreyjackson/mac-apps
   * https://github.com/jaywcjlove/awesome-mac/blob/master/README.md

   * https://github.com/ryanoasis/nerd-fonts
   * https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Inconsolata
   * https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/InconsolataLGC

Chezmoi author Tom Payne's own dotfiles repository is at:

   <ul><a target="_blank" href="https://github.com/twpayne/dotfiles">https://github.com/twpayne/dotfiles</a></ul>

Download the repository and adopt pieces of it in your own repository.

   * In the assets folder, I don't have a Keychron K2 Pro Wireless Mechanical Keyboard, so I don't need his <tt>keychron</tt> json files.
   * I replaced his <tt>twpayne@gmail.com.jpg</tt> photo with my own.
   * In folder Documents/WindowsPowerShell <tt>Microsoft.PowerShell_profile.ps1</tt> file containing:
   ```
   $env:Path += ";$env:UserProfile\bin"
   Set-Alias -Name g -Value git
   ```

In file <tt>home/dot_bash_aliases.tmpl</tt>
   * <tt>dot_bash_aliases.tmpl</tt> sets keyboard aliases. TODO: macsetup/aliases.sh

In folder <tt>home/.chezmoiscripts</tt> is a file for each operating system:
   * darwin
   * linux
   * windows

   Additionally, file <tt>home/.chezmoiscripts/run_onchange_after_configure-vscode.sh.tmpl</tt> adds extentions. TODO: Reconcile list at <tt>vscode-ext-all.txt</tt>.

Within <tt>home/.chezmoiscripts/darwin</tt> are:
   * run_onchange_before_install-google-earth-pro.sh updates rosetta as well
   * run_onchange_before_install-packages.sh.tmpl lists brew packages to install

   * run_onchange_after_configure-defaults.sh lists commands instead of Apple System Settings GUI. TODO: replace with mac-setup/mydotfile.sh which lists commands by System Settings GUI menu order.
   * run_onchange_after_configure-notificationcenter.sh
   * run_onchange_after_configure-desktop.sh says "osascript -e 'tell application "System Events" to tell every desktop to set picture to "/System/Library/Desktop Pictures/Solid Colors/Space Gray Pro.png" as POSIX file'
   * run_onchange_after_configure-dock.sh lists Apple apps to remove from the Dock.


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
* wezterm

I add:
* warp <em>(improved CLI)</em>
* gh <em>(GitHub.com CLI)</em>
* ???

QUESTION: What about apps?


### Secrets handling

Chezmoi's functionality include password manager integration.

You, too can store personal secrets in 1Password app. First, install the 1Password CLI, which provided the "op" command for signing into 1Password:
```
eval $(op signin)
```

Edit each ".tmpl" (template) file in <tt>home/private_dot_ssh</tt> folder:

Edit file <tt>authorized_keys.tmpl</tt> to change "twpayne" to your own GitHub user name (which TODO: should be templatized):
```
{{ range (gitHubKeys "twpayne") -}}
{{   .Key }}
{{ end -}}
```

Edit file <tt>home/private_dot_ssh/config.tmpl</tt> to contain only the web properties you use (github.com), and remove the others.

Files <tt>id_rsa.pub.tmpl</a> and <tt>private_id_rsa.tmpl</tt> contain:

The <tt>onepasswordRead</tt> function to read secrets from 1Password:
```
{{ if .flarm -}}
{{   onepasswordRead "op://FLARM/SSH Key/public key" .onepasswordAccount }}
{{ else if .personal -}}
{{   onepasswordRead "op://Personal/SSH Key/public key" .onepasswordAccount }}
{{ end -}}
```
"flarm" is a boolean variable that is set to true if the user is using a work machine.???


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
