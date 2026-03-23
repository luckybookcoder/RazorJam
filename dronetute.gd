extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if frame == 1:
		position = Vector2(790, 54)
		scale = Vector2.ONE*.488
	else:
		scale = Vector2.ONE
		position = Vector2(783, 53)
