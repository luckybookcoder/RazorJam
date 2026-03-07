extends OptionButton
var Box

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Box = $SpinBox # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not has_focus():
		selected = -1
		Box.hide()
		Box.value = 2
	else:
		g.lvleditem = selected
		if selected >= 5:
			Box.show()
			$"..".count = Box.value
		else:
			Box.hide()
			Box.value = 2
