#!/bin/bash

alert(){
     #id declare in 588 line
     msgs=$(termux-notification-list | grep title | wc -l )
     
     while [[ true ]]
     do
          if [[ $(termux-notification-list | grep title | wc -l ) -ge 1 ]]; then
               
               if [[ $said -le 0 ]]; then
               termux-tts-speak " sir. you have a message from "
               i=1
               count=$(termux-notification-list | grep title | wc -l)
                    while [[ $i -le $count ]]
                    do
          
                         sender=$(termux-notification-list | grep title | awk '{if(NR=='$i') print $2 ,$3, $4, $5}') 
               
                         echo "------------------------------"
                         echo "|  Message From :   $sender  |"
                         echo "------------------------------"
                         termux-tts-speak $sender
                         if [[ $i -lt $count ]]; then
                              termux-tts-speak "and."
                         fi
                         
                         if [[ $i == $count ]]; then
                              let "said=said+1"
                              
                              break
                            
                         fi
                         
                         let "i=i+1"
                    done
                fi
                
                if [[ $(termux-notification-list | grep title | wc -l ) == 0 ]]; then
                    let "said=said-1"
                fi
         fi
     done  
     
}

          
rem(){
     
     cd /data/data/com.termux/files/usr/etc/Emily/remembers  
     echo --------------------------------------------
     echo "  Date      :        Remind topic"
     echo --------------------------------------------
     i=1
      while [[ $i -le $(ls | wc -l) ]]
      do 
           file=$(ls | awk '{if(NR=='$i') print $0}')
           echo "  $file   :      $(cat $file)  "
           echo  ------------------------------------------
           let "i=i+1"
           let "count=count+1"

      done

   cd ->/dev/null                                                 
     }
