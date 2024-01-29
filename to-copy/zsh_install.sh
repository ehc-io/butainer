apt-get update -y
echo 'Installing zsh'
touch ~/.zshrc
echo 'Installing ohmyzsh'
sudo apt-get install -y zsh language-pack-en
sudo update-locale
export CHSH='no' # means the installer will not change the default shell (default: yes)
export RUNZSH='no' # means the installer will not run zsh after the install (default: yes)
# export KEEP_ZSHRC='yes' # means the installer will not replace an existing .zshrc (default: no)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo 'Cloning some plugins'
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
apt-get install -y autojump
curl -s https://gist.githubusercontent.com/ehc-io/52a3549eb17dda934925149b9048f566/raw/ac4ab8a96dd65a50506293c200de29533ff1b1bb/zshrc -o $HOME/.zshrc