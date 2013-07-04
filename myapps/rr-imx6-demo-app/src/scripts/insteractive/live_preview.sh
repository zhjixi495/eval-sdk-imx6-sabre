#!/bin/sh
#
#RidgeRun Copyright 2013
#
#Author: Edison Fernandez  <edison.fernandez@ridgerun.com>
#
#Summary: Live preview


#Summary: State parser for video_test
#
#$1 The state to be parsed
#
#Returns 0 if the state was found, 1 otherwise

video_test_states()
{
    case $1 in
		"Video_Test")
	    live_preview
	    ;;
    
        "camera_loopback")
	    camera_loopback
	    ;;
	    
	    "select_camera")
	    select_camera "camera_loopback" "select_display"
	    ;;
	    
	    "select_display")
	    select_display "select_camera" "select_overlay"
	    ;;
	    
	    "select_overlay")
	    select_overlay "select_display" "preview"
	    ;;
	    
	    "preview")
	    preview 
	    ;;
        
		"video_preview")
	    video_preview
	    ;;

		"video_test_pattern")
	    video_test_pattern "Video_Test" "select_pattern"
	    ;;
	    
	    "select_pattern")
	    select_pattern "select_display"
	    ;;
	    
        *)
            return 1
            ;;
    esac

    return 0
}


#-------------------------------------------------------
#Sumary: live preview state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
live_preview()
{
    OPTS="exit main_menu.back camera_loopback video_preview video_test_pattern"
    
    print_blanks
    log_success "Video Test"
    print_blanks

    go_to_state "$OPTS"
    
    PREV_SRC="$TO_STATE"
    
}

#-------------------------------------------------------
#Sumary: camera loopback state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
camera_loopback()
{
	OPTS="exit Video_Test.back select_camera"
    
    print_blanks
    log_success "Camera Loopback"
    print_blanks

    go_to_state "$OPTS"
}


#-------------------------------------------------------
#Sumary: video preview state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
video_preview()
{
	OPTS="exit main_menu.back video_1080p video_720p video_480p"
    
    print_blanks
    log_success "Video Preview"
    print_blanks

    go_to_state "$OPTS"
    
    if [ $TO_STATE != "exit" -a $TO_STATE != "main_menu" ]; then
		case $TO_STATE in 
			"video_1080p")
				video_src=$preview_1080p_video
			;;
			
			"video_720p")
				video_src=$preview_720p_video
			;;
			
			"video_480p")
				video_src=$preview_480p_video
			;;
		esac
		TO_STATE="select_display"
    fi
}


#-------------------------------------------------------
#Sumary: Preview state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
preview ()
{
	basic_preview 
	TO_STATE="main_menu"
}
