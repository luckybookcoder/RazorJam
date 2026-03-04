extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	g.itemposses.get_or_add($".", position)
	$Button.pressed.connect(kill) # Replace with function body.

func kill():
	if g.lvleditem is String:
		if g.lvleditem == "ERASE":
			queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if g.itemposses[$"."] is Vector2:
		position = g.itemposses[$"."]
		show()
	else:
		hide()

	position = round(position/32)*32
