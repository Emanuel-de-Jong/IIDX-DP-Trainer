extends Button

onready var changelog = $changelog

func _pressed():
	if changelog.visible:
		changelog.visible = false
	else:
		changelog.visible = true

func _on_exit_pressed():
	changelog.visible = false
