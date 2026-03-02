extends CharacterBody2D
class_name robot
var moves := []
var movecheck = moves.duplicate_deep()
var prev
var area
var lastmove = Vector2(0,0)
var use = []
var moving = false
var pointer = 0
var currentitem = 0
var buggy = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"/root/g".move.connect(move) # Replace with function body.
	area = Area2D.new()
	add_child(area)
	area.add_child($CollisionShape2D.duplicate())
	area.collision_mask = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if $Control.has_focus() and g.playerpos == &"box":
		g.focus = $"."
	if g.focus == $".":
		$Sprite2D.modulate = Color(1.353, 1.353, 1.353, 1.0)
		if g.playerpos == &"box":
			if Input.is_action_just_pressed("left"):
				moves.append(Vector2.LEFT*32)
				g.waiter = false
			if Input.is_action_just_pressed("right"):
				moves.append(Vector2.RIGHT*32)
				g.waiter = false
			if Input.is_action_just_pressed("up"):
				moves.append(Vector2.UP*32)
				g.waiter = false
			if Input.is_action_just_pressed("down"):
				moves.append(Vector2.DOWN*32)
				g.waiter = false
			if Input.is_action_just_pressed("cancel"):
				moves.append(Vector2.ZERO)
				g.waiter = false
			if Input.is_action_just_pressed("pickup"):
				moves.append("pickup")
				g.waiter = false
			if Input.is_action_just_pressed("putdown"):
				moves.append("putdown")
				g.waiter = false
				
			if Input.is_action_just_pressed("backspace"):
				moves.pop_back()
		if not buggy:
			g.text = moves
		g.pointer = pointer
		collision_layer = 1
		

	else:
		$Sprite2D.modulate = Color(1.0, 1.0, 1.0, 1.0)
		collision_layer = 3
	position = round(position/32)*32
	if area.get_overlapping_bodies().size() > 1:
		position -= lastmove
	#if name == &"Robot4":
		#print(moves)

func move():
	if not moving:
		moving = true
		g.newposses.clear()
		if g.longest < moves.size():
			g.longest += moves.size()
		use = moves
		collision_layer = 1
		for i in 999:
			await g.tick
			pointer +=1
			collision_layer = 3
			if use.size() <= i:
				moving = false
				pointer = 0
				moves.clear()
				return
			if use.get(i) is Vector2:
				g.newposses.append(position+use.get(i))
				await get_tree().physics_frame
				if g.playerpos == &"door":
					if not g.newposses.count(position+use.get(i)) > 1:
						lastmove = use.get(i)
						position += (use.get(i))
						g.newposses.clear()
				else:
					for x in i+1:
						use.pop_front()
					moves = use.duplicate_deep()
					moving = false
					pointer = 0
					return
			else:
				g.newposses.append(position)
				lastmove = Vector2.ZERO
				if use.get(i) == &"pickup":
					if area.get_overlapping_areas():
						var lastitem = currentitem
						currentitem = area.get_overlapping_areas().front.get_parent()
						g.itemposses[currentitem] = "held"
						if lastitem:
							g.itemposses[lastitem] = position
				elif use.get(i) == &"putdown":
					if currentitem:
						g.itemposses[currentitem] = position
						currentitem = 0
		for i in 99:
			g.newposses.append(position)
			await g.tick
			if g.playerpos != &"door":
				moving = false
				pointer = 0
				return
			if i > 0:
				lastmove =Vector2.ZERO
			g.newposses.clear()
