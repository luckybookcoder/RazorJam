extends Node
signal tick
signal move
var text = []
var longest = 12
var tickwait = false
var newposses = []
var playerpos = &"box"
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if not tickwait:
		tickwait = true
		await wait(.4)
		tick.emit()
		tickwait = false
	if Input.is_action_just_pressed("ui_accept"):
		move.emit()
	print(longest)

func wait(time):
	await get_tree().create_timer(time).timeout
