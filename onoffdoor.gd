extends "res://wall.gd"
var counter = 0
@export var count = 2
@export var startopen = false
var wait = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	g.tick.connect(tick)
	if count == 2 and g.lvl == 9:
		count = randi()%10 + 1
		startopen = randi()%2
	if startopen:
		toggle() # Replace with function body.
	rotation_degrees += 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if count <= 0:
		count = 0
	if g.focus:
		if g.focus.global_position.distance_to(global_position) < 32:
			g.ondoor = true
	if count == 1:
		$Button.tooltip_text = str("Opens/closes every minute")
	else:
		match $Area2D.collision_layer:
		
			1:$Button.tooltip_text = str("Opens/closes every ", count," minutes\nOpens next in %d minute(s)") %max(count-counter, 1)
			0:$Button.tooltip_text = str("Opens/closes every ", count," minutes\nCloses next in %d minute(s)") %max(count-counter, 1)
	#print($Button.tooltip_text)
	super(delta)
	if ($Area2D2.get_overlapping_bodies().size() > 1 and $Area2D.collision_layer) or ($Area2D2.get_overlapping_bodies().size() > 0 and $Area2D.collision_layer == 0):
		await get_tree().process_frame;await get_tree().process_frame
		if ($Area2D2.get_overlapping_bodies().size() > 1 and $Area2D.collision_layer) or ($Area2D2.get_overlapping_bodies().size() > 0 and $Area2D.collision_layer == 0):
			counter = 0
			wait = true
			$Area2D.collision_layer = 0
			$Sprite2D.frame = 0
	if not wait and counter == count:
		while ($Area2D2.get_overlapping_bodies().size() > 1 and $Area2D.collision_layer) or ($Area2D2.get_overlapping_bodies().size() > 0 and $Area2D.collision_layer == 0):
			await get_tree().process_frame
		if not wait and counter >= count:
			counter = 0
			wait = true
			toggle()
	if $Area2D.collision_layer:
		$Sprite2D.play("waves")
	else:
		$Sprite2D.frame = 0
		$Sprite2D.animation = "default"

func toggle():
	if $Area2D.collision_layer:
		$Area2D.collision_layer = 0
		$Sprite2D.frame = 0
		$Sprite2D.animation = "default"
	else:
		$Area2D.collision_layer = 1
		$Sprite2D.frame = 1

func tick():
	counter += 1
	wait = false
	
