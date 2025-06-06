#!/bin/bash
#
# Sets up symlinks for dotfiles.

# Asks a yes/no question
function ask {
  local question="$1"
  read -p "$question? (y/N) "
  local yn=$(echo "$REPLY" | tr "A-Z" "a-z")
  test "$yn" == 'y' -o "$yn" == 'yes'
}

# Symlinks a file
function symlink {
  local from=$1
  local from_p="$(pwd)/$from"
  local to=$2
  local to_p="$HOME/$to"

  if [ ! -e "$from_p" ]; then
    printf "Error: $from_p does not exist\n"
    return 1
  fi

  if [ ! -e "$to_p" ]; then
    printf "Linking: ~/$to -> $from\n"
    ln -s "$from_p" "$to_p"
  else
    local to_l=$(readlink "$to_p")
    if [ "$?" == 0 -a \( "$to_l" == "$from_p" \) ]; then
      printf "Link exists: ~/$to -> $from\n"
    else
      printf "File exists: $to\n"
      if ask "Overwrite"; then
        rm -f "$to_p"
        symlink "$from" "$to"
      fi
    fi
  fi
}

# Symlinks a file as dotfile
function symlink_dot {
  symlink "$1" ".$1"
}

# Dotfiles to symlink
symlink_dot "bashrc"
symlink_dot "bash_profile"
source ~/.bash_profile
symlink_dot "inputrc"
symlink_dot "vimrc"
symlink_dot "ideavimrc"
symlink_dot "gitconfig"
symlink_dot "tmux.conf"
tmux source-file ~/.tmux.conf

touch ~/.ssh/authorized_keys && cat id_rsa.pub >> ~/.ssh/authorized_keys

# zsh
apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"  # assume zsh
ln -s cobalt2.zsh-theme ~/.oh-my-zsh/themes/
sed -i 's/robbyrussell/cobalt2/g' ~/.zshrc
echo -e "source ~/.bash_profile" >> ~/.zshrc
echo 'Install cobalt2 manually https://github.com/wesbos/Cobalt2-iterm'

# python scripts
# pip install --upgrade pip
# pip install -r requirements.txt

# antigen
curl -L git.io/antigen > antigen.zsh
echo -e "source $(pwd)/antigen.zsh" >> ~/.zshrc
echo -e "antigen bundle zsh-users/zsh-completions" >> ~/.zshrc
echo -e "antigen bundle zsh-users/zsh-syntax-highlighting" >> ~/.zshrc
echo -e "antigen bundle zsh-users/zsh-autosuggestions" >> ~/.zshrc
echo -e "antigen apply" >> ~/.zshrc

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Download Cursor"
echo "Download Alfred"
echo "Download Rectangle"
echo "Download Snipaste"
echo "Reverse Trackpad"
echo "Change modifier keys"
