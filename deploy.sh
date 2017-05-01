function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

function deploy {
	git clone --bare -b master https://github.com/sleiner/dotfiles.git $HOME/.cfg

	config checkout
	if [ $? = 0 ];
		then
	    	echo "Checked out config.";
	    else
	  	    echo "There seems to be a problem!"
	        echo "Trying to backup pre-existing dot files.";
	        mkdir -p .cfg-backup
	        config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .cfg-backup/{}
	fi;

	config checkout
	if [ $? = 0 ];
		then
		    echo "Now the configuration was successfully checked out - Have fun! :-)";

		    config config status.showUntrackedFiles no
		    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
		else
			echo "Seems like we can not solve this problem right now :/"
    fi;
}

deploy
