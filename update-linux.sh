# Display the warning at the beginning

echo "
**** This is untested, and it may not work ****

Linux is only supported by the Strobe Programming Language.
Currently only Ubuntu running with Mono is supported."

# Uncomment this lines if you want to run the wine check.

#program="wine"
#condition=$(which $program 2>/dev/null | grep -v "not found" | wc -l)
#if [ $condition -eq 0 ] ; then
#	echo "
#Follow this steps to install Wine and Mono:
#
#1. Remove the (Ubuntu) wine package (if it is installed):
#sudo apt-get remove --purge wine
#
#2. Add the wine PPA to the package repositories:
#sudo add-apt-repository ppa:ubuntu-wine/ppa
#sudo apt-get update
#
#3. Install the wine and wine-mono packages from the PPA (adjust to newer version numbers if necessary):
#sudo apt-get install wine1.7 wine-mono4.5.4
#
#4. Install the mono package from the default PPA:
#sudo apt-get install mono-complete
#"
#    read -n1 -r -p "Press any key to exit..." key
#	exit
#fi

# Check for git
program="git"
condition=$(which $program 2>/dev/null | grep -v "not found" | wc -l)
if [ $condition -eq 0 ] ; then
	echo "
Please run the following command to install git:
sudo apt-get install git
"
    read -n1 -r -p "Press any key to exit..." key
	exit
fi

# Check for mono
program="mono"
condition=$(which $program 2>/dev/null | grep -v "not found" | wc -l)
if [ $condition -eq 0 ] ; then
	echo "
Please run the following command to install mono:
sudo apt-get install mono-complete
"
    read -n1 -r -p "Press any key to exit..." key
	exit
fi

# Update the current repo
git pull

# Update the other repos
git submodule update --init --recursive

# Go to the strobe source
cd strobe/src

# Build using mono
xbuild

clear
echo "
Please check the \"/os/strobe/src/strdbg\" folder.
"

# Pause and exit
read -n1 -r -p "
Press any key to continue..." key
exit 