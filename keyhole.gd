extends Button
var wait = false
# Called when the node enters the scene tree for the first time.
func _init() -> void:
	pressed.connect(open) # Replace with function body.

func _process(delta: float) -> void:
	for i in 50:
		global_position = get_meta("pos")*128
	show()
	for i in g.truelockposses:
		if g.truelockposses[i] != null:
			if i > 1:
				if g.truelockposses[i].distance_to( get_meta("pos")*128) < 64:
					hide()
	if get_meta("pos") == $"..".newpos and not visible:
		$"..".relock()

func open():
	get_child(0).frame = 0
	get_child(0).play()
	await get_child(0).animation_finished
	if get_meta("pos") == $"..".newpos:
		$"..".delock()
	else:
		$"..".bad()
	wait = false
	
