extends "res://wall.gd"
var counter = 0
@export var count = 2
@export var startopen = false
var wait = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	g.tick.connect(tick)
	if startopen:
		toggle() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if g.focus:
		if g.focus.global_position.distance_to(global_position) < 32:
			g.ondoor = true
	super(delta)
	if not wait and counter == count:
		while ($Area2D2.get_overlapping_bodies().size() > 1 and $Area2D.collision_layer) or ($Area2D2.get_overlapping_bodies().size() > 0 and $Area2D.collision_layer == 0):
			await get_tree().process_frame
		if not wait and counter == count:
			counter = 0
			wait = true
			toggle()

func toggle():
	if $Area2D.collision_layer:
		$Area2D.collision_layer = 0
		$Sprite2D.hide()
	else:
		$Area2D.collision_layer = 1
		$Sprite2D.show()

func tick():
	counter += 1
	wait = false
	
