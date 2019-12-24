extends VBoxContainer

onready var methods = $"/root/methods"
onready var option = $option
var hitsoundsPath = "res://sounds/hitsounds"
var hitsoundNames

func _ready():
	hitsoundNames = methods.return_file_names_in_directory(hitsoundsPath, ["wav"])
	option.add_item("none", -1)
	for hitsoundName in hitsoundNames:
		option.add_item(hitsoundName.substr(0, hitsoundName.find_last(".")), -1)