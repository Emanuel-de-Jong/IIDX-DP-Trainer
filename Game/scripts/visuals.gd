extends VBoxContainer

const whiteNotePositions = [ 1, 3, 5, 7, 8, 10, 12, 14 ]
const blackNotePositions = [ 2, 4, 6, 9, 11, 13 ]
const turnNotePositions = [ 0, 15 ]

func _input(event):
	if event is InputEventKey:
		for i in range(16):
			if event.is_action_pressed(str(i)):
				var beam = get_tree().get_root().get_node("application/game/lanes/lift/beams/beam" + str(i))
				get_tree().get_root().get_node("application/game/lanes/lift/beams/beam" + str(i) + "/animationPlayer").stop(true)
				beam.modulate = Color(1,1,1,1)
				if whiteNotePositions.has(i):
					beam.scale = Vector2(0.959, 0.959)
				elif blackNotePositions.has(i):
					beam.scale = Vector2(0.95, 0.95)
				else:
					beam.scale = Vector2(0.978, 0.978)
			if event.is_action_released(str(i)):
				get_tree().get_root().get_node("application/game/lanes/lift/beams/beam" + str(i) + "/animationPlayer").play("beam")

func display_keys(columnPositions):
	for position in columnPositions:
		if !turnNotePositions.has(position):
			get_tree().get_root().get_node("application/game/keys/key" + str(position) + "/animationPlayer").play("key")