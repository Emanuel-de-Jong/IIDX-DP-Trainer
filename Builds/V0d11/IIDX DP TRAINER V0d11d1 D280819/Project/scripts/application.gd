extends Node

onready var spawner = $game/lanes/sudden/spawner
var notecount = []
var hispeed = 0
var liftHeight = 0
onready var bottom = $game/lanes/lift
onready var spawnTimer = $game/spawnTimer
onready var visuals = $UI/settings/tabContainer/visuals
onready var input = $"/root/input"

var columnPositionsToPress = []
var columnPositionsNotToPress = []
var noteRows = []
var rightKeysPressed = []
var wrongKeysPressed = []
var collisionHappening = false
var deletingNotes = false

func _input(event):
	if event is InputEventKey and len(columnPositionsToPress) != 0:
		if event.get_control():
			input.toggle_column_check(event)
		else:
			for columnPosition in columnPositionsToPress:
				if event.is_action_pressed(str(columnPosition)):
					rightKeysPressed.append(columnPosition)
					check_if_input_valid()
					return
				elif event.is_action_released(str(columnPosition)):
					rightKeysPressed.erase(columnPosition)
					check_if_input_valid()
					return
			for columnPosition in columnPositionsNotToPress:
				if event.is_action_pressed(str(columnPosition)):
					wrongKeysPressed.append(columnPosition)
					check_if_input_valid()
					return
				elif event.is_action_released(str(columnPosition)):
					wrongKeysPressed.erase(columnPosition)
					check_if_input_valid()
					return

func check_if_input_valid():
	if len(wrongKeysPressed) == 0 and len(rightKeysPressed) == len(columnPositionsToPress):
		if noteRows[0][0].global_position[1] >= liftHeight - 100:
			visuals.display_keys(columnPositionsToPress)
			delete_notes_in_first_row()


func delete_notes_in_first_row():
	if len(noteRows) != 0:
		var noteRow = noteRows[0]
		deletingNotes = true
		noteRows.pop_front()
		for note in noteRow:
			note.queue_free()
		deletingNotes = false
		if len(noteRows) != 0:
			fix_column_positions()

func fix_column_positions():
	columnPositionsToPress.clear()
	columnPositionsNotToPress.clear()
	for note in noteRows[0]:
		columnPositionsToPress.append(note.columnPosition)
	for columnCheck in spawner.columnChecks:
		if !columnPositionsToPress.has(columnCheck):
			columnPositionsNotToPress.append(columnCheck)
	rightKeysPressed.clear()
	wrongKeysPressed.clear()

func _on_spawnTimer_timeout():
	randomize()
	if len(notecount) != 0:
		spawner.spawn_notes(notecount[randi()%len(notecount)])


func _process(delta):
	if len(noteRows) != 0 and !spawnTimer.paused:
		for noteRow in noteRows:
			for note in noteRow:
				note.global_position += Vector2(0, hispeed) * delta


func _on_notecount_check_pressed():
	notecount = $UI/settings/tabContainer/gameplay/notecount.save()

func _on_hispeed_value_changed(value):
	hispeed = value


func _on_area2D_area_entered(area):
	spawnTimer.paused = true
	if !deletingNotes:
		area.global_position[1] = bottom.global_position[1]

func _on_area2D_area_exited(area):
	spawnTimer.paused = false


func _on_liftHeight_value_changed(value):
	liftHeight = (1000 - value) * 0.4786
