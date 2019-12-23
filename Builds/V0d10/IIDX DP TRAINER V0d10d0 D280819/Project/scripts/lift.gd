extends Position2D

onready var liftHeight = get_tree().get_root().get_node("application/UI/settings/outOfBounds/laneHieghts/lift/liftHeight").save()

func _ready():
	self.position[1] = (100 - liftHeight) * 4.786

func _on_liftHeight_value_changed(value):
	liftHeight = value
	self.position[1] = (100 - liftHeight) * 4.786
