extends Position2D

onready var liftHeight = 0

func _ready():
	self.global_position[1] = (1000 - liftHeight) * 0.4786

func _on_liftHeight_value_changed(value):
	liftHeight = value
	self.global_position[1] = (1000 - liftHeight) * 0.4786
