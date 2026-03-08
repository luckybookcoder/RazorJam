extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	g.endlvl.connect(endlvl) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func endlvl():
	queue_free()
