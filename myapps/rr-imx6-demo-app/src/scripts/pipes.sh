

#Test videos
preview_1080p_video="/opt/scripts/media/bbb_1080p.avi"
preview_720p_video="/opt/scripts/media/kung-fu-panda_45_1280x532.avi"
preview_480p_video="/opt/scripts/media/bbb_480p.avi"
preview_720p_video_client="\${DEVDIR}/fs/fs/opt/scripts/media/kung-fu-panda_45_1280x532.avi"

#Streaming info
CLIENT_IP=10.251.101.29
PORT=5000

#Caps
camera_caps="application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264, sprop-parameter-sets=(string)\"Z0JAHqaAoD2QAA\\=\\=\\,aM4wpIAA\", payload=(int)96, ssrc=(uint)2031969529, clock-base=(uint)3875899417, seqnum-base=(uint)45401"
video_test_caps="application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264, sprop-parameter-sets=(string)\"Z0JAFKaBQfkA\\,aM4wpIAA\", payload=(int)96, ssrc=(uint)2288404012, clock-base=(uint)2852572406, seqnum-base=(uint)42161"
file_caps="application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)MP4V-ES, profile-level-id=(string)1, config=(string)000001b001000001b58913000001000000012000c48d8800c53c04871463000001b24c61766335312e34342e30, payload=(int)96, ssrc=(uint)281575967, clock-base=(uint)3498156131, seqnum-base=(uint)20571"
stream_client_caps="application/x-rtp,media=(string)video,clock-rate=(int)90000,encoding-name=(string)H264,sprop-parameter-sets=(string)\"Z0LAHpp0AoAi/PCAAAADAIAAABhHixdQ\\,aM4LyA\\=\\=\",payload=(int)96,ssrc=3107335084,clock-base=3676209233,seqnum-base=50612"

#Snapshot location
SNAPSHOT="/opt/scripts/media/snapshot.jpeg"
