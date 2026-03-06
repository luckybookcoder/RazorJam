extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		@warning_ignore("integer_division")
		text = str(g.time/60%12 + 1, ":","%02d" % (g.time%60))
