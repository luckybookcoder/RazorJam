extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await pressed
	$"../..".add_child(load("locks.tscn").instantiate())
	$"..".queue_free() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
