extends Control

signal buttonPressed

onready var columnChecks = get_tree().get_nodes_in_group("columnChecks")
onready var spawner = get_tree().get_root().get_node("application/game/lanes/sudden/spawner")

func _ready():
# warning-ignore:return_value_discarded
	connect("buttonPressed", spawner, "_on_column_check_pressed")

func _on_toggleAllLeft_toggled(button_pressed):
	for i in range(7):
		columnChecks[i].set_pressed(button_pressed)
	emit_signal("buttonPressed")

func _on_toggleAllRight_toggled(button_pressed):
	for i in range(7, 14):
		columnChecks[i].set_pressed(button_pressed)
	emit_signal("toggleAllToggled")

func save():
	var columns = []
	for i in range(14):
		if columnChecks[i].pressed:
			columns.append(i + 1)
	return columns

func load(value):
	for column in columnChecks:
		column.set_pressed(false)
	for val in value:
		columnChecks[val].set_pressed(true)
	spawner.columnChecks = value
	
	var columnCheckLength = 0
	for val in value:
		if val[1]:
			columnCheckLength += 1
	get_tree().get_root().get_node("application").columnCheckLength = columnCheckLength

func _on_offLeft_pressed():
	for i in range(7):
		columnChecks[i].set_pressed(false)
	emit_signal("buttonPressed")


func _on_offRight_pressed():
	for i in range(7, 14):
		columnChecks[i].set_pressed(false)
	emit_signal("buttonPressed")


func _on_onLeft_pressed():
	for i in range(7):
		columnChecks[i].set_pressed(true)
	emit_signal("buttonPressed")


func _on_onRight_pressed():
	for i in range(7, 14):
		columnChecks[i].set_pressed(true)
	emit_signal("buttonPressed")
