extends Node2D
const segments = [Vector2(0,0), Vector2(0,15), Vector2(-5,15), Vector2(-5,25), Vector2(30,25),Vector2(30,50),Vector2(15,50), Vector2(15,40)]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()

func _draw():
	draw_polyline(segments,Color(0.584, 0.584, 0.584, 1.0))
