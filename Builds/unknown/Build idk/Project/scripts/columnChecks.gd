extends Control

signal buttonPressed

onready var columnChecks = get_tree().get_nodes_in_group("columnChecks")
onready var columnCheckPrecentages = get_tree().get_nodes_in_group("columnCheckPrecentages")
onready var spawner = get_tree().get_root().get_node("application/game/lanes/sudden/spawner")

func _ready():
# warning-ignore:return_value_discarded
	connect("buttonPressed", spawner, "_on_column_check_pressed")

func _on_toggleAllLeft_toggled(button_pressed):
	for i in range(8):
		columnChecks[i].set_pressed(button_pressed)
	emit_signal("buttonPressed")

func _on_toggleAllRight_toggled(button_pressed):
	for i in range(8, 16):
		columnChecks[i].set_pressed(button_pressed)
	emit_signal("toggleAllToggled")

func save():
	var columns = []
	for i in range(16):
		columns.append([i, columnChecks[i].pressed, columnCheckPrecentages[i].value])
	return columns

func load(value):
	for i in range(16):
		columnChecks[i].set_pressed(value[i][1])
		columnCheckPrecentages[i].value = value[i][2]
	spawner.columnChecks = value
	
	var columnCheckLength = 0
	for val in value:
		if val[1]:
			columnCheckLength += 1
	if columnCheckLength > 13:
		columnCheckLength = 13
	
	get_tree().get_root().get_node("application").columnCheckLength = columnCheckLength

func _on_offLeft_pressed():
	for i in range(8):
		columnChecks[i].set_pressed(false)
	emit_signal("buttonPressed")


func _on_offRight_pressed():
	for i in range(8, 16):
		columnChecks[i].set_pressed(false)
	emit_signal("buttonPressed")


func _on_onLeft_pressed():
	for i in range(8):
		columnChecks[i].set_pressed(true)
	emit_signal("buttonPressed")


func _on_onRight_pressed():
	for i in range(8, 16):
		columnChecks[i].set_pressed(true)
	emit_signal("buttonPressed")
