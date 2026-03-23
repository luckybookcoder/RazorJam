extends AnimatedSprite2D
var oneshot = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	g.endlvl.connect(reset) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not get_parent().visible:
		animation = "close"
		oneshot = false
		stop()
	if get_parent().visible and not oneshot and not is_playing():
		#g.playerpos = &"door"
		oneshot = true
		play("close")
		print(oneshot, "should be true")
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

func reset():
	oneshot = false
	stop()
	animation = "close"

func animation_looped():
	print("why")
