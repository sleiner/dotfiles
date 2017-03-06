function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

function deploy {
	git clone --bare -b master https://github.com/sleiner/dotfiles.git $HOME/.cfg
	config checkout
	if [ $? = 0 ]; then
	  echo "Checked out config.";
	  else
	    echo "Backing up pre-existing dot files.";
	    mkdir -p .cfg-backup
	    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
	fi;
	config checkout
	config config status.showUntrackedFiles no
	alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
}

deploy