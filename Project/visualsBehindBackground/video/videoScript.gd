extends Node

onready var globalMethods = $"/root/globalMethods"
onready var videoVideoPlayerTop = $VideoVideoPlayerTop
onready var videoVideoPlayerBottom = $VideoVideoPlayerBottom
var videosPath = self.get_script().get_path().get_base_dir() + "/videoVideos"
var videoStream = VideoStreamTheora.new()
var videoNames


func _ready():
	videoNames = globalMethods.return_file_names_in_directory(videosPath, true, [ "ogv" ])
	play_random_video()

func _on_VideoVideoPlayerTop_finished():
	play_random_video()

func play_random_video():
	randomize()
	var randomVideo = videosPath + "/" + videoNames[randi()%len(videoNames)]
	videoStream.set_file(randomVideo)
	videoVideoPlayerTop.set_stream(videoStream)
	videoVideoPlayerBottom.set_stream(videoStream)
	videoVideoPlayerTop.play()
	videoVideoPlayerBottom.play()


