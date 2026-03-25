extends CharacterBody2D
class_name robot
var moves := []
var movecheck = moves.duplicate_deep()
var prevplace = global_position
var area
var lastmove = Vector2(0,0)
var use = []
var moving = false
var pointer = -1
var currentitem = 0
var buggy = 0
var savedtext = false
var lastcommands = []
var ghost
var but = false
var alltick = 0
var shader_material
var ghostcheck = false
var droneplay = true

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	g.move.connect(move) # Replace with function body.
	area = Area2D.new()
	add_child(area)
	ghost = AnimatedSprite2D.new()
	add_child(ghost)
	ghost.sprite_frames = load("res://droneframes.tres")
	ghost.global_scale = Vector2.ONE
	ghost.scale = Vector2.ONE/4.0
	ghost.top_level = true

func _ready() -> void:
	$Sprite2D.free()
	var sprite = AnimatedSprite2D.new()
	add_child(sprite)
	sprite.name = "Sprite2D"
	sprite.visibility_layer = 9
	sprite.sprite_frames = load("res://droneframes.tres")
	sprite.global_scale = Vector2.ONE
	shader_material = ShaderMaterial.new()
	var rand = Vector4(randf_range(.1,1),randf_range(.1,1),randf_range(.1,1),1)
	shader_material.shader = preload('res://roboshade.gdshader')
	shader_material.set_shader_parameter("rand", rand)
	$Sprite2D.material = shader_material
	print($Sprite2D)
	for i in get_children():
		if i is Button:
			but = true
	g.robots = true
	area.add_child($CollisionShape2D.duplicate())
	area.collision_mask = 5
	ghost.play("ghost")
	ghost.modulate.a = .8
	ghost.hide()
	if but:
		$"Button".pressed.connect(kill)
		print(position) # Replace with function body.
	global_position = round(global_position/32)*32
	prevplace = global_position


