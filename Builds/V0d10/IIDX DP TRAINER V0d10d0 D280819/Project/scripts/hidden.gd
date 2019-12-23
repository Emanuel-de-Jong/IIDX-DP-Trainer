extends Position2D

onready var hiddenHeight = get_tree().get_root().get_node("application/UI/settings/outOfBounds/laneHieghts/hidden/hiddenHeight").save()

func _ready():
	self.position[1] = (100 - hiddenHeight) * 4.786

func _on_hiddenHeight_value_changed(value):
	hiddenHeight = value
	self.position[1] = (100 - hiddenHeight) * 4.786