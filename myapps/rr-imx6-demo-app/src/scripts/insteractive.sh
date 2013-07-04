#!/bin/sh

#gst-client create "mfw_v4lsrc ! mfw_v4lsink" 
#gst-client play -p 0 
#sleep 10
#gst-client null -p 0

#
#RidgeRun Copyright 2013
#
#Author: Edison Fernandez  <edison.fernandez@ridgerun.com>
#
#Summary: Finite State Machine for Interactive demo 

source /opt/scripts/core/helper_functions.sh
source /opt/scripts/core/basic.sh
source /opt/scripts/pipes.sh
source /opt/scripts/insteractive/live_preview.sh
source /opt/scripts/insteractive/misc.sh
source /opt/scripts/insteractive/streaming.sh
source /opt/scripts/insteractive/snapshot.sh

fsm()
{
    while [ 0 ]
    do
        case $TO_STATE in
            
            "main_menu")
                main_menu
                ;;

	    "exit")
		log_success "Closing interactive demo"
		#Destroy all pipelines
		gst-client destroy-all
		break
		;;
	    
	    *)
             
                video_test_states $TO_STATE
                if [ $? == 0 ];
                then
                    continue
                fi

                control_tools_states $TO_STATE
                if [ $? == 0 ];
                then
                    continue
                fi

                Video_Streaming_states $TO_STATE
                if [ $? == 0 ];
                then
                    continue
                fi

                snapshot_states $TO_STATE
                if [ $? == 0 ];
                then
                    continue
                fi

		unknown
        esac
    done
}

#Summary: State that warns user of unknown state. In good theory you should never get here
#
#No Parameters
unknown()
{
    print_blanks
    log_error "Unknown state, reseting state machine"
    print_blanks

    TO_STATE="main_menu"
}


#Summary: Prints main menu
#
#No Parameters
main_menu()
{

    export TEST="Main Menu"
    print_blanks
    log_success "iMX6 Demo APP"
    print_blanks

    go_to_state "exit $OPTIONS"
}

#Summary: Prints a list of options. If an option has a dot then it will only print the text after the dot
#
#$1: Space separated list of options
print_options()
{
    num=0
    for op in $1;
    do
	# For cosmetic purposes print only everyting after the dot
	op=$(echo $op | sed 's:.*\.::')
        log INFO "\t$num) $op"
        num=$(($num+1))
    done
}

#Summary: Computes the index of the last element. The first element starts on 0
#
#$1: Space separated list of options
#Returns: The index of the last element will be stored in $LAST
compute_last()
{
    LAST=0

    for n in $1;
    do
        LAST=$(($LAST+1))
    done
    
    # Make the indexes start from 0
    LAST=$((LAST-1))
}

#Summary: Validates that an option is inside the possibilities
#
#$1: Option
#$2: Maximum possible value
#
#Returns: 0 if the option is valid, 1 otherwise
validate_option()
{
    if [ $1 -gt $2 ];
    then
        return 1
    fi

    if [ $1 -lt 0 ];
    then
        return 1
    fi    
    return 0
}


#Summary: Grabs an option from a user and returns it of OP
#
#$1 : Space separated list of posible options
#
#Returns the selected option in $OP
pick_option()
{
    log INFO "What do you want to do?"
    print_options "$1"
    print_blanks

    # Get the user option on USER
    prompt_input "> "

    # Get the last elements index on LAST
    compute_last "$1"

    validate_option $USER $LAST
    if [ $? != "0" ];
    then
        log_error "Invalid option"
        return 1
    fi

    for state in $1;
    do
        if [ $USER -eq 0 ];
        then
	    # Take the text before the dot (if any) as state
	    state=$(echo $state | sed 's:\..*::')
            OP=$state
            return 0
        fi
        USER=$(($USER-1))
    done
   
    # Invalid situation
    log_error "Malformed state machine"
    return 1
}

#Summary: Validates and parses input to states. If the option has a
#dot, then te text before the dot will be used as state. If it does
#not contain a dot, then the option will be taken as the state
#
#$1 : Space separated list of posible options
go_to_state()
{
    #Store in OP users choice
    pick_option "$1"
    if [ $? == 1 ];
    then
        return 1
    fi

    #Point the state machine to the next state
    TO_STATE=$OP
}

#Start point
OPTIONS=\
"Video_Test "\
"Video_Streaming_server "\
"Video_Streaming_client "\
"Snapshot "\
"Tools " 

TO_STATE="main_menu"
fsm
