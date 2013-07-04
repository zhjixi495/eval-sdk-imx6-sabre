#!/bin/sh
#
#RidgeRun Copyright 2013
#
#Author: Edison Fernandez  <edison.fernandez@ridgerun.com>
#
#Summary: Snapchot functions


#-------------------------------------------------------
#Sumary: Snapshot states
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
snapshot_states()
{
    case $1 in
		"Snapshot")
	    Snapshot
	    ;;
		
		"select_camera_sn")
	    select_camera "from_camera" "capture"
	    ;;
	    
	    "capture")
	    capture
	    ;;
	    
        *)
            return 1
            ;;
    esac

    return 0
}

#-------------------------------------------------------
#Sumary: Snapshot state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
Snapshot()
{
	OPTS="exit main_menu.back select_camera_sn.select_camera"
    
    print_blanks
    log_success "Snapshot"
    print_blanks

    go_to_state "$OPTS"
}

#-------------------------------------------------------
#Sumary: Capture state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
capture()
{
	
	basic_capture
	TO_STATE="main_menu"
	
}
