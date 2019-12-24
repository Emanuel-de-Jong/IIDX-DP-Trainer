extends Sprite

var radians = 10
var turn = false

# warning-ignore:unused_argument
func _process(delta):
	if turn:
		turn = false
		return []
	self.rotate(radians * delta)