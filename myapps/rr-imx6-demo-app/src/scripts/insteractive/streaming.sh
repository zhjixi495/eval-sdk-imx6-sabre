#!/bin/sh
#
#RidgeRun Copyright 2013
#
#Author: Edison Fernandez  <edison.fernandez@ridgerun.com>
#
#Summary: Video streaming functions


#-------------------------------------------------------
#Sumary: video streaming states
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
Video_Streaming_states()
{
    case $1 in
		"Video_Streaming_server")
	    Video_Streaming
	    ;;
	    
	    "Video_Streaming_client")
	    select_display "main_menu" "select_overlay_str"
	    ;;
	    
	    "select_overlay_str")
	    select_overlay "Video_Streaming_client" "stream_client"
		;;
		
		"stream_client")
		stream_client
		;;
		
		"from_camera")
	    from_camera
	    ;;
	    
	    "select_camera_s")
	    select_camera "from_camera" "stream"
	    ;;
	    
	    "from_file")
	    from_file
	    ;;
	    
	    "stream")
		stream
	    ;;

		"video_test_pattern_s")
	    video_test_pattern "Video_Streaming" "select_pattern_s"
	    ;;
	    
	    "select_pattern_s")
	    select_pattern "stream"
	    ;;
	    
        *)
            return 1
            ;;
    esac

    return 0
}


#-------------------------------------------------------
#Sumary: video streaming state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
Video_Streaming()
{
    OPTS="exit main_menu.back from_camera from_file video_test_pattern_s.video_test_pattern"
    
    print_blanks
    log_success "Video Stream"
    print_blanks

    go_to_state "$OPTS"
    
    PREV_SRC="$TO_STATE"
    
}

#-------------------------------------------------------
#Sumary: From camera state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
from_camera()
{
	OPTS="exit Video_Streaming.back select_camera_s.select_camera"
    
    print_blanks
    log_success "Camera Stream"
    print_blanks

    go_to_state "$OPTS"
}

#-------------------------------------------------------
#Sumary: From file state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
from_file()
{
	
	video_src=$preview_1080p_video
	TO_STATE="stream"
	
}

#-------------------------------------------------------
#Sumary: Stream state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
stream()
{
	basic_stream
	TO_STATE="main_menu"
}

#-------------------------------------------------------
#Sumary: Stream state
#-------------------------------------------------------
#Prerequirements: 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
stream_client()
{
	#Get board ip address
	gst_board_ip
	
	#Set video src
	video_src=$preview_720p_video_client
	
	#Stat client
	basic_stream_client
	
	#Go to main menu
	TO_STATE="main_menu"
}
