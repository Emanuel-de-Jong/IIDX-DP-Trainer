extends CheckBox

func save():
	return self.pressed

func load(value):
	self.pressed = value
	get_tree().get_root().get_node("application/game/spawnTimer").spawnIntervalQuarter = value