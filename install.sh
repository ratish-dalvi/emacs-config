echo "Copying emacs and emacs.d files..."

HOME_DIR=/home/ratish
PATH_DIR=/home/ratish/wiseio/anaconda/bin/ # This could be any directory in path


destination="$HOME_DIR/.emacs"
cmd="cp emacs-config $HOME_DIR/.emacs"

if [ -f $destination ];
then
    read -r -p "File $destination exists. Do you want to replace it?: " response
    case $response in
        [yY][eE][sS]|[yY])
                eval $cmd
                ;;
        *)
            echo "Exiting..."
            exit
            ;;
    esac
else
    eval $cmd
fi

destination="$HOME_DIR/.emacs.d"
cmd="cp -r emacs.d $HOME_DIR/.emacs.d"

if [ -d $destination ];
then
    read -r -p "Directory $destination exists. Do you want to replace it?: " response
    case $response in
        [yY][eE][sS]|[yY])
                sudo rm -r ~/.emacs.d
                eval $cmd
                ;;
        *)
            echo "Exiting..."
            exit
            ;;
    esac
else
    eval $cmd
fi

echo
echo "Adding pychecker to path"
cp pychecker.sh $PATH_DIR/pychecker.sh 
sudo chmod 744 $PATH_DIR/pychecker.sh 

echo
echo "Installation done successfully"!
