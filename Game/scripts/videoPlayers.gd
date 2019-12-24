extends Node

onready var methods = $"/root/methods"
onready var videoPlayerTop = $videoPlayerTop
onready var videoPlayerBottom = $videoPlayerBottom
var ogvsPath = "res://videos"
var videoStream := VideoStreamTheora.new()
var ogvNames

func _ready():
	ogvNames = methods.return_file_names_in_directory(ogvsPath, [ "ogv" ])
	print(ogvNames)
	play_random_video()

func _on_videoUp_finished():
	play_random_video()

func play_random_video():
	randomize()
	var randomOgv = ogvsPath + "/" + ogvNames[randi()%len(ogvNames)]
	videoStream.set_file(randomOgv)
	videoPlayerTop.set_stream(videoStream)
	videoPlayerBottom.set_stream(videoStream)
	videoPlayerTop.play()
	videoPlayerBottom.play()