extends Control
var timer = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(visible)
	if g.playerpos == &"door":
		show()
		if not timer:
			timer = true
			if not g.realtime:
				g.time += 1
		if Input.is_action_just_pressed("cancel") and g.reset:
			g.tick.emit()
	elif $Sprite2D.frame == 5:
		timer = false
		for i in 9999:
			for x in 18:
				if $Sprite2D.frame == 5 && not g.playerpos == &"door":
					hide()
				else:
					return
			await get_tree().process_frame
