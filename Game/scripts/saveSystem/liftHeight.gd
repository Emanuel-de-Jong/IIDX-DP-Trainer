extends VScrollBar

func save():
	return self.value

func load(value):
	self.value = value
	get_tree().get_root().get_node("application/game/lanes/lift").liftHeight = value
	get_tree().get_root().get_node("application").liftHeight = (1000 - value) * 0.4786