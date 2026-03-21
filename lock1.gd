extends lock
var turnwait = false
var newpos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	var shader_material = ShaderMaterial.new()
	shader_material.shader = preload('res://new_shader.gdshader')
	for x in 8:
		var button
		var sprite
		for y in 5:
			button = Button.new()
			sprite = AnimatedSprite2D.new()
			add_child(button)
			button.set_meta("pos",Vector2(x,y))
			button.add_child(sprite)
			sprite.position = Vector2.ONE*64
			sprite.material = shader_material
			sprite.sprite_frames = preload("res://keyframes(heh).tres")
			sprite.set_animation("default")
			sprite.frame = 5
			button.self_modulate.a = 0
			button.set_process(true)
			button.set_script(preload("res://keyhole.gd"))
			button.size = Vector2.ONE * 128
			if not g.lockposses.has(button.get_meta("pos")):
				button.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec() -> void:
	if position != Vector2.LEFT:
		newpos = position/128
	position = Vector2.LEFT
	num = 1
	if locked:
		phoneify(str(int(newpos.x), ">, ", int(newpos.y), "v"))

func bad():
	posset = true
	if not g.realtime:
		g.tick.emit()

func delock():
	if locked == true:
		for i in 10:
			modulate.a -= .1
			await get_tree().process_frame
		locked = false
		modulate.a = 1
		g.locked -= 1
		if not g.realtime:
			g.tick.emit()
