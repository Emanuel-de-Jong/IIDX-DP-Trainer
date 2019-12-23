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
		if notecountChecks[i].pressed:
			notecounts.append(i + 1)
	return notecounts

func load(value):
	for notecounts in notecountChecks:
		notecounts.set_pressed(false)
	for val in value:
		notecountChecks[val - 1].set_pressed(true)
	application.notecount = value

func _on_off_pressed():
	for i in range(14):
		notecountChecks[i].set_pressed(false)
	emit_signal("buttonPressed")

func _on_on_pressed():
	for i in range(14):
		notecountChecks[i].set_pressed(true)
	emit_signal("buttonPressed")
