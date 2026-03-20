extends lock

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec() -> void:
	$Griddisplay.global_position = Vector2.ZERO
	if g.playerpos == &"door":
		delock()
		bad()
	num = 1
	if locked:
		phoneify(str(int(pos.x+1), ">, ", int(pos.y), "v"))
	$badButton.global_position = Vector2.ZERO

func bad():
	await $badButton.pressed
	posset = true
	if not g.realtime:
			g.tick.emit()

func delock():
	await $Goodbutton.pressed
	if locked == true:
		locked = false
		g.locked -= 1
		if not g.realtime:
			g.tick.emit()
