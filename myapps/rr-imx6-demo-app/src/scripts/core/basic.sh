#!/bin/sh
#
#RidgeRun Copyright 2013
#
#Author: Edison Fernandez <edison.fernandez@ridgerun.com>
#
#Summary: Basic functionallities for scripts

PIPE_COUNTER=0

#-------------------------------------------------------
#Sumary: gets board ip address 
#-------------------------------------------------------
#-------------------------------------------------------
# Modifies
# BOARD_IP: board ip address
#-------------------------------------------------------
gst_board_ip()
{
	BOARD_IP=`ifconfig eth0 | grep "inet addr" | cut -d: -f2 | cut -d' ' -f1`
}

#-------------------------------------------------------
#Sumary: gets display resolution
#-------------------------------------------------------
#Parameter 1: display # (fbx)
#-------------------------------------------------------
# Output
#xres: display x resolution
#yres: display y resolution
#-------------------------------------------------------
get_display_relolution()
{
	# Get x reolution
	# Take everything before the ","
	xres=$(cat /sys/class/graphics/$1/virtual_size | sed 's!,.*!!')
	
	# Get y resolution
	# Take everything after the "," 
	yres=$(cat /sys/class/graphics/$1/virtual_size | sed 's!^.*,!!')
}

#-------------------------------------------------------
#Sumary: list created pipelines
#-------------------------------------------------------
list_pipelines()
{
	log_success "Current piplines"
	
	print_blanks
	
	#Remove the first #
	remaining=$(echo $AVAILABLE_PIPES | sed 's!#!!')

	for i in $(seq 0 $((PIPE_COUNTER-1)))
	do
		# Remove everything after the #
		description=$(echo $remaining | sed 's!#.*!!')
		#Remove everything before the #
		remaining=$(echo $remaining | sed 's!^[^#]*#!!')

		log INFO "   $i)  $description"
	done
}


#-------------------------------------------------------
#Sumary: Select camera state
#-------------------------------------------------------
#Parameter 1: previous state (from)
#Parameter 2: next state (to) 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
select_camera()
{
	
	OPTS="exit $1.back camera0 camera1"
    
    print_blanks
    log_success "Select Camera"
    print_blanks
	
	go_to_state "$OPTS"
	
	if [ $TO_STATE == "camera0" ]; then
		CAMERA="/dev/video0"
		TO_STATE="$2"
	elif [ $TO_STATE == "camera1" ]; then
		CAMERA="/dev/video1"
		TO_STATE="$2"
	fi
}

#-------------------------------------------------------
#Sumary: select display state
#-------------------------------------------------------
#Parameter 1: previous state (from)
#Parameter 2: next state (to) 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
select_display()
{
	OPTS="exit $1.back Display0 Display1"
    
    print_blanks
    log_success "Select Display"
    print_blanks

	go_to_state "$OPTS"
	
	if [ $TO_STATE == "Display0" ]; then
		display="/dev/video16"
		mon="mon1"
		fbx="fb0"
		TO_STATE="$2"
	elif [ $TO_STATE == "Display1" ]; then
		display="/dev/video18"
		mon="mon2"
		fbx="fb2"
		TO_STATE="$2"
	fi
}

#-------------------------------------------------------
#Sumary: select overlay state
#-------------------------------------------------------
#Parameter 1: previous state (from)
#Parameter 2: next state (to) 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
select_overlay()
{
	OPTS="exit $1.back FullScreen Overlay"
    
    print_blanks
    log_success "Select Overlay"
    print_blanks

	go_to_state "$OPTS"
	
	
	if [ $TO_STATE == "FullScreen" -o $TO_STATE == "Overlay" ]; then
	
		resolution=$TO_STATE
		x_start=0
		y_start=0
		
		# Get display resolution
		get_display_relolution "$fbx"
		
		width=$xres
		height=$yres
		
		if [ $resolution == "Overlay" ]; then
			prompt_input "Select window x position (0 - $xres)"
			x_start=$USER
			max_width=$((xres-x_start))
			
			prompt_input "Select window y position (0 - $yres)"
			y_start=$USER
			max_height=$((yres-y_start)) 
			
			prompt_input "Select window width (0 - $max_width)"
			width=$USER
			
			prompt_input "Select window height (0 - $max_height)"
			height=$USER
		fi	
		TO_STATE="$2"
	fi
}

#-------------------------------------------------------
#Sumary: video test pattern state
#-------------------------------------------------------
#Parameter 1: previous state (from)
#Parameter 2: next state (to) 
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------	
video_test_pattern()
{
	OPTS="exit $1.back $2.select_pattern"
    
    print_blanks
    log_success "Video test pattern"
    print_blanks

    go_to_state "$OPTS"
}

