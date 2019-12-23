extends Position2D

onready var suddenHeight = 0

func _ready():
	self.global_position[1] = suddenHeight * 0.4786

func _on_suddenHeight_value_changed(value):
	suddenHeight = value
	self.global_position[1] = suddenHeight * 0.4786