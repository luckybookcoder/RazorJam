extends CharacterBody2D
class_name robot
var moves :Array[Vector2] = []
var movecheck = moves.duplicate_deep()
var prev
var area
var lastmove = Vector2(0,0)
var use = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"/root/g".move.connect(move) # Replace with function body.
	area = Area2D.new()
	add_child(area)
	area.add_child($CollisionShape2D.duplicate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if $Control.has_focus():
		
		$Sprite2D.modulate = Color(1.353, 1.353, 1.353, 1.0)
		if Input.is_action_just_pressed("ui_left"):
			moves.append(Vector2.LEFT*32)
		if Input.is_action_just_pressed("ui_right"):
			moves.append(Vector2.RIGHT*32)
		if Input.is_action_just_pressed("ui_up"):
			moves.append(Vector2.UP*32)
		if Input.is_action_just_pressed("ui_down"):
			moves.append(Vector2.DOWN*32)
		if Input.is_action_just_pressed("ui_cancel"):
			moves.append(Vector2.ZERO)
		if Input.is_action_just_pressed("ui_text_backspace"):
			moves.pop_back()
		g.text = moves
		collision_layer = 1

	else:
		$Sprite2D.modulate = Color(1.0, 1.0, 1.0, 1.0)
		collision_layer = 3
	position = round(position/32)*32
	if area.get_overlapping_areas():
		position -= lastmove

func move():
	g.newposses.clear()
	if g.longest < moves.size():
		g.longest += moves.size()
	use = moves.duplicate_deep()
	moves.clear()
	collision_layer = 1
	for i in use.size():
		await g.tick
		collision_layer = 3
		g.newposses.append(position+use.get(i))
		await get_tree().physics_frame
		if g.playerpos == &"door":
			if not g.newposses.count(position+use.get(i)) > 1:
				lastmove = use.get(i)
				position += (use.get(i))
				print(use)
				g.newposses.clear()
		else:
			moves = use
			for x in i:
				use.pop_front()
			
			return
	for i in 99:
		g.newposses.append(position)
		await g.tick
		if g.playerpos != &"door":
			return
		if i > 0:
			lastmove =Vector2.ZERO
		g.newposses.clear()
