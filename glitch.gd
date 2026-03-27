extends Node2D
var rot = randi()%360
var speed = 40
var ticks = .25
var flip = .5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position += Vector2(-5,5) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ticks > 1.5:
		flip = -.5
	ticks += flip
	speed += ticks
	position += Vector2(speed,0).rotated(deg_to_rad(rot))/10
	if ticks <= 0:
		queue_free()
