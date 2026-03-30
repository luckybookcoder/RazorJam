extends AnimatedSprite2D
var oneshot = false
var text = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	g.endlvl.connect(reset) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not get_parent().visible:
		animation = "close"
		oneshot = false
		stop()
	if not g.playerpos == &"menu":
		if g.playerpos == &"door" and not oneshot and not is_playing():
			oneshot = true
			play("close")
		elif oneshot and g.playerpos == &"box" and not is_playing():
			if oneshot and g.playerpos == &"box" and not is_playing():
				play("open")
				oneshot = false
	if is_playing():
		match animation:
			"close":
				print("door closing")
			"open":
				print("door opening")
		$"../Locks".hide()
	else:
		if oneshot:
			$"../Locks".show()
	if g.playerpos == &"text":
		animation = "open"
		frame = 0
		text = true
		$"..".show()
	elif text:
		text = false
		play("open")
	if g.playerpos == &"menu":
		#oneshot = true
		pause()
		#animation = "open"
	#print(g.playerpos)

func reset():
	oneshot = true
	g.playerpos = &"box"
	animation = "open"
	pause()
	print(animation, oneshot, is_playing())
	frame = 4
