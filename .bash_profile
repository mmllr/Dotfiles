# rvm & brew git/bash completion terminal setup
# for dev desktop only on osx
# Run the following commands in order to use this script:
################################################################
# !! => Update/Install xcode Command Line Tools <= !!
# In your shell/terminal:
# ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
# brew install bash-completion
# brew install git
# brew install curl-ca-bundle
# curl -L https://get.rvm.io | bash -s stable
# rvm autolibs homebrew
# rvm requirements
################################################################

# source /usr/local/Cellar/bash-git-prompt/2.3/share/gitprompt.sh

# PATH=$PATH:/usr/local/share/npm/bin # brew install node
# PATH=$PATH:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin # subl --help
export PATH

export CLICOLOR=1
export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

# customize the colors in terminal preferences to your liking
# export TERM='xterm-256color'
export COLOR_NC='\[\033[0m\]' # No Color
export COLOR_BLACK='\[\033[0;30m\]'
export COLOR_BRIGHT_BLACK='\[\033[1;30m\]'
export COLOR_RED='\[\033[0;31m\]'
export COLOR_BRIGHT_RED='\[\033[1;31m\]'
export COLOR_GREEN='\[\033[0;32m\]'
export COLOR_BRIGHT_GREEN='\[\033[1;32m\]'
export COLOR_YELLOW='\[\033[1;33m\]'
export COLOR_BRIGHT_YELLOW='\[\033[1;33m\]'
export COLOR_BLUE='\[\033[0;34m\]'
export COLOR_BRIGHT_BLUE='\[\033[1;34m\]'
export COLOR_PURPLE='\[\033[0;35m\]'
export COLOR_BRIGHT_PURPLE='\033[1;35m\]'
export COLOR_CYAN='\[\033[0;36m\]'
export COLOR_BRIGHT_CYAN='\[\033[1;36m\]'
export COLOR_WHITE='\[\033[0;37m\]'
export COLOR_BRIGHT_WHITE='\[\033[1;37m\]'
alias list_colors="set | egrep '^COLOR_\\w*'"  # lists all the colors & values from above

# call this function from prompt then customize your terminal colors how you like in the terminal/preference/settings
# colors will change so you can see what they look like in the terminal
display_colors (){
	echo -e "\033[0mCOLOR_NC (No color)"
	echo -e "\033[0;30mCOLOR_BLACK\t\033[1;30mCOLOR_BRIGHT_BLACK"
	echo -e "\033[0;31mCOLOR_RED\t\033[1;31mCOLOR_BRIGHT_RED"
	echo -e "\033[0;32mCOLOR_GREEN\t\033[1;32mCOLOR_BRIGHT_GREEN"
	echo -e "\033[0;33mCOLOR_YELLOW\t\033[1;33mCOLOR_BRIGHT_YELLOW"
	echo -e "\033[0;34mCOLOR_BLUE\t\033[1;34mCOLOR_BRIGHT_BLUE"
	echo -e "\033[0;35mCOLOR_PURPLE\t\033[1;35mCOLOR_BRIGHT_PURPLE"
	echo -e "\033[0;36mCOLOR_CYAN\t\033[1;36mCOLOR_BRIGHT_CYAN"
	echo -e "\033[0;37mCOLOR_WHITE\t\033[1;37mCOLOR_BRIGHT_WHITE"
}

# rvm prompt
PS1="${COLOR_BRIGHT_BLACK}[${COLOR_NC}${COLOR_BRIGHT_PURPLE}rvm > \$(~/.rvm/bin/rvm-prompt)${COLOR_NC}${COLOR_BRIGHT_BLACK}]\n"

# git prompt
PS1="$PS1[${COLOR_NC}${COLOR_CYAN}git > \W\$(__git_ps1 \"(%s)\")${COLOR_NC}${COLOR_BRIGHT_BLACK}]\n"

# current working directory prompt
PS1="$PS1[${COLOR_NC}${COLOR_GREEN}pwd > \w${COLOR_NC}${COLOR_BRIGHT_BLACK}]\n[${COLOR_NC}${COLOR_RED}\T${COLOR_NC}${COLOR_BRIGHT_BLACK}] > ${COLOR_NC}"
export PS1

# prompt for continuing commands
PS2="${COLOR_BRIGHT_BLACK} > ${COLOR_NC}"
export PS2

# These two require identify be installed, part of ImageMagick. Install the imagemagick package for your system first.
# Pass the filename of an image and the first will provide a range of information while the second will just provide the resolution:
alias imginfo="identify -format '-- %f -- \nType: %m\nSize: %b bytes\nResolution: %wpx x %hpx\nColors: %k'"
alias imgres="identify -format '%f: %wpx x %hpx\n'"

alias ls='ls -Glas'
alias ll='ls -Ghlas'
alias ..='cd ..'
alias ...='cd .. ; cd ..'
alias g='grep -i'  #case insensitive grep
alias f='find . -iname'
alias ducks='du -cks * | sort -rn|head -11' # Lists the size of all the folders and files
alias top='top -o cpu'
alias systail='tail -f /var/log/system.log'

# allows you to save bookmarks to folders
#  cd ~/src/git
#  save git
#  cd ~/src/git/killer/rails/awesome/app
#  save awesome_app
# list your bookmarks
#  show
#   git="~/src/git"
#   awesome_app="~/src/git/killer/rails/awesome/app"
# easily cd into the bookmarks from any directory
#  cd git
#  cd awesome_app
if [ ! -f ~/.dirs ]; then  # if doesn't exist, create it
	touch ~/.dirs
fi

alias show='cat ~/.dirs'
save (){
	command sed "/!$/d" ~/.dirs > ~/.dirs1; mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs;
}
source ~/.dirs  # Initialization for the above 'save' facility: source the .sdirs file
shopt -s cdable_vars # set the bash option so that no '$' is required when using the above facility

# bash shell useful settings
export HISTCONTROL=ignoredups # Ignores dupes in the history
shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns

# bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on" # note: bind is used instead of setting these in .inputrc.  This ignores case in bash completion
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# shows the commands you use most, it's useful to show you what you should create aliases for
alias profileme="history | awk '{print $2}' | awk 'BEGIN{FS=\"|\"}{print $1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# Turn on git tab completion if the file exists
if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
	. $(brew --prefix)/etc/bash_completion.d/git-completion.bash
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -r "$HOME/.rvm/scripts/completion" ]] && . "$HOME/.rvm/scripts/completion"

# make sure nothing is being loaded again that's already loaded above
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [ -f ~/.profile ]; then
   source ~/.profile
fi
