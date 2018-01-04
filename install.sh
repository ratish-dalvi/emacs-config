echo "Copying emacs and emacs.d files..."

read -p 'Enter your python installation path (eg. /home/ubuntu/miniconda/): ' PATH_DIR

destination="$HOME/.emacs"
cmd="cp emacs-config $HOME/.emacs"

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

destination="$HOME/.emacs.d"
cmd="cp -r emacs.d $HOME/.emacs.d"

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
echo "Adding pychecker to PATH"
cp pychecker.sh $PATH_DIR/pychecker.sh 
sudo chmod 744 $PATH_DIR/pychecker.sh 

# Install dependencies
echo "Installing pyflakes: "
conda install pyflakes -y

echo "Adding environment variable to bashrc"
echo 'export PYTHON_PATH_FOR_EMACS='$PATH_DIR >> ~/.bashrc 

echo
echo "Installation finished successfully"!
