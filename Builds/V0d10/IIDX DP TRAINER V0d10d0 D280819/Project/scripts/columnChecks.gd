extends Control

signal toggleAllToggled

onready var columnChecks = get_tree().get_nodes_in_group("columnChecks")
onready var spawner = get_tree().get_root().get_node("application/game/lanes/sudden/spawner")
onready var toggleAllLeft = $toggleAllLeft
onready var toggleAllRight = $toggleAllRight

func _ready():
# warning-ignore:return_value_discarded
	connect("toggleAllToggled", spawner, "_on_column_check_pressed")

func _on_toggleAllLeft_toggled(button_pressed):
	for i in range(8):
		columnChecks[i].set_pressed(button_pressed)
	emit_signal("toggleAllToggled")

func _on_toggleAllRight_toggled(button_pressed):
	for i in range(8, 16):
		columnChecks[i].set_pressed(button_pressed)
	emit_signal("toggleAllToggled")

func change_toggle_all_on_column_checks_minmax(columnsCheckedLeft, columnsCheckedRight):
	if len(columnsCheckedLeft) == 0:
		toggleAllLeft.pressed = false
	elif len(columnsCheckedLeft) == 8:
		toggleAllLeft.pressed = true
		
	if len(columnsCheckedRight) == 0:
		toggleAllRight.pressed = false
	elif len(columnsCheckedRight) == 8:
		toggleAllRight.pressed = true

func save():
	var columnsChecked = []
	var columnsCheckedLeft = []
	var columnsCheckedRight = []
	if columnChecks !=  null:
		for i in range(8):
			if columnChecks[i].pressed:
				columnsCheckedLeft.append(i)
				columnsChecked.append(i)
		for i in range(8, 16):
			if columnChecks[i].pressed:
				columnsCheckedRight.append(i)
				columnsChecked.append(i)
		change_toggle_all_on_column_checks_minmax(columnsCheckedLeft, columnsCheckedRight)
	
	return columnsChecked

func load(value):
	for columnCheck in columnChecks:
		columnCheck.set_pressed(false)
	for val in value:
		columnChecks[val].set_pressed(true)
	spawner.columnChecks = value