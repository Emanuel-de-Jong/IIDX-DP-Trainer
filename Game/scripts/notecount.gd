extends VBoxContainer

signal buttonPressed

onready var notecountChecks = get_tree().get_nodes_in_group("notecountChecks")
onready var notecountPrecentages = get_tree().get_nodes_in_group("notecountPrecentages")
onready var application = get_tree().get_root().get_node("application")

func _ready():
# warning-ignore:return_value_discarded
	connect("buttonPressed", application, "_on_notecount_check_pressed")

func save():
	var notecounts = []
	for i in range(14):
		notecounts.append([i + 1, notecountChecks[i].pressed, notecountPrecentages[i].value])
	return notecounts

func load(value):
	for i in range(14):
		notecountChecks[i].set_pressed(value[i][1])
		notecountPrecentages[i].value = value[i][2]
	application.notecount = value

func _on_off_pressed():
	for i in range(14):
		notecountChecks[i].set_pressed(false)
	emit_signal("buttonPressed")

func _on_on_pressed():
	for i in range(14):
		notecountChecks[i].set_pressed(true)
	emit_signal("buttonPressed")