#-------------------------------------------------------
#Sumary: select pattern state
#-------------------------------------------------------
#Parameter 1: next state (to)  
#-------------------------------------------------------
# Modifies
#-------------------------------------------------------
select_pattern()
{
	prompt_input "Select Patern number (0 - 20)"
	pattern=$USER
	
	TO_STATE="$1"
	
}


#-------------------------------------------------------
#Sumary: basic video preview function
#-------------------------------------------------------
#Prerequirements: 
#display: output display
#PREV_SRC: preview source (video_test_pattern/camera_loopback/video_preview)
#pattern: video test pattern number
#CAMERA: source camera
#video_src: file source location for preview
#resolution: Fullscreen or Overlay
#-------------------------------------------------------
# Modifies
#SRC_ELEMENT: contains the pipeline source elements
#SINK_ELEMENT: contains the pipeline sink element
#AVAILABLE_PIPES: pipelines descriptions (#<pipe0>#<pipe1>#...)
#PIPE_COUNTER: current number of pipelines
#-------------------------------------------------------
basic_preview()
{
	log DEBUG "Starting $PREV_SRC on monitor $display..."


	case $PREV_SRC in
		"video_test_pattern")
			SRC_ELEMENT="videotestsrc pattern=$pattern"
			AVAILABLE_PIPES="$AVAILABLE_PIPES#Video Test Pattern $pattern"
		;;
		
		"camera_loopback")
			SRC_ELEMENT="mfw_v4lsrc device=$CAMERA"
			AVAILABLE_PIPES="$AVAILABLE_PIPES#Camera loopback from $CAMERA"
		;;
		
		"video_preview")
			SRC_ELEMENT="filesrc location=${video_src} typefind=true ! aiurdemux ! vpudec"
			AVAILABLE_PIPES="$AVAILABLE_PIPES#Preview $video_src"
		;;
		
		*)
		;;
		
	esac
	
	if [ $resolution == "FullScreen" ]; then
		SINK_ELEMENT="mfw_v4lsink device=$display axis-left=$x_start axis_top=$y_start disp-width=$width disp-height=$height"
	else
		SINK_ELEMENT="mfw_isink display=$mon axis-left=$x_start axis_top=$y_start disp-width=$width disp-height=$height"
	fi

	#Update pipeline list
	AVAILABLE_PIPES="$AVAILABLE_PIPES to $display"

	#print pipeline
	log_success "Created pipeline:"
	log DEBUG "$SRC_ELEMENT ! $SINK_ELEMENT"

	#Create pipiline
	gst-client create "$SRC_ELEMENT ! $SINK_ELEMENT"
	
	#Start pipeline
	gst-client play -p $PIPE_COUNTER
	
	#Increment pipeline counter
	PIPE_COUNTER=$((PIPE_COUNTER+1))
		
}



#-------------------------------------------------------
#Sumary: basic stream function
#-------------------------------------------------------
#Prerequirements: 
#CLIENT_IP: client ip address
#PREV_SRC: preview source (video_test_pattern/from_camera/from_file)
#pattern: video test pattern number
#CAMERA: source camera
#video_src: file source location for stream
#-------------------------------------------------------
# Modifies
#SRC_ELEMENT: contains the pipeline source elements
#SINK_ELEMENT: contains the pipeline sink element
#AVAILABLE_PIPES: pipelines descriptions (#<pipe0>#<pipe1>#...)
#PIPE_COUNTER: current number of pipelines
#-------------------------------------------------------
basic_stream()
{
	log DEBUG "Starting $PREV_SRC stream to $CLIENT_IP..."

	case $PREV_SRC in
		"video_test_pattern_s")
			SRC_ELEMENT="videotestsrc pattern=$pattern ! vpuenc  codec=6 ! queue ! h264parse ! rtph264pay"
			AVAILABLE_PIPES="$AVAILABLE_PIPES#Video Test Pattern $pattern stream"
			CLIENT_PIPE="gst-launch udpsrc port=$PORT ! '${video_test_caps}' ! rtph264depay ! queue ! ffdec_h264 ! xvimagesink sync=false"
		;;
		
		"from_camera")
			SRC_ELEMENT="mfw_v4lsrc device=$CAMERA ! vpuenc codec=6 ! queue ! rtph264pay"
			AVAILABLE_PIPES="$AVAILABLE_PIPES#Camera stream from $CAMERA"
			CLIENT_PIPE="gst-launch udpsrc port=$PORT ! '${camera_caps}' ! rtph264depay ! queue ! ffdec_h264 ! xvimagesink sync=false"
		;;
		
		"from_file")
			SRC_ELEMENT="filesrc location=${video_src} typefind=true ! aiurdemux  ! queue !  mpeg4videoparse ! rtpmp4vpay"
			AVAILABLE_PIPES="$AVAILABLE_PIPES#Stream $video_src"
			CLIENT_PIPE="gst-launch udpsrc port=$PORT ! '${file_caps}' ! rtpmp4vdepay ! queue ! ffdec_mpeg4 ! xvimagesink sync=false -v"
		;;
		
		*)
		;;
		
	esac
	
	SINK_ELEMENT="udpsink host=$CLIENT_IP port=$PORT"

	#print pipeline
	log_success "Created pipeline:"
	log DEBUG "$SRC_ELEMENT ! $SINK_ELEMENT"

	#Client Pipeline
	print_blanks
	log INFO "Client's side pipeline"
	print_blanks
	echo $CLIENT_PIPE
	print_blanks

	# Wait for the user to start the pipeline
	user_activity "Execute the previous pipeline in the host PC and then"

	#Create pipiline
	gst-client create "$SRC_ELEMENT ! $SINK_ELEMENT"
	
	#Start pipeline
	gst-client play -p $PIPE_COUNTER
	
	#Increment pipeline counter
	PIPE_COUNTER=$((PIPE_COUNTER+1))
}

