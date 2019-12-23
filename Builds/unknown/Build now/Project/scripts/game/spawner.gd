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


func decide_note_positions(noteamount):
	if len(columnChecks) != 0:
		
		var trueColumnChecks = []
		
		for column in columnChecks:
			if column[1]:
				trueColumnChecks.append([column[0], column[2]])
		
		if len(trueColumnChecks) == 0:
			return
			
			
		var positionsToSpawn = []
		if len(trueColumnChecks) == noteamount:
			for column in trueColumnChecks:
				positionsToSpawn.append(column[0])
			spawn_notes(positionsToSpawn)
			return
		
		
		var totalPrecentage = 0
		for check in trueColumnChecks:
			totalPrecentage += check[1]
		
		if totalPrecentage == 0:
				return
		
		randomize()
		for i in range(noteamount):
			var randomNumber = randi()%int(totalPrecentage)
			var tempTotalPrecentage = 0
			for i in range(len(trueColumnChecks)):
				tempTotalPrecentage += trueColumnChecks[i][1]
				if tempTotalPrecentage >= randomNumber:
					totalPrecentage -= trueColumnChecks[i][1]
					positionsToSpawn.append(trueColumnChecks[i][0])
					trueColumnChecks.remove(i)
					break
		
		spawn_notes(positionsToSpawn)

func spawn_notes(positionsToSpawn):
	var noteRow = []
	for position in positionsToSpawn:
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
	var columnCheckLength = 0
	for check in columnChecks:
		if check[1]:
			columnCheckLength += 1
	application.columnCheckLength = columnCheckLength

func _on_column_precentage_pressed(value):
	columnChecks = get_tree().get_root().get_node("application/UI/settings/outOfBounds/columnChecks").save()
