#!/bin/sh
#
#RidgeRun Copyright 2012
#
#Author: Melissa Montero <melissa.montero@ridgerun.com>
#Author: Michael Grüner  <michael.gruner@ridgerun.com>
#
#Summary: Helper functions

#Global variables
AUTOMATIC=0
BOLD='\033[1m'
RED='\033[91m'
GREEN='\033[92m'
YELLOW='\033[93m'
BLUE='\033[94m'
ENDC='\033[0m'

#Summary: Prints a message
#
#Parameter 1: Message type, it can be INFO or DEBUG
#Parameter 2: Message to print
log()
{
    case $1 in
	DEBUG)
	    echo -e "$BLUE $TEST: $2 $ENDC"
	    ;;
	INFO)
	    echo -e "$BOLD $TEST:$ENDC $2"
	    ;;
    esac
}

#Summary: Asks the user to press any key to continue
#
#Parameter 1: Message to print before pressing a key
user_activity()
{
    log INFO "$1"
    log INFO "Press any key to continue..."
    read
}

#Summary: Print a message on screen indicating an error
#
#Parameter 1: Message to print
log_error()
{
    echo -e "$RED $TEST: $1 $ENDC"
}

#Summary: Print a message on screen indicating success
#
#Parameter 1: Message to print
log_success()
{
    echo -e "$GREEN $TEST: $1 $ENDC"
}

#Summary: Returns 0 if the user presses 'Enter' or -1 if the user
#presses 'n'
#
#No parameters
prompt_success()
{
    log INFO "Press 'Y' if true or 'n' if false"
    read correct

    case $correct in
	"Y")
	    return 0
	    ;;
	"n")
	    return 1
	    ;;
	*)
	    log INFO "Invalid option"
	    prompt_success
	    ;;
    esac
}


#Summmry: Ask the operator about a condition being met , if it's met
#return 0, else print a message and return 1
#
#Parameter 1: Message to prompt to the user
#Parameter 2: Error message
operator_query()
{
    if [ $AUTOMATIC -eq 1 ]; then
	return 0;
    fi

    log INFO "$1"
    prompt_success
    
    
    if [ $? -eq 1 ]; then
	if [ ! -z "$2" ]; then
	    log_error "$2"
	fi
	return 1
    fi
}

#Summary: Asks for a user answer
#
#No parameters
prompt_answer()
{
    log INFO "Press 'Y' for yes or 'n' no"
    read correct

    case $correct in
	"Y")
	    return 0
	    ;;
	"n")
	    return 1
	    ;;
	*)
	    log INFO "Invalid option"
	    prompt_answer
	    ;;
    esac
}

#Summary: Asks for a user input
#
#Parameter 1: User prompt
#
#Returns answser in USER
prompt_input()
{
    USER=""
    log INFO "$1"
    read correct
    if [ -z $correct ]; then
	log INFO "Invalid input"
	prompt_input $1
    else
        USER=$correct
    fi
}

#Summmry: Ask the operator for instruction, returns 0 
#         if the answer is yes, 1 otherwise
#
#Parameter 1: Message to prompt to the user
#Parameter 1: Message to print if answer is no
operator_exec()
{
    if [ $AUTOMATIC -eq 1 ]; then
	return 0
    fi

    log INFO "$1"

    prompt_answer

    if [ $? -eq 1 ]; then
	if [ ! -z "$2" ]; then
	    log_error "$2"
	fi
	return 1
    fi
}

#Summary: Indicates the beginning of a new test
#
#No parameters
test_start()
{
    log INFO "test start"
}

#Summary: Prints some blank spaces. Used between different tests
#
#No parameters
print_blanks()
{
    echo -e "\n"
}

#Summary: Indicates a test failed
#
#No parameters
test_fail()
{
    log_error "test failed"
}

#Summary: Indicates a test succeeded
#
#No parameters
test_success()
{
    log_success "test finished succesfully"
}

#Summary: Ask the user if the test must be repeated
#
#No parameters
repeat_query()
{
    operator_query "Do you want to repeat the test?"
    return $?
}