#-------------------------------------------------------
#Sumary: basic stream client function
#-------------------------------------------------------
#Prerequirements: 
#CLIENT_IP: client ip address
#PREV_SRC: preview source (video_test_pattern/from_camera/from_file)
#pattern: video test pattern number
#CAMERA: source camera
#video_src: file source location for stream
#-------------------------------------------------------
# Modifies
#SRC_ELEMENT: contains the pipeline source elements
#SINK_ELEMENT: contains the pipeline sink element
#AVAILABLE_PIPES: pipelines descriptions (#<pipe0>#<pipe1>#...)
#PIPE_COUNTER: current number of pipelines
#-------------------------------------------------------
basic_stream_client()
{
	log DEBUG "Starting stream from PC to $display..."

	SRC_ELEMENT="udpsrc port=$PORT ! capsfilter caps=$stream_client_caps ! rtph264depay ! queue ! vpudec"
	AVAILABLE_PIPES="$AVAILABLE_PIPES#Video streaming from PC"
	
	if [ $resolution == "FullScreen" ]; then
		SINK_ELEMENT="mfw_v4lsink device=$display axis-left=$x_start axis_top=$y_start disp-width=$width disp-height=$height sync=false"
	else
		SINK_ELEMENT="mfw_isink display=$mon axis-left=$x_start axis_top=$y_start disp-width=$width disp-height=$height sync=false"
	fi

	#Update pipeline list
	AVAILABLE_PIPES="$AVAILABLE_PIPES to $display"

	#print pipeline
	log_success "Created pipeline:"
	log DEBUG "$SRC_ELEMENT ! $SINK_ELEMENT"

	#Server Pipeline
	print_blanks
	log INFO "Server's side pipeline"
	print_blanks
	echo "gst-launch filesrc location=${video_src}  ! avidemux ! queue ! rtph264pay ! udpsink port=$PORT host=$BOARD_IP enable-last-buffer=false -v"
	print_blanks

	#Create pipiline
	gst-client create "$SRC_ELEMENT ! $SINK_ELEMENT"
	
	#Start pipeline
	gst-client play -p $PIPE_COUNTER
	
	#Increment pipeline counter
	PIPE_COUNTER=$((PIPE_COUNTER+1))
}


#-------------------------------------------------------
#Sumary: basic capture function
#-------------------------------------------------------
#Prerequirements: 
#CAMERA: source camera
#-------------------------------------------------------
# Modifies
#AVAILABLE_PIPES: pipelines descriptions (#<pipe0>#<pipe1>#...)
#PIPE_COUNTER: current number of pipelines
#-------------------------------------------------------
basic_capture()
{
	#Update info
	AVAILABLE_PIPES="$AVAILABLE_PIPES#Snapshot from $CAMERA"
	
	
	#Create pipeline
	gst-client create "mfw_v4lsrc device=$CAMERA num-buffers=1 ! vpuenc codec=12 ! multifilesink location=${SNAPSHOT}"
	
	#Start pipeline
	gst-client play -p $PIPE_COUNTER
	
	#Increment pipeline counter
	PIPE_COUNTER=$((PIPE_COUNTER+1))
}
