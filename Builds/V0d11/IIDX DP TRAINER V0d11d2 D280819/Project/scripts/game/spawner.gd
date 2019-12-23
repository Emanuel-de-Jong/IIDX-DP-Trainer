extends Node

onready var spawns = [ $spawn0, $spawn1, $spawn2, $spawn3, $spawn4, $spawn5, $spawn6, $spawn7, $spawn8, $spawn9, $spawn10, $spawn11, $spawn12, $spawn13, $spawn14, $spawn15 ]
var columnChecks = []
onready var notes = get_tree().get_root().get_node("application/game/lanes/lift/notes")
onready var application = get_tree().get_root().get_node("application")

const whiteNoteScene = preload("res://scenes/whiteNote.tscn")
const blackNoteScene = preload("res://scenes/blackNote.tscn")
const turnNoteScene = preload("res://scenes/turnNote.tscn")

const whiteNotePositions = [ 1, 3, 5, 7, 8, 10, 12, 14 ]
const blackNotePositions = [ 2, 4, 6, 9, 11, 13 ]
const turnNotePositions = [ 0, 15 ]


func spawn_notes(noteamount):
	if len(columnChecks) != 0:
		if noteamount > len(columnChecks):
			noteamount = len(columnChecks)
		var shuffledColumnChecks = shuffle_list(columnChecks)
		var noteRow = []
		for i in range(noteamount):
			var position = shuffledColumnChecks[i]
			var note
			if whiteNotePositions.has(position):
				note = whiteNoteScene.instance()
			elif blackNotePositions.has(position):
				note = blackNoteScene.instance()
			else:
				note = turnNoteScene.instance()
			notes.add_child(note)
			note.columnPosition = position
			note.global_position = spawns[position].global_position
			noteRow.append(note)
		application.noteRows.append(noteRow)
		if len(application.noteRows) == 1:
			application.fix_column_positions()


func shuffle_list(list):
	var shuffledList = []
	var indexList = range(len(list))
	for i in range(len(list)):
		randomize()
		var x = randi()%len(indexList)
		shuffledList.append(list[indexList[x]])
		indexList.remove(x)
	return shuffledList

func _on_column_check_pressed():
	columnChecks = get_tree().get_root().get_node("application/UI/settings/outOfBounds/columnChecks").save()