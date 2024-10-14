# Bash-Project

#About the script:
The script allows users to manage file permissions and change owners if desired. It uses bash, so to run it, you would require a Linux machine or the ability to use the sudo command, which is necessary to change ownership. This script is useful as it will allow users to manage a file or several file permissions and change ownership of a file. This is useful because there are several commands the user would need to input to achieve the same results. 

#What You Will Need:
You should not need anything besides the script and an environment to run bash commands such as visual studio code which you should be able to aquire from https://code.visualstudio.com/docs/?dv=win64user. 
You will also need to download git to your system to be able to use bash commands which can be downloaded from https://git-scm.com/downloads/win
Also, ensure your system can use sudo commands, to enable sudo on a Windows machine:
https://learn.microsoft.com/en-us/windows/sudo/. There are no necessary files but you could create a blank test file or use an existing file on your system to use the script.

#How It Works:
First, ensure the file "file_manager.sh" has execute permissions, if it does not you will get an error saying permission denied.
One way to give it execute permissions would be to run the command "chmod 775 file_manager.sh". You should be able to do it without sudo but if there are issues you can run it with the sudo command

Usage of the script:
"./file_manager.sh [options] -f file/directory"

For options, you need to have either -p or -o
They currently can be run together but if the user does not own or is not part of a group that has ownership of a file, the permissions will not change. EX. "./file_manger.sh -o guest1:guest1 -p 775 -f test.txt", if the user is not guest1 or belongs to the group guest1, the script will change the ownership but will not change the permissions of the file because the user no longer has access; however, if the user ran "sudo ./file_manger.sh -o guest1:guest1 -p 775 -f test.txt, the ownership and permissions would be altered accordingly. In this case, it would change ownership to the user guest1 and the group guest1 and give rwx permissions to the owner/user and to the group and would give rx permissions to everyone.

if you have many files that you want to have the same permissions you can use the -p option followed by the desired numeric options then list the files putting a space between them such as:
   "./file_manager -p 744 test.txt test2.txt test3.txt"
The script will check if the file exists if it does it will perform the inputted changes, if it does not it will error out saying the file does not exist.

The—o option requires input as user:group; however, currently, it will not catch whether the user or group exists.
It will prompt the user with the display usage if it is not input correctly.
If the user/group does not exist the script will run, tell the user the desired user or group is invalid, and echo the ls -l file.

When you are inputting the options it is important to make sure you include -f otherwise it will make the changes to an empty string, in other words, it would say it made changes but no changes would be made to the specified file(s).
