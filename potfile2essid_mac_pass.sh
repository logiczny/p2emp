#!/bin/bash

white='\e[97m'
purple='\e[35m'
cyan='\e[36m'
noColor='\e[39m'

if [ $# -eq 2 ]; then
    cat $1 | while read line 
    do
        hash_n_pass_cracked=$(echo $line | sed  's/^.*\*//')
        hash_cracked=$(echo $hash_n_pass_cracked | sed 's/:.*//')
        pass_cracked=$(echo $hash_n_pass_cracked | sed 's/^.*://')
        dumped_line=$(grep $hash_cracked $2 | head -n1)

        if [ -n "$dumped_line" ]; then
            mac_of_cracked_AP=$(echo $dumped_line | sed  's/^WPA\*..\*[abcdef01234567890]*\*[abcdef01234567890]*\*//' | sed 's/\*.*//')
            whoismac -p $dumped_line | sed 's/VENDOR.*//' | sed 's/MAC_STA.*//' | sed '/^[[:space:]]*$/d'
            printf "Pass   : ${cyan}$pass_cracked${noColor}\n"
            printf "${white}---${noColor}\n"
        fi
    done
else
    printf "Usage:\n${white}$0${noColor} ${purple}hashcat.potfile${noColor} ${cyan}hash.hc22000${noColor}\n\n"
fi
