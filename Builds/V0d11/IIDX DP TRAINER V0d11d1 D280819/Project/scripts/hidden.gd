extends Position2D

onready var hiddenHeight = 0

func _ready():
	self.global_position[1] = (1000 - hiddenHeight) * 0.4786

func _on_hiddenHeight_value_changed(value):
	hiddenHeight = value
	self.global_position[1] = (1000 - hiddenHeight) * 0.4786