extends OptionButton

func _ready():
	self.add_item("Windowed", 0)
	self.add_item("Fullscreen", 1)

func _on_screenmode_item_selected(ID):
	if ID == 0:
		OS.window_fullscreen = false
		OS.window_size = Vector2(1280, 720)
		OS.window_position = Vector2(320, 180)
	else:
		OS.window_fullscreen = true

func save():
	return self.get_selected_id()

func load(value):
	self.select(value)
	_on_screenmode_item_selected(value)