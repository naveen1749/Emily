# Emily

REQUIREMENTS :
  1) termux
  2) termux-api ( without api some commands doesn't work properly)

Installation :

1) download termux app
2) open the app and type following commands

apt update && apt upgrade && pkg install git && git clone https://github.com/naveen1749/Emily/

3) after successfully installation you see one folder with the name EMILY get in to that folder with following command

cd Emily

4) in that folder you can see 3 files firstly you can install requirements.txt using following command

Chmod 777 requirements.txt
./requirements.txt

5) after successfully installation.  Run the main code with following command

bash Emily.sh


Add on your bashrc file to start automatically:

1) open termux app type following commands:

cd
nano ~/.bashrc

2) its now open a editor page.  copy below text and paste it on your termux app. 

cd Emily
bash Emily.sh

3) After successfully pasthing save the file pressing CTRL+X and say 'Y' for confirming.

4) from now your terminal opens emily directly. 
