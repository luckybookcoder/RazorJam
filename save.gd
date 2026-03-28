extends Button
var clicked = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await pressed
	if not clicked:
		clicked = true
		text = "Saved!"
		$"..".clipboard = $"..".savedict.duplicate()
		

func reset():
	text = "Save Level"
	clicked = false