func kill():
	if g.lvlediting:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if g.playerpos == &"door":
		$Sprite2D.play_backwards()
		droneplay = true
	elif droneplay && g.playerpos == &"box":
		droneplay = false
		$Sprite2D.play()
		print("falling")
	if g.playerpos != &"box" and g.playerpos != &"door":
		$Sprite2D.stop()
		droneplay = true
	if buggy:
		if not randi()%10:
			add_child(load("glitch.tscn").instantiate())
	modulate = Color.WHITE
	if Input.is_action_pressed("all"):
		if g.playerpos == &"box":
			if Input.is_action_just_pressed("left"):
				moves.append(Vector2.LEFT*32)
				alltick +=1
			if Input.is_action_just_pressed("right"):
				moves.append(Vector2.RIGHT*32)
				alltick +=1
			if Input.is_action_just_pressed("up"):
				moves.append(Vector2.UP*32)
				alltick +=1
			if Input.is_action_just_pressed("down"):
				moves.append(Vector2.DOWN*32)
				alltick +=1
			if Input.is_action_just_pressed("cancel"):
				moves.append(Vector2.ZERO)
				alltick +=1
			if Input.is_action_just_pressed("pickup"):
				moves.append("pickup")
				alltick +=1
			if Input.is_action_just_pressed("putdown"):
				moves.append("putdown")
				alltick +=1
			if Input.is_action_just_pressed("backspace") and alltick > 0:
				moves.pop_back()
				alltick -= 1
	if g.lvlediting:
		if but:
			$Button.mouse_filter = Control.MOUSE_FILTER_STOP
			$Control.mouse_filter = Control.MOUSE_FILTER_IGNORE
		var good = (position-$"/root/Main/Lvl Editor/Griddisplay".position)
		if good.x > g.lvleditsize.x or good.y > g.lvleditsize.y:
			queue_free()
	else:
		if but:
			$Control.mouse_filter = Control.MOUSE_FILTER_STOP
			$Button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if $Control.has_focus() and g.playerpos == &"box" and not g.lvlediting:
		g.focus = $"."
	if g.focus == $".":
		if prevplace != global_position:
			ghost.position = prevplace
			ghost.show()
		else:
			ghost.hide()
		shader_material.set_shader_parameter("highlight", true)
		if g.playerpos == &"box" and not Input.is_action_pressed("all"):
			if Input.is_action_just_pressed("left"):
				moves.append(Vector2.LEFT*32)
				g.waiter = false
				alltick = 0
			if Input.is_action_just_pressed("right"):
				moves.append(Vector2.RIGHT*32)
				g.waiter = false
				
				alltick = 0
			if Input.is_action_just_pressed("up"):
				moves.append(Vector2.UP*32)
				g.waiter = false
				if not Input.is_action_pressed("all"):
					alltick = 0
			if Input.is_action_just_pressed("down"):
				moves.append(Vector2.DOWN*32)
				g.waiter = false
				if not Input.is_action_pressed("all"):
					alltick = 0
			if Input.is_action_just_pressed("cancel"):
				moves.append(Vector2.ZERO)
				g.waiter = false
				if not Input.is_action_pressed("all"):
					alltick = 0
			if Input.is_action_just_pressed("pickup"):
				moves.append("pickup")
				g.waiter = false
				if not Input.is_action_pressed("all"):
					alltick = 0
			if Input.is_action_just_pressed("putdown"):
				moves.append("putdown")
				g.waiter = false
				if not Input.is_action_pressed("all"):
					alltick = 0
				
			if Input.is_action_just_pressed("backspace"):
				moves.pop_back()
				if not Input.is_action_pressed("all"):
					alltick = 0
		if buggy < 2:
			g.text = moves
		g.pointer = pointer
		collision_layer = 1
		g.lastmoves = lastcommands
		if currentitem:
			g.held = g.itemtype
		else:
			g.held = "nothing"

	else:
		shader_material.set_shader_parameter("highlight", false)
		collision_layer = 3
		ghost.hide()
	global_position = round(global_position/32)*32
	if area.get_overlapping_bodies().size() > 1:
		position -= lastmove
		lastmove = Vector2.ZERO
	#if name == &"Robot4":
#print(moves)
	if g.playerpos == &"door" and not savedtext:
		savedtext = true
		lastcommands = use.duplicate_deep()
	else:
		savedtext = false
	if not ghostcheck:
		ghostcheck = 2
		prevplace = global_position
	if g.playerpos == &"box" and ghostcheck == 2:
		ghostcheck -=1
	if g.playerpos == &"door" and ghostcheck == 1:
		ghostcheck -= 1
		
	if g.longest < moves.size()  - (pointer+1):
		g.longest = moves.size()  - (pointer+1)
	
	

func move():
	if not moving:
		prevplace = global_position
		moving = true
		g.newposses.clear()
		use = moves
		collision_layer = 1
		for i in 999:
			await g.tick
			collision_layer = 3
			if use.size() <= pointer+1:
				moving = false
				pointer = -1
				moves.clear()
				return
			pointer +=1
			if use.get(pointer) is Vector2:
				g.newposses.append(position+use.get(pointer))
				await get_tree().physics_frame
				if g.playerpos == &"door":
					if not g.newposses.count(position+use.get(pointer)) > 1:
						lastmove = use.get(pointer)
						position += (use.get(pointer))
						g.newposses.clear()
				else:
					for x in i+1:
						use.pop_front()
					moves = use.duplicate_deep()
					moving = false
					pointer = -1
					return
			else:
				g.newposses.append(position)
				lastmove = Vector2.ZERO
				if use.get(pointer) == &"pickup":
					if area.get_overlapping_areas():
						var lastitem = currentitem
						currentitem = area.get_overlapping_areas().front().get_parent()
						g.itemposses[currentitem] = "held"
						if lastitem:
							g.itemposses[lastitem] = position
				elif use.get(pointer) == &"putdown":
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
