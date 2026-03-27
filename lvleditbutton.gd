extends Button
var value :int= 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_children().size():
		if value != $SpinBox.value:
			value = $SpinBox.value
			$"..".count = value
		if get_child(0).has_focus():
			g.lvleditem = name
			$"..".count = $SpinBox.value
	if has_focus():
		g.lvleditem = name
		if get_children().size():
			$"..".count = $SpinBox.value
	if g.lvlediting:
		show()
	else:
		hide()
	
