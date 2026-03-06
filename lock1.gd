extends lock


# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec() -> void:
	if g.playerpos == &"door":
		delock()
	num = 1

func delock():
	await $".".pressed
	if locked == true:
		locked = false
		g.locked -= 1
		g.tick.emit()
