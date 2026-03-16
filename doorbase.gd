extends Control
var timer = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if g.playerpos == &"door":
		show()
		if not timer:
			timer = true
			g.time += 1
		if Input.is_action_just_pressed("backspace") or Input.is_action_just_pressed("cancel") and g.reset:
			g.tick.emit()
	else:
		hide()
		timer = false
