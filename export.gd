extends Button
var clicked = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await pressed
	if not clicked:
		clicked = true
		text = "Copy this:"
		$RichTextLabel.show()
		$RichTextLabel.text = var_to_str($"..".savedict)

func reset():
	text = "Export Level"
	clicked = false
