extends lock

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec() -> void:
	if g.playerpos == &"door":
		delock()
	num = 1
	if locked:
		phoneify(str(int(pos.x+1), ">, ", int(pos.y), "v"))
	$badButton.global_position = Vector2.ZERO

func delock():
	await $Goodbutton.pressed
	if locked == true:
		locked = false
		g.locked -= 1
		g.tick.emit()
