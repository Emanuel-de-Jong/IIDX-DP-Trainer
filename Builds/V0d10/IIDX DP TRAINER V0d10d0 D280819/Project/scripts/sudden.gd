extends Position2D

onready var suddenHeight = get_tree().get_root().get_node("application/UI/settings/outOfBounds/laneHieghts/sudden/suddenHeight").save()

func _ready():
	self.position[1] = suddenHeight * 4.786

func _on_suddenHeight_value_changed(value):
	suddenHeight = value
	self.position[1] = suddenHeight * 4.786