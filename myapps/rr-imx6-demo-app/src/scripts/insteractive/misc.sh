#!/bin/sh
#
#RidgeRun Copyright 2013
#
#Author: Edison Fernandez  <edison.fernandez@ridgerun.com>
#
#Summary: Miscellaneous functions


#-------------------------------------------------------
#Sumary: control tools states
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
control_tools_states()
{
    case $1 in
		"Tools")
		Tools
		;;
    
		"List_Pipelines")
	    List_available_Pipelines
	    ;;
    
		"Start_Pipeline")
	    Start_Pipeline
	    ;;
    
        "Stop_Piepeline")
	    Stop_Piepeline
	    ;;
	    
	    "CPU_LOAD")
	    CPU_LOAD
	    ;;
	    
        *)
            return 1
            ;;
    esac

    return 0
}


#-------------------------------------------------------
#Sumary: Tools state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
Tools()
{
    OPTS="exit main_menu.back List_Pipelines Start_Pipeline Stop_Piepeline CPU_LOAD"
    
    print_blanks
    log_success "Tools"
    print_blanks

    go_to_state "$OPTS"
    
}

#-------------------------------------------------------
#Sumary: List available pipelines state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
List_available_Pipelines()
{
	#List current pipelines
	list_pipelines
	
	TO_STATE="Tools"
}

#-------------------------------------------------------
#Sumary: Start Pipeline state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
Start_Pipeline()
{
	#List current pipelines
	list_pipelines

	#Ask for pipeline number
	prompt_input "Enter pipeline number (0-$((PIPE_COUNTER-1)))"
	
	#Start the selected pipeline
	gst-client play -p $USER
	
	TO_STATE="Tools"
}

#-------------------------------------------------------
#Sumary: Stop pipeline state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
Stop_Piepeline()
{
	#List current pipelines
	list_pipelines

	#Ask for pipeline number
	prompt_input "Enter pipeline number (0-$((PIPE_COUNTER-1)))"
	
	#Start the selected pipeline
	gst-client null -p $USER
	
	TO_STATE="Tools"
}

#-------------------------------------------------------
#Sumary: COU LOAD state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
CPU_LOAD()
{
	#Show CPU load
	top
	
	TO_STATE="Tools"
}
