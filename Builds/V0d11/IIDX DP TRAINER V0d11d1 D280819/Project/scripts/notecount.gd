extends VBoxContainer

signal toggleAllToggled

onready var notecountChecks = get_tree().get_nodes_in_group("notecountChecks")
onready var application = get_tree().get_root().get_node("application")
onready var toggleAll = $toggleAll

func _ready():
# warning-ignore:return_value_discarded
	connect("toggleAllToggled", application, "_on_notecount_check_pressed")

func _on_toggleAll_toggled(button_pressed):
	for i in range(14):
		notecountChecks[i].set_pressed(button_pressed)
	emit_signal("toggleAllToggled")

func change_toggle_all_on_notecount_minmax(length):
	if length == 0:
		toggleAll.set_pressed(false)
	elif length == 14:
		toggleAll.set_pressed(true)

func save():
	var notecounts = []
	for i in range(14):
		if notecountChecks[i].pressed:
			notecounts.append(i + 1)
	change_toggle_all_on_notecount_minmax(len(notecounts))
	return notecounts

func load(value):
	for notecounts in notecountChecks:
		notecounts.set_pressed(false)
	for val in value:
		notecountChecks[val - 1].set_pressed(true)
	application.notecount = value