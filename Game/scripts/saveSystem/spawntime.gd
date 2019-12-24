extends SpinBox

func save():
	return self.value

func load(value):
	self.value = value
	get_tree().get_root().get_node("application/game/spawnTimer").spawntime = value