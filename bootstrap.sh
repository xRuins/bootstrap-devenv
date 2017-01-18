
exec $SHELL -l

REPO_DOTFILES_URL="ssh://git@github.com/xRuins/dotfiles.git"
REPO_EMACS_URL="ssh://git@github.com/xRuins/.emacs.d.git"

REPO_DOTFILES_DEST="$HOME/dotfiles"
REPO_EMACS_DEST="$HOME/.emacs.d"

# install Homebrew if not done yet
if [ !-x brew ]; then
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
exec $SHELL -l # reload shell for certainty

# batch fomula install with Homebrew-file
echo "Installing Homebrew-file..."
cd `dirname $0`
brew install rcmdnk/file/brew-file

echo "Installing essential fomulas from Brewfile..."
HOMEBREW_BREWFILE="`dirname $0`/Brewfile" brew file install

# dotfile
echo "Fetching dotfiles..."
git clone $REPO_DOTFILES_URL $REPO_DOTFILES_DEST
echo "Executing init script of dotfiles..."
sh $REPO_DOTFILES_DEST/setup.sh

# .emacs.d
echo "Fetching .emacs.d..."
git clone $REPO_EMACS_URL $REPO_EMACS_DEST

# rbenv
echo "Installing rbenv..."
git clone ssh://git@github.com/sstephenson/rbenv.git $HOME/.rbenv
git clone ssh://git@github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build

# pyenv
echo "Installing pyenv..."
git clone ssh://git@github.com/yyuu/pyenv.git

# chsh
echo "Changing default shell to zsh. your password may be required."
chsh -s `which zsh`

echo "Finished."
