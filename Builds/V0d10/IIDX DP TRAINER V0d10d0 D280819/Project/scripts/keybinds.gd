extends Button

onready var keybindsPanel = get_tree().get_root().get_node("application/UI/settings/outOfBounds/keybindsPanel")
onready var keybindsButtons = get_tree().get_nodes_in_group("keybindsButtons")
onready var assignHelp = get_tree().get_root().get_node("application/UI/settings/outOfBounds/keybindsPanel/assignHelp")
var currentButton

func _ready():
	set_process_input(false)
	for button in keybindsButtons:
		var inputevent = InputMap.get_action_list(button.name)[0]
		button.text = OS.get_scancode_string(inputevent.scancode)
		button.connect("pressed", self, "wait_for_input", [button])

func wait_for_input(button):
	currentButton = button
	assignHelp.text = "give an input..."
	set_process_input(true)

func _input(event):
	if event is InputEventKey:
		if !event.is_action("ui_cancel"):
			var scancode = OS.get_scancode_string(event.scancode)
			currentButton.text = scancode
			
			InputMap.action_erase_events(str(currentButton.name))
			
			InputMap.action_add_event(str(currentButton.name), event)
		set_process_input(false)
		assignHelp.text = "press a button"

func _pressed():
	if keybindsPanel.visible:
		keybindsPanel.visible = false
	else:
		keybindsPanel.visible = true

func _on_exit_pressed():
	keybindsPanel.visible = false

func save():
	var keybinds = []
	for i in range(16):
		keybinds.append(OS.get_scancode_string(InputMap.get_action_list(str(i))[0].scancode))
	return keybinds

func load(value):
	for i in range(16):
		InputMap.action_erase_events(str(i))
		var event = InputEventKey.new()
		event.scancode = OS.find_scancode_from_string(value[i])
		InputMap.action_add_event(str(i), event)