check_it_when_u_complete(){
    line 311 "coninue" working or not
    line 315 "continue" working or not
    line 353 "insert detalis correctly"
    14-7-2020
    # add update links line no 346
    check php  at one time
    enter apache and more sites code
    add mail service 

}
pass_count=1;
pass_limit=3;
limit_show=3;
visit_count_for_username=0;
visit_count_for_password=0;
visit_count_for_sdcard_name=0;
fingerprint_setup=0;
# setting up password 
show_usage(){
    echo 
    echo "   Emily assistent for termux friendly interface & wrok faster "
    echo " commands             tip"
    echo   
    echo " usage   =>    display this help menu"
    echo " lock    =>   lock your terminal ( when you have don't set any password its ask to set password first ) "
    echo " mem2    =>   Go to your external memory (sdcard) directly"
    echo " mem1    =>   Go to internal memory (emulated) directly"
    echo " goto    =>   go to your destination folder "
    echo " reset   =>   to reset your terminal"
    echo " clr     =>   clear terminal"
    echo " msf5    =>   install METASPLOIT FRAMEWORK "
    echo " d       =>   go to any folders directly from your current working directory
                            Ex : d { directory name }
                        NOTE : if you have external memory please give name of the card. while you don't give the name folders cannot be displayed!
                            [ type 'mem2_name' to give name"
    echo " update  =>   update Emily"
    echo " restart =>   restart your terminal"
    echo " open    =>   open a file or a url from ecternal app  " #modifications required
    echo " yt      =>   download youtube videos 
                            Ex : yt [url] "
    echo " mem2_name  => save your external memory name "

    #api commands
    echo " c       =>   search contacts
                            Ex : c { contact name }"
    echo " figset  =>   set fingerprint lock to your terminal"
    echo " call    =>   call from your terminal directly [ type' call -h'   to view help menu"
    echo " msg     =>   send a message  [ type 'msg -h' to view help menu ] "  

    #servers
    echo " servers =>    see available local servers and start it."
    echo " apache  =>   start apache server "
    echo " tphp    =>   start php server"
    
    #upcomming progress
    echo " update  =>      "
    echo " servers"
    echo " mailto  =>    send to mails"
    echo " remember=>    add a remember it's remind you in a perticular date"
    echo " reminds =>    it show's remembers"
    echo " dlt remember => delete a completed reminder"
    echo " add netcat service  "
    
    echo " add notes"
    echo " feedback service"


                          
}
#fingerprint setup
fingerprint_function(){
                    while [ $(command -v termux-fingerprint) ]
                    do  
                        echo -n " do you want to enable fingerprint [ Y/n ] : "
                        read fingerprint
                            if [[ $fingerprint == y || $fingerprint == Y ]]; then
                                if [[ $(termux-fingerprint | grep auth_result | awk $1 '{print $2}') ==  '"AUTH_RESULT_SUCCESS"' ]]; then
                                    echo " fingerprint added."
                                    sleep 1
                                    let "fingerprint_setup+=1"
                                    home1_banner
                                elif [[ $(termux-fingerprint | grep auth_result | awk $1 '{print $2}') == '"AUTH_RESULT_FAILURE"' ]]; then
                                    echo " attempt failes = { $(termux-fingerprint | grep auth_result | awk $1 '{print $2}') } "
                                    echo " sorry we cann't reconige your fingerprints. "
                                    echo " clean your fingerprint sensor and try again some other time"
                                    home1_banner
                                elif [[ $(termux-fingerprint | grep auth_result | awk $1 '{print $2}') == '"AUTH_RESULT_UNKNOWN"' && $here_count -le 3 ]]; then
                                    echo " sorry we cann't reconige your fingerprints. try again after some time"
                                    home1_banner
                                fi
                            else 
                                home1_banner
                                break
                            fi
                    done
                    }
#sdcard name
sdcard(){
while [ $(cd /storage && ls | wc -l) != 2 ]
do
    if [[ $visit_count_for_sdcard_name == 0 ]]; then
        echo "enter your sdcard name to access files directly  " 
        cd /storage/ && ls
        echo -n " enter your sdcard name : "
        read sdcard_name
        if [[ -d $sdcard_name && $sdcard_name != self ]]; then
            let "visit_count_for_sdcrad_name+=1"
            home1_menu
        elif [[ $sdcard_name == self ]]; then
            echo " we are sorry that's not avalid name please try again"
            continue                                             
        else
            echo "enter a valid name"                      
            continue
        fi
    else
        home1_menu
    fi
done

        }
#password setup
set_password(){
if [ $visit_count_for_password == 0 ]; then
    echo "     set your terminal password"  
    echo -n "  enter your password : "  
    read -s password 
    echo 
    echo -n "  confirm your password : "  
    read -s password2
            if [ $password == $password2 ]; then
                 echo "password : $password" >> .owner.txt
                 printf "\n"
                echo
                echo "      password set succesfully "  
                let "visit_count_for_password+=1"
                sleep 02
                home1_banner
            elif [  $password != $password2 ]; then
                echo 
                echo " password do not match please try again "  
                set_password
            else 
                home1_banner
            
            fi
else 
    echo 
    echo "     password already setup by our commander"  
    home1_banner
fi
         }
# for guests 
home2_menu(){
    echo "  not complete"
}
# creating guest and asking datails
create_guest(){
      echo "   WARNIG! guest mode doesn't supprot all feauchers  "  
      echo
                echo -n " To explore in guest i need some details abou you are ready for give information [y/n] :  "  
                read  option 
                    if [[ $option == y || $option == Y ]]; then
                        echo
                        echo " there are just few questions please be answer correctly "  
                        name(){
                        echo
                        echo " 1:- whats your good name "  
                        echo -n "Ans :-  "  
                        
                        read  name
                        check_name=$(cat .users.txt | grep -o $name)
                            if [ $name == ""]; then
                                echo "  enter a valiad name"  
                                name
                            elif [ $check_name == $name ]; then 
                                clear 
                                echo 
                                echo
                                echo
                                echo
                                echo  "           already user exits "  
                                echo
                                home2_banner
                            else
                                 echo $name >> .users.txt
                            fi
                            }
                        name
            opinian(){
                        echo
                        echo -n " 2:- say something about my commander { $owner_name} "  
                        read option
                            if [ $option == "" ]; then
                                 echo "     please say something about $owner_name"
                                 opinian
                            else
                                  echo
                                  echo $opinian >> .opinian.txt
                        
                                  echo "   Thank you for your valluable information "  
                                  sleep 02
                            fi
                    }
                        opinian
                        home2_banner
                    else 
                    # when user doesn't provide her details
                        clear 
                        echo 
                        echo 
                        echo
                        figlet locked  
                        echo
                        echo "    terminal locked! wait for a minute or ask password to our commander => $owner_name "
                        sleep 60
                        login
                    fi
                    
}
# creating password for first time and login and moving wrong passwords into files and guest creation request [y/n]
login(){
if [ $visit_count_for_password == 1 ]; then 
   if [ $pass_count -le $pass_limit ]; then
      echo -n " password : "  
      read -s  Enter_password
      printf "\n"
        if [ $Enter_password == $password ]; then
             home1_banner
        else 
            let "pass_count+=1"
            let "limit_show-=1"
            echo "  wrong password! Remaing chances $limit_show"  
            moving_entered_password=4
            moving_entered_password2=3
            if [[ $pass_count ==  $moving_entered_password || $pass_count ==  $moving_entered_password2 ]]; then
                echo $Enter_password >> .entered_password.txt
            fi
        fi
        
    else
        echo  -n "      out of chances! iam sorry i think your are not our commander. are  you intrest to explore in guest mode [y/n] : "  
        read option 
            if [[ $option == y || $option == Y ]]; then
                create_guest
            else
                echo " terminal locked! wait for a minute"
               sleep 60
                login
               
            fi  
                    
                
    fi
    
else
    set_password
fi
}
#fingerprint login
fingerprint_login(){
if [[ $fingerprint_setup == 1 ]]; then
    if [[ $(termux-fingerprint | grep auth_result | awk $1 '{print $2}') ==  '"AUTH_RESULT_SUCCESS"'  ]]; then
        home1_banner
    else
        login
    fi
else
    login
fi
}
# lock screen banner and calling set-password when password unset
lock_screen_banner(){
if [ $visit_count_for_password == 1 ]; then
    clear
    echo
    echo
    echo
    figlet "      Locked"  
    echo
    echo "              Author :- ðŸ˜Ž NAVEEN YADAV ðŸ˜Ž"  
    echo
    echo "          Mobile number :- +917780721677"  
    echo
    echo "          Gmail :-"  
    echo
    echo "   Hi Iam ðŸ¤– Emily ðŸ¤– please enter the password to verify to me if your our commander or not!":  
    echo
    if [[ $fingerprint_setup == 1 ]]; then
        fingerprint_login
    fi
    login

else 
    echo 
    echo " you don't have set any passord!"  
    echo
    echo -n "  are you want to set passsword [y/n ] "  
    read option
        if [[ $option == y || $option == Y ]]; then
            set_password
            
        elif [[ $option == n || $option == N ]]; then
            echo "     your not set any password. that means your terminal will me vurnable "
            sleep 02
            home1_banner
        else 
            echo "     your not set any password. that means your terminal will me vurnable "
            sleep 02
            home1_banner
        fi
fi
}

# owner home screen
home1_banner(){
    clear
    echo
    echo
    figlet "       Emily "  
    echo
    echo "         welcome $owner_name"   
    echo
    echo   "        how can i help you ? "  
   if [[ ! -d /data/data/com.termux/files/usr/etc/Emily ]]; then
         cd /data/data/com.termux/files/usr/etc
         mkdir Emily
         cd Emily
  
         cd ->/dev/null
   fi 
   if [ ! -d /data/data/com.termux/files/usr/etc/Emily/remembers ]; then
     cd /data/data/com.termux/files/usr/etc/Emily
     mkdir remembers
     cd ->/dev/null
   fi
   if [[ $(date +%H) -ge 1 && $(date +%H) -le 12 ]]; then
      termux-tts-speak "good morning sir!, i hope to working great today."
        if [[ $(date +%H) -ge 01 && $(date +%H) -le 9 ]]; then
          weather_report(){ 
                              cd /data/data/com.termux/files/usr/etc/Emily
                              curl wttr.in > weather.txt # >/dev/null
                              report=$(cat weather.txt | awk '{if(NR==3) print $5}')
                              degrees=$(cat weather.txt | awk '{if(NR==4) print $5 $6 $7 }')
                              weather=$(cat weather.txt | awk '{if(NR==3) print $4 $5 $6 }')
                              echo " status: $weather"
                              echo " celcius: $degrees"
                              #echo " status : $weather"
                              termux-tts-speak " sir! today weather $weather. and $degrees celcious in your area "
                                if [[ $report == rain ]];then
            
                                  termux-tts-speak "sir. please.
                                  carry raincoat. when you goes out side. because rainy weather in your  area."
                                fi 
                              }
                                weather_report
        fi
        if [[ $(cd /data/data/com.termux/files/usr/etc/Emily/remembers && ls | grep `date +%b%d%y`) ]]; then
          cd /data/data/com.termux/files/usr/etc/Emily/remembers
          cat `date +%b%d%y`
          termux-tts-speak " sir. $(cat `date +%b%d%y`)"
          cd ->/dev/null
          home1_menu
        fi 
    
    elif [[ $(date +%H) -ge 12 && $(date +%H) -le 17 ]]; then
      termux-tts-speak " good afternoon sir!. "
      termux-tts-speak "sir. how can i help you ."
      home1_menu
    elif [[ $(date +%H) -ge 17 && $(date +%H) -le 19 ]]; then
      termux-tts-speak " good evening sir. have a beautifull evening today."
      termux-tts-speak  " sir. how can i help  you "
      home1_menu
    elif [[ $(date +%H) -ge 19 && $(date +%H) -le 24 ]]; then
      termux-tts-speak " sir. it's time to sleep get sleep down as soon as possible"
      termux-tts-speak "sir. how can you help "
      home1_menu
      
    fi
    if [[ $(cd /data/data/com.termux/files/usr/etc/Emily/remembers && ls | grep `date +%b%d%y`) ]]; then
          termux-tts-speak " sir. $(cat `date +%b%d%y`)"
          cat `date +%b%d%y`
    fi 
              
    sdcard
    home1_menu
             }
termux_command(){
    $menu
    home1_menu
}
Emily_menu(){ 
    case $(echo "$menu" | awk '{print $1'}) in
         "lock" | "Lock" | "LOCK" ) lock_screen_banner ;;
         "whats your name" ) show_usage 
                                   termux-tts-speak "here's my limited operations" ;;
         d | D ) cmd=$menu
                 menu=$(echo $cmd | awk '{print $2}')
                    if [[ -d /sdcard/$menu || -d /storage/$sdcard_name/$menu ]] || [[ -d /data/data/com.termux/files/$foldername || -d /data/data/com.termux/files/home/$foldername ]]; then
                        while [ -d /sdcard/$menu ]
                        do
                            cd /sdcard/$menu
                            ls
                            home1_menu
                            break
                        done
                        while [ -d /data/data/com.termux/files/$foldername ]
                        do
                            cd /data/data/com.termux/files/$foldername
                            ls
                            home1_menu
                            break
                        done
                        while [ -d /data/data/com.termux/files/home/$foldername ]
                        do
                            cd /data/data/com.termux/files/home/$foldername
                            ls
                            home1_menu
                            break
                        done
           
                        while [ -d /storage/$sdcard_name/$menu ]
                        do
                            cd /storage/$sdcard_name/$menu
                            ls
                            home1_menu
                            break
                            done
                            home1_menu
                    elif [ -d /data/data/com.termux/files/usr/$foldername ]; then
                        while [ -d /data/data/com.termux/files/usr/$foldername ]
                        do
                            cd /data/data/com.termux/files/usr/$foldername
                            ls
                            home1_menu
                            break
                        done
                    else 
                        echo " can't find any directory. please check directory name"
                        home1_menu
                    fi ;;
         [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] ) echo " calling to $menu " && termux-telephony-call $menu 
                                     home1_menu ;;
         c | C ) cmd=$menu
                    contact_name=$(echo $cmd | awk '{print $2}')
                    if [ $(termux-contact-list | grep -i -A1 $contact_name) ]; then
                        $(termux-contact-list | grep -i -A1 $contact_name)
                        home1_menu
                    else
                        echo " contact not foound check the name"
                        home1_menu
                    fi;;

          usage | "Help me" | "HELP ME") show_usage  && home1_menu;;
         "open" | "OPEN" | "Open" ) ls ; echo -n "wich file to open : " ; read file ; pwd=$(realpath $file);action=android.intent.action.VIEW ; am broadcast --user 0 -a $action -n com.termux/com.termux.app.TermuxOpenReceiver $chooser --ez chooser true -d "$pwd" > /dev/null
                                    home1_menu ;;
         msg | message ) cmd=$menu
                         msg_usage(){
                            echo 
                            echo " NOTE : these function need termux api please intsall. either it's shows error!."
                            echo "msg [ options ] [ number or contact name ] { message }"
                            echo " optons : "
                            echo "      -n      =>      message to a specific numbers
                                                            Ex : msg -n [ number ] { message }"
                            echo "      -c      =>      message to a specfic contact from oyur contacts
                                                            Ex : msg -c [conatct name ] { message }
                                                            NOTE : contact name must be available in your contacts please check it."
                            echo "      -s      =>      serach conatcs and send message 
                                                            Ex msg -s [ contact name ]"
                            echo "      -h      =>      display this help menu"
                         }
                        while [ $(command -v termux-sms-send) ]
                        do
                            format=$(echo $cmd | awk '{print $2}')
                            number_or_name=$(echo $cmd | awk '{print $3}')
                            message_content=$(echo $cmd | awk '{print $4}')
                             case $format in
                                    -n ) if [[ $number_or_name != "" && $message_content != "" ]]; then
                                            echo " sending sms to $number_or_name."
                                            termux-sms-send -n $number_or_name $message_content
                                            home1_menu
                                        else 
                                            echo " enter valid number or message content may be null please check it and try again "
                                            home1_menu
                                        fi ;;
                                    -c ) echo " searhcing contact. "
                                        contacts_count=$(termux-contact-list | grep -i -A1 $number_or_name | wc -l )
                                         if [ $contacts_count -le 3 ]; then
                                            contact_number=$(termux-contact-list | grep -i -A1 $number_or_name | grep '"number": "*"' | awk $1 '{print $2}' )
                                            termux-sms-send -n $contact_number "$message_content"
                                            home1_menu
                                         else
                                            $(termux-contact-list | grep -i -A1 $number_or_name)
                                            echo -n " enter mobile number : "
                                            read num
                                            echo " sending message to $num"
                                            termux-sms-send -n $num " $message_content "
                                            home1_menu
                                         fi ;;
                                    -s ) echo " searching contacts."
                                         $(termuxcontact-list | grep -i A1 $number_or_name)
                                         echo -n " enter number to send message : "
                                         read num 
                                         echo " enter your message " 
                                         echo -n "# "
                                         read message
                                         $(termux-sms-send -n $num " $message" )
                                         home1_menu ;;
                                    -h ) msg_usage ;;   
                            esac       
                        done
                        echo " termux-api is not instaled. please install termux-api and try again"
                        home1_menu ;;
         alarm ) if [ ! -d /data/data/com.termux/files/usr/etc/Emily/alarms ]; then 
                             cd /data/data/com.termux/files/usr/etc/Emily
                             mkdir alarms
                             cd ->/dev/null
                        fi
                        
                        cd /data/data/com.termux/files/usr/etc/Emily/alarms
                        echo -n " Alarm Name # "
                        read name 
                        echo -n  " Alarm Time [HM] # "
                        read time
                        echo $name > $time
                        echo  " alarm Saved. Time= $time "
                        cd ->/dev/null
                        home1_menu ;;
         alarms | "show alarms" | "saved alarms" ) cd /data/data/com.termux/files/usr/etc/Emily/alarms
                                                ls 
                                                cat *
                                    
                                                cd ->/dev/null
                                                home1_menu;;
        
                       
         sdcard | "external memory" | mem2 ) cd /storage;termux-setup-storage ;            while [ $(ls | wc -l) != 2 ]
                                                                                           do
                                                                                             if [ $visit_count_for_sdcard_name == 0 ]; then
                                                                                                 cd /storage/
                                                                                                 ls
                                                                                                 echo -n " enter your sdcard name : "
                                                                                                 read sdcard_name
                                                                                                      if [[ -d $sdcard_name && $sdcard_name != self ]]; then
                                                                                                         cd $sdcard_name
                                                                                                         let "visit_count_for_sdcrad_name+=1"
                                                                                                         home1_menu
                                                                                                      elif [ $sdcard_name == self ]; then
                                                                                                        echo " we are sorry that's not avalid name please try again"
                                                                                                        home1_menu
                                                                                                      else 
                                                                                                        echo "enter a valid name"
                                                                                                        home1_menu
                                                                                                      fi
                                                                                             else 
                                                                                                 cd $sdcard_name 
                                                                                                 home1_menu
                                                                                             fi
                                                                                             home1_menu
                                                                                             break
                                                                                           done 
                                                                                           echo " sorry you don't have any external memory please insert sdcrad and try againg "  
                                                                                           home1_menu ;;
                                                                         start* ) id=2
                                                                                  let "i=i+1" ;;
                                                                         stop* ) id=1 ;;
         mem1 | "internal memory" | emulated) termux-setup-storage
                                              cd /sdcard
                                              ls
                                              home1_menu ;;
         msf5 | "install msf" | "Install msf5" | "Install msf")   echo " installing METASPLOIT-FRAMEWORK " 
                                                                            echo " please be patient! "
                                                                            apt-get update && upgrade && pkg install x11-repo && pkg install metasploit > dev/null 2>&1 
                                                                                if [ $(command -v msfconsole) ]; then
                                                                                   echo " installation sucess type msf5 to start FRAMEWORK"
                                                                                   home1_menu
                                                                                else 
                                                                                    echo " installation failed!"
                                                                                    echo " please try again"
                                                                                    home1_menu
                                                                                fi ;;
                                                                      remi* | remind* | reminders | "any future plans* ") 
                                                                            cd /data/data/com.termux/files/usr/etc/Emily/remembers 
                                                                             rem
                                                                             home1_menu;;
                                                       
         remem* | remember* | Remember* | REMEM* ) cmd=$menu
                                                note=$(echo $cmd | awk '{print $2}')
                                                date1=$(echo $cmd | awk '{print $3}')
                                                cd /data/data/com.termux/files/usr/etc/Emily/remembers
                                                if [[ ! $date1 && ! $note ]]; then
                                                    echo -n " what's the remember note." && termux-tts-speak "sir. what's the remember note."
                                                    read note
                                                    echo -n " when i remember to you [Oct1020]  " && termux-tts-speak " sir. when i remember to you. please enter the date using following format "
                                                    while [ true ]
                                                    do 
                                                        read date1
                                                           if [[ $(echo $date1 | wc -m) == 8 ]]; then
                                                                  break
                                                         fi
                                                        echo -n " when i remember to you [Oct1020]  " && termux-tts-speak " sir. the format is invalid. please try again. "

                                                    done
                                                   
                                                      echo $note > $date1
                                                      home1_menu
                                                fi ;;
                                       dlt  | "dlt remind" | "delete remind" | "delete remem")
                                             
                                             rem
                                             sleep 02
                                             cd /data/data/com.termux/files/usr/etc/Emily/remembers  
                                             echo
                                             echo -n " which one sir # "
                                             read option
                                             name=$(ls | awk '{if(NR=='$option') print $0}')
                                             rm -rf $name 
                                             cd ->/dev/null
                                             home1_menu                                                                 ;;
                                             
         goto | GOTO | Goto) cmd=$menu
                              foldername=$(echo $cmd | awk '{print $2}')
                                while [ -d /sdcard/$foldername ]
                                do
                                   cd /sdcard/$foldername
                                   ls 
                                   home1_menu
                                   break
                                done 
                                cd /storage/
                                while [ $(ls | wc -l) != 2 ]
                                do 
                                if [ $visit_count_for_sdcard_name == 0 ]; then
                                    cd /storage/
                                    ls
                                    echo " please enter your external memory name :  "
                                    read sdcard_name
                                        if [[ -d $sdcard_name && $sdcard_name != self ]]; then
                                            cd $sdcard_name/$foldername
                                            ls
                                            let "visit_count_for sdcard_name+=1"
                                            home1_menu
                                        elif [ $sdcard_name == self ]; then
                                            echo "  we can sorry that not your external memory name please try again "
                                            continue
                                        else
                                            echo " enter a valid name"
                                            continue
                                        fi 
                                else
                                    while [ -d /storage/$sdcard_name/$foldername ]
                                    do
                                        cd /storage/$sdcard_name/$foldername
                                        ls
                                        home1_menu
                                        break
                                    done 

                                    while [-d /storage/emulated/$foldername ]
                                    do 
                                        cd /storage/emulated/$foldername
                                        ls
                                        home1_menu
                                        break
                                    done
                                    home1_menu
                                fi 
                                echo " can't find any folders with this name $foldername"
                                home2_menu
                                done ;;
         reset ) let "visit_count_for_username-=1"
                 let "visit_count_for_password-=1"
                 bash n.sh ;;
         restart | clr ) clear
                         home1_banner ;;
         update ) #enter the site details WHEN you publish the code
                # while [ $(command -v )]
                echo " not completed"
                home1_menu;; 
         figset) fingerprint_function ;;
         call | CALL ) cmd=$menu
                call_usage(){
                    echo
                    echo " NOTE : these function need termux api please intsall. either it's shows error!."
                    echo " call [ option ] [ number or contact name ]"
                    echo " options : "
                    echo "      -n      =>      call to a specific phone number"
                    echo "                         Ex : call -n { phone number }"
                    echo "      -c      =>      call to a specific contact from your contacts "
                    echo "                         Ex : call -c { contact name }"
                    echo "      -h      =>      show this help menu "
                    echo "      -s      =>      serach contacts"
                    echo "                         Ex : call -s { contact name }"
                    echo "                      you can also use "
                    home1_menu
                }
                while [ $(command -v termux-telephony-call ) ]
                do
                    number_or_name=$(echo $cmd | awk '{print $3}')
                    format=$(echo $cmd | awk '{print $2}')
                     case $format in
                        -n ) echo " calling to $number_or_name."
                             termux-telephony-call $number_or_name
                             home1_menu ;;
                        -c ) echo " searching contact."
                             contacts_count=$(termux-contact-list | grep -i -A1 $number_or_name | wc -l )
                             if [ $contacts_count -le 3 ]; then
                                contact_number=$(termux-contact-list | grep -i -A1 $number_or_name | grep '"number": ".*"' | awk $1 '{print $2}')
                                termux-telephony-call $contact_number
                                home1_menu 
                            else
                                nums=$(termux-contact-list | grep -i -A1 $number_or_name )
                                $(termux-contact-list | grep -i -A1 $number_or_name )
                                echo -n " enter mobile number : "
                                read num
                                echo " calling $num"
                                termux-telephony-call $num
                                home1_menu
                            fi ;;
                        -s ) echo " searching contact."
                             $(termux-contact-list | grep -i -A1 $number_or_name )
                             home1_menu ;;
                        -h ) call_usage ;;
                    esac
                        echo " something error please read this instructions and try again"
                        call_usage
                        home1_menu
                done
                echo " iam soory. termux-api is not installed please install termux-api and try again"
                home1_menu ;;
         tphp | TPHP ) run_php(){
                                 if [ $(command -v php) ]; then
                                   
                                      checkphp=$(netstat -plnt | grep php )
                                      adress=$(netstat -plnt | grep php | awk '{print $4}')
                                      status=$(netstat -plnt | grep php | awk '{ print $5}')
                                            if [[ $checkphp == *'php'* && $adress != "" ]]; then
                                                echo " php server already runing "
                                                echo " adress  : $adress"
                                                echo " status  : running"
                                                echo -n " are you want to kill it [ Y/n] : "
                                                read choice
                                                    if [[ $choice == y || $choice == Y ]]; then
                                                        pkill  php > /dev/null 2>&1 &
                                                        run_php
                                                    else
                                                        echo " adress  : $adress"
                                                        echo " status  : running"
                                                        home1_menu
                                                    fi
                                            else 
                                                default_ip=127.0.0.1
                                                echo -n "enter ip adress (default ip : $default_ip) : "
                                                read ip
                                                ip1="${ip:-${default_ip}}"
                                                default_port=1234
                                                echo -n "enter port (default port : $default_port) : "
                                                read port
                                                port1="${port:-${default_port}}"
                                                echo " location = /storage/emulated/Emily/index.php "  
                                                echo " starting php server.... "  
                                                cd  /storage/emulated/0/Emily
                                                
                                                 php -S "$ip1:$port1" > /dev/null 2>&1 &
                                                 sleep 02
                                                    check_server=$(netstat -plnt | grep $ip1)
                                                        if [[ $check_server == *'php'* || $adress != "" ]]; then 

                                                            echo " php server started "
                                                            echo " address :- $ip1:$port1"
                                                            echo " adress :- /storage/emulated/0/Emily/index.php"
                                                            home1_menu
                                                        else 
                                                            echo " somehting went wrong! please tey again "
                                                            home1_menu
                                                        fi
                                                home1_menu
                                            fi
                                 else
                                        echo " we are sorry php is not installed on your device "  
                                        echo -n " Are you want to install it [ y/n ] : "  
                                        read choice
                                            if [[ $choice == y || $choice == Y  ]]; then
                                                clear
                                                echo " installing..." 
                                                apt-get update -y && apt-get upgrade -y && pkg install php -y > /dev/null 2>&1
                                                    while [ $(command -v php) ] #use if statement when "while not working"
                                                    do 
                                                        echo " php installed succesfully "
                                                        echo " Now starting server"
                                                        php
                                                        home1_menu
                                                        break
                                                    done 
                                                    echo "installation error! please try again after some time "
                                                    home1_menu
                                            else
                                                home1_menu
                                            fi
                                 fi 
                            }
                    run_php
                    home1_menu ;;
         apache | APACHE ) run_apache(){
                                        if [ -f /data/data/com.termux/files/usr/bin/apachectl ]; then
                                                check_apache=$(netstat -plnt | grep httpd )
                                                adress=$(netstat -plnt | grep httpd | awk $1 '{print $4}')
                                                    if [[ $check_apache == *'httpd'* && $adress == "0.0.0.0:8080" ]]; then
                                                        echo " apache server already running"
                                                        echo " adress  : $adress"
                                                        echo " status  : running"
                                                        echo -n " are you want to kill it [ Y/n] : "
                                                        read choice
                                                            if [[ $choice == y || $choice == Y ]]; then
                                                                pkill  httpd 
                                                                sleep 02
                                                                run_apache
                                                            else
                                                                echo " adress  : $adress"
                                                                echo " status  : running"
                                                                echo " locaion : /data/data/com.termux/files/usr/etc/apache2"
                                                                home1_menu
                                                            fi
                                                    else
                                                        apachectl start 
                                                        echo "starting apache.."
                                                        sleep 02
                                                        check_apache=$(netstat -plnt | grep httpd )
                                                        adress=$(netstat -plnt | grep httpd | awk $1 '{print $4}')
                                                        status=$(netstat -plnt | grep httpd | awk $1 '{print $5}')
                                                            if [[ $check_apache == *'httpd'* && $adress == "0.0.0.0:8080" ]]; then
                                                                    echo " apache server started"
                                                                    echo " adress   : $adress "
                                                                    echo " status   : running"
                                                                    echo " location : /data/data/com.termux/files/usr/etc/apache2"
                                                                    home1_menu
                                                            else 
                                                                echo " failed! please try again"
                                                                home1_menu
                                                            fi
                                                    fi
                                        else
                                                echo " apache is not installed on your device "
                                                echo -n " do you want to install it [Y/n] : "
                                                read option
                                                    if [[ $option == y || $option == Y ]]; then
                                                        echo " installing apache.."
                                                        pkg install apache2 -y 
                                                            if [ -f /data/data/com.termux/files/usr/bin/apachectl ]; then 
                                                                cd /data/data/com.termux/files/usr/etc/apache2
                                                                cp httpd.config /data/data/com.termux/files/usr/etc/apache2/httpd1.config
                                                                rm httpd.config
                                                                sed 's/Listen 8080/Listen 0.0.0.0:8080/g' httpd1.config >> httpd.config 
                                                                rm httpd1.config
                                                                echo " installation success."
                                                                home1_menu
                                                            else
                                                                echo "installation failed! "
                                                                echo " please try again"
                                                                home1_menu
                                                            fi
                                                    else
                                                        home1_menu
                                                    fi 
                                        fi 

                                 }
                                 run_apache
                                 home1_menu ;;
         servers) echo "    please choose server type "
                  echo " 1 :- php "  
                  echo " 2 :- apache "  
                  echo " 3 :- ftp "  
                  echo " 4 :- add more"  
                  echo -n "   enter your option : "  
                    read option 
                    case $option in 
                        1 | php )
                                    run_php 
                                    home1_menu ;;
                        2 | apache )   run_apache ;;
                        #more data
                        esac 
                        home1_menu ;;
         yt | YT ) if [ ! -d /sdcard/Emily/downloads ]; then
                        cd /sdcard/Emily
                        mkdir downloads
                        cd -
                    fi         
                 run_yt_total(){
                    cmd=$menu
                   url=$(echo $cmd | awk '{print $2}')
                   if [ ! $url ]; then
                        echo " please provide a url "
                        read url
                    fi
                
                    if [ $( command -v youtube-dl) ];then
                        echo " which format do you want to download "
                        echo "      video resolutions"
                        #echo " 1 :- 144p"#code 160,278
                        #echo " 2 :- 240p "#code 242,133
                        echo " 1  :-  360p" #code 243,134,18
                        #echo " 4 :- 480p"#code 135,244
                        echo " 2  :-  720p" #code  22,247,302,136,298
                        #echo " 6 :- 1080p"#code 137,248
                        echo "       audio formats"
                        echo " 3  :-  m4a"
                        echo " 4  :-  mp3"

                        run_yt(){
                            echo -n  " choose option # " 
                            read option 
                            case $option in 
                                4 | mp3 | MP3 ) echo " downloading.."
                                                sleep 02
                                                cd /sdcard/Emily/downloads

                                                youtube-dl --extract-audio --audio-format mp3 $url 
                                                
                                                echo " download complete."
                                                echo " path :- $pwd"
                                                cd - >/dev/null
                                                home1_menu
                                                ;;
                                3 | m4a |M4A ) echo " downloading.."
                                                sleep 02
                                                cd /sdcard/Emily/downloads
                                                youtube-dl -x $url
                                                
                                                echo " download complete."
                                                echo " path :- $pwd"
                                                cd - >/dev/null
                                                home1_menu ;;
                                1 | 360p | 360P )   if [[ $(youtube-dl --list-formats $url | grep 18) ]]; then
                                                        echo "downloading.."
                                                        cd /sdcard/Emily
                                                        youtube-dl -f 18 $url
                                                        
                                                        echo " download complete."
                                                        echo " path :- $pwd"
                                                        cd - >/dev/null
                                                        home1_menu
                                                        break
                                                    else
                                                        echo " this video doesn't supprot with 360p resolution. try another one"
                                                        run_yt 
                                                    fi;;
                                2 | 720p | 720P )   if [[ $(youtube-dl --list-formats $url | grep 22) ]]; then
                                                        echo "downloading.."
                                                        cd /sdcard/Emily/downloads
                                                        youtube-dl -f 22 $url
                                                        echo " download complete."
                                                        echo " path :- $pwd"
                                                        cd - >/dev/null
                                                        home1_menu
                                                        break
                                                    else
                                                        echo " this video doesn't supprot with 360p resolution. try another one"
                                                        run_yt
                                                    fi ;;
                        esac
                        echo " invalid option! Try again. "
                        run_yt

                        }
                        run_yt


                    else 
                        echo -n "i need some resources at the first time. Do you want to install it [ Y/n ] : "
                        read option
                        if [[ $option == y || $option == Y ]]; then
                            clear
                            echo " installing.."
                            apt-get update && upgrade
                            pkg install ffmpeg -y
                            pkg install curl
                            curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /data/data/com.termux/files/usr/bin/youtube-dl
                            chmod a+rx /data/data/com.termux/files/usr/bin/youtube-dl
                                if [ -f /data/data/com.termux/files/usr/bin/youtube-dl ]; then
                                    echo " installation success."
                                    run_yt_total
                                else
                                    echo " installtion error! try again"
                                    home1_menu
                                fi
                        else 
                            home1_menu
                        fi
                    fi  
         }
         run_yt_total   
          ;;
          #conversation tapics,
           say* ) cmd=$menu
                  stage_one=$(echo $cmd | awk '{print $2}')
                  termux-tts-speak $stage_one ;;
          sing* ) cd /sdcard/MIUI/shareme
                   echo  "  playing..."
                  play "RayBan Vara Chasma Range Rovar Car _ Rona ni pade Entry _ Geeta rabari _ New Song_C_o4CCVlwEE.mp3" >/dev/null 2>&1 ;;
         
         Do  ) cmd=$menu
                stage_one=$(echo $cmd | awk '{print $2}')
                case $stage_one in 
                      you*) cmd=$menu 
                            stage_two=$(echo $cmd | awk '{print $3}')
                                case $stage_two in
                                       have*) cmd=$menu
                                              stage_three=$(echo $cmd | awk '{print $4}')
                                                 case $stage_three in 
                                                        girl*) echo "  hey. am a girl. "
                                                               echo "   hahaha..."
                                                               home1_menu;;
                                                        boy* ) echo "  iam happy to say. i don't have a boy friend.  "
                                                        termux-tts-speak "iam happy to say. i don't have a boy friend.  "
                                                        home1_;;
                                                 esac;;


                                 esac;;
                
                
                
                
                
                esac;;
         how* ) cmd=$menu
                stage_one=$(echo $cmd | awk '{print $2}')
                    case $stage_one in
                           old* ) echo " i was launched in 01/09/2020. "
                                  termux-tts-speak " i was launchedin 01/09/2020."
                                  home1_menu ;;
                            are* ) cmd=$menu
                                  stage_two=$(echo $cmd | awk '{print $3}')
                                    case $stage_two in 
                                            you* ) echo " Iam doing well. thaks for asking.  "
                                                   termux-tts-speak " Iam doing well. thaks for asking. " 
                                                   home1_menu ;;
                                       esac;;
                                                   
                     esac;;
                    
          who* | whos* ) cmd=$menu
                            stage_one=$(echo $cmd | awk '{print $2}')
                            case $stage_one in 
                                      is* ) cmd=$menu && stage_two=$(echo $cmd | awk '{print $3}')
                                             case $stage_two in 
                                                    your* ) cmd=$menu && stage_three=$(echo $cmd | awk '{print $4}')
                                                             case $stage_three in
                                                                    father* | dad* ) echo "  Naveen yadav "
                                                                    termux-tts-speak " Naveen is my lovely Father."
                                                                    home1_menu
                                                              esac ;;
                                              esac ;;
                                      the* ) cmd=$menu && stage_two=$(echo $cmd | awk '{print $3}')
                                             case $stage_two in 
                                                   found*) echo "  program author : Naveen Yadav"
                                                           echo "  mail : itsmechintus@gmail.com"
                                                           echo " copyright's : Reserved"
                                                           termux-tts-speak " Naveen Yadav created Me. he was the founder. and i say heartly thaks to he."
                                                           home1_menu ;;
                                              esac ;;
                            esac ;;
                            
          what* | whats* )  cmd=$menu
                            stage_one=$(echo $cmd | awk '{print $2}')
                            case $stage_one in 
                                   your* | is* | ur) cmd=$menu && stage_two=$(echo $cmd | awk '{print $3}')
                                                     case $stage_two in 
                                                            name* | nick* | "your name"  )
                                                                 echo "------------------------"
                                                                 echo "|      Emily              |"
                                                                 echo "------------------------"
                                                                 echo "|   version : 1.0           |"
                                                                 echo "------------------------"
                                                                 termux-tts-speak " Iam Emily. version 1.0."
                                                                 home1_menu;;                                                                                                dream* ) echo "    My dream is simple. want more user's . to access me."
                                                                    termux-tts-speak "My dream is simple. want more user's. to access me."
                                                                       home1_menu ;;

                                                            age*  ) function age_cal () { #echo -n "Enter                                                             your DOB [ddmmyyyy] : "
                                                       #read n
                                                            #d=`echo $n | cut -c1-2`
                                                       #m=`echo $n | cut -c3-4`
                                                       #y=`echo $n | cut -c5-8`
                                                               d=01
                                                                               m=09
                                                                               y=2020
                                                                               yy=`date "+%Y"`
                                                                               mm=`date "+%m"`
                                                                               dd=`date "+%d"`
                                                                                if [ $y -le $yy ]; then
                                                                                          yyy=`expr $yy - $y`
                                                                                          mmm=`expr $mm - $m`
                                                                                        #ddd=`expr $dd - $d`
                                                                                     if [ $m -gt $mm ];then
                                                                                         yyy=`expr $yyy - 1`
                                                                                        mmm=`expr $mmm + 12`
                                                                                     fi
                                                                                     if [ $d -gt $dd ];then
                                                                                        ddd=`expr $d - $dd`
                                                                                         ddd=`expr 31 - $ddd`
                                                                                     else
                                                                                           ddd=`expr $dd - $d`
                                                                                    fi 
                                                                                 fi
                                                                               echo " $yyy year, $mmm months, $ddd days "
                                                       termux-tts-speak "It¡¯s been $yyy years, $mmm months , $ddd days   since I was made"
     }
     age_cal
                                                       home1_menu ;;
                                                       * ) cmd=$menu
                                                            stage_three=$(echo $cmd | awk '{print $4}')
                                                            case $stage_three in 
                                                                 age* ) age_cal(){ #echo -n "Enter                                                             your DOB [ddmmyyyy] : "
                                                       #read n
                                                            #d=`echo $n | cut -c1-2`
                                                       #m=`echo $n | cut -c3-4`
                                                       #y=`echo $n | cut -c5-8`
                                                               d=01
                                                                               m=09
                                                                               y=2020
                                                                               yy=`date "+%Y"`
                                                                               mm=`date "+%m"`
                                                                               dd=`date "+%d"`
                                                                                if [ $y -le $yy ]; then
                                                                                          yyy=`expr $yy - $y`
                                                                                          mmm=`expr $mm - $m`
                                                                                        #ddd=`expr $dd - $d`
                                                                                     if [ $m -gt $mm ];then
                                                                                         yyy=`expr $yyy - 1`
                                                                                        mmm=`expr $mmm + 12`
                                                                                     fi
                                                                                     if [ $d -gt $dd ];then
                                                                                        ddd=`expr $d - $dd`
                                                                                         ddd=`expr 31 - $ddd`
                                                                                     else
                                                                                           ddd=`expr $dd - $d`
                                                                                    fi 
                                                                                 fi
                                                                               echo " $yyy year, $mmm months, $ddd days "
                                                       termux-tts-speak "It¡¯s been $yyy years, $mmm months , $ddd days   since I was made"
     }
     age_cal ;;
                                                       name )                                                                   echo "------------------------"
                                                                 echo "|      Emily,              |"
                                                                 echo "------------------------"
                                                                 echo "|   version : 1.0           |"
                                                                 echo "------------------------"
                                                                 termux-tts-speak " Iam Emily. version 1.0";;
                                                       on ) age_cal
                                                                 
                                                            esac ;;

                                               esac ;;
                            esac;;
                                               
         mem2_name | MEM2_NAME ) cd /storage 
                                 while [ $(ls | wc -l ) != 2 ]
                                 do
                                    cd /storage/ && ls
                                    echo -n " enter sdcard name  " && read name
                                    if [[ -d /storage/$name && $name != self ]]; then
                                        while [ $name != emulated ]
                                        do
                                         echo " sdcard name saved"
                                         $sdcard_name=$name
                                         let 'visit_count_for_sdcard_name+=1'
                                         cd -
                                         home1_menu

                                         break
                                        done
                                        echo " sorry that's not a sdcard name please try again"
                                        continue
                                    else
                                        echo " sorry that's not a sdcard name please try again"
                                        continue
                                    fi
                                 done 
                                 echo " you don't have any external memory"
                                 home1_menu ;;
          trans* | Translate* | E2t* ) cmd=$menu
                                      word=$(echo $cmd | awk '{print $2}')
                                      echo $word
                                      telugu_word=$(w3m https://www.google.com/search?q=$word+translate+in+telugu | awk '{if(NR==9) print $0}')
                                      echo -------------------------------------
                                      echo  $telugu_word
                                      echo -------------------------------------
                                      termux-tts-speak "          For that word. Meaning in telugu. $telugu_word  "
                                      home1_menu ;;
                                     
         notes | nt ) notes_usage(){
                        echo " save importent commands or any information with securly"
         } ;;
         hello | hi | Hi|  Hello | HELLO ) 
                                 termux-tts-speak " hello sir"
                                 if [[ $(date +%H) -ge 14 ]]; then 
                                    termux-tts-speak " sir. want to give today feedback."
                                    echo -n "# [ y/n/s ] " && read option 
                                        if [[ $option == Y || $option == y ]]; then
                                            
                                            echo -n " How feeling today =>  " && read feeling 
                                            cd /sdcard/Emily/
                                            while [[ $(cat secreat.txt | wc -l ) -ge 365 ]]
                                            do
                                                 rm secreat.txt
                                            done
                                            
                                            echo  " $(date) $feeling " >> secreat.txt
                                            cd ->//null
                                            home1_menu
                                        elif [[ $option == s || $option == S ]]; then
                                            cd /sdcard/Emily/
                                            cat secreat.txt 
                                            cd ->/dev/null  
                                        else 
                                           home1_menu
                                       fi
                                        home1_menu
                                 fi
         ;;
                                        
        
    esac
    echo " invalid! type 'usage' to see help menu"
    home1_menu
}

