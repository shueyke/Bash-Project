# Bash-Project

#About the script:
The script is designed to allow users to manage file permissions and change owners if desired. It uses bash so to run it would require a Linux machine or the ability to use the sudo command as it is necessary to be able to change ownership. This script is useful as it will allow users to manage a file or several file permissions. It can also be used to change ownership of a file. 

#What You Will Need:
You should not need anything besides the script and an environment to run bash commands such as visual studio code which you should be able to aquire from https://code.visualstudio.com/docs/?dv=win64user. 
You will also need to download git to your system to be able to use bash commands which can be downloaded from https://git-scm.com/downloads/win
Also, ensure your system can use sudo commands, to enable sudo on a Windows machine:
https://learn.microsoft.com/en-us/windows/sudo/

#How It Works:
First, ensure the file "file_manager.sh" has execute permissions, if it does not you will get an error saying permission denied.
One way to give it execute permissions would be to run the command "chmod 775 file_manager.sh"
  -you should be able to do it without sudo but if there are issues you can run it with the sudo command
Usage of the script:
 "./file_manager.sh [options] -f file/directory"

For options you need to have either -p or -o
note that they currently can not be run together, the script will run but the first option is the only one that is executed
if you have many files that you want to have the same permissions you can use the -p option followed by the desired numeric options then list the files putting a space between them such as:
   "./file_manager -p 744 test.txt test2.txt test3.txt"
The script will check if the file exists if it does it will perform the inputted changes, if it does not it will error out saying the file does not exist.

The -o option requires the input as user:group, however currently it will not catch if the user or group exists.
It will prompt the user with the display usage if it is not input correctly.
If the user/group do not exist the script will run, tell the user the desired user or group is invalid and echo the ls -l file.
