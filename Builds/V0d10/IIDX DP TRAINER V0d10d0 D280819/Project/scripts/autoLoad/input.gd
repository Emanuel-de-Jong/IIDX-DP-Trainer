extends Node

onready var application = get_tree().get_root().get_node("application")
onready var unfocus = get_tree().get_root().get_node("application/UI/unfocus")
onready var spawner = get_tree().get_root().get_node("application/game/lanes/sudden/spawner")
onready var settings = get_tree().get_root().get_node("application/UI/settings")

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("quit"):
			settings.save_settings()
			get_tree().quit()
		if event.is_action_pressed("ui_cancel"):
			unfocus.grab_focus()
			return
		if len(application.noteRows) != 0:
			if event.is_action_pressed("skip_note_row"):
				application.delete_notes_in_first_row()
			return

func toggle_column_check(event):
	for i in range(16):
		if event.is_action_pressed(str(i)):
			var check = get_tree().get_root().get_node("application/UI/settings/outOfBounds/columnChecks/check" + str(i))
			if check.pressed:
				check.pressed = false
			else:
				check.pressed = true
			spawner._on_column_check_pressed()
			return