#while [[ $(termux-notification-list | grep title | wc -l ) == 0 ]]
#do
#   let "said=said-1"
   
#done &
 
#while [[ $said -le 0 ]]
#do
#   alert
   
#done &
 
        
home1_menu(){
    echo -n " Emily # "
    read menu 
        if [[ $( command -v $menu ) ]]; then 
            termux_command
        elif [[ $menu == "" ]]; then
            home1_menu
            # api commands
        else 
            Emily_menu
        fi
  
}
# asking user name for the first time and redirect to home1
first_time_visit(){
clear
    if [ $visit_count_for_username == 0 ]; then
        echo 
        echo
        figlet "       T H H"   
        echo
        echo "                Naveen  "
        echo
        echo "      hello commander iam ðŸ¤– Emily ðŸ¤– thanks for downloading to me. i need some details about you to start terminal"   && echo "hey! hi commander "   
      enter_valid_name(){
        echo 
        echo " what's your  name commander?"   && echo " enter your name "   
        echo
        echo -n " Ans :- "  
        read owner_name 
            if [[ $owner_name == "" ]]; then
                echo " enter a valid name!"   && echo " unvalid "   
                enter_valid_name
            else
                echo " congrats. one user added."   
                 echo "user_name : $owner_name" >> .owner.txt
                 mkdir -p /storage/emulated/0/Emily 
                 echo '        Telugu Hackers Hub' > /storage/emulated/0/Emily/index.php


            fi
                       }
        enter_valid_name
        echo
        let "visit_count_for_username+=1"
        echo -n " Are you want to set password for terminal [ y/n ] : "  
        read option
             if [[ $option == y || $option == Y ]]; then
                    set_password
             
              else
               
echo
echo " please set password to terminal for security perpose just type 'setpass' to complete the process "    && echo " Danger your terminal has been vulnerable "             
sleep 2
home1_banner
             
             fi
    elif [ $visit_count_for_username != 0 ]; then 
        home1_banner
    else 
        let "visit_count_for_username=0"    
        first_time_visit
    fi
    
}

#first_time_visit
home1_menu
