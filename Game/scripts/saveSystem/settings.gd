extends Node

const savePath = "res://config.cfg"
var configFile = ConfigFile.new()
onready var nodesToSave = get_tree().get_nodes_in_group("nodesToSave")

func _ready():
	load_settings()

func _notification(event):
	if event == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_settings()

func save_settings():
	configFile.set_value("GAME", "version", get_tree().get_root().get_node("application/UI/about/version").text)
	for node in nodesToSave:
		configFile.set_value("GAME", node.get_name(), node.save())
	configFile.save(savePath)

func load_settings():
	var status = configFile.load(savePath)
	if status != OK:
		print("Failed to load config file. Error code %s" % status)
		return []
	for node in nodesToSave:
		var value = configFile.get_value("GAME", node.get_name())
		if value != null:
			node.load(value) 