extends AnimatedSprite2D
var ticker = 0
var framecheck = frame
var value = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Up.pressed.connect(up)
	$Down.pressed.connect(down) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not $"..".locked:
		frame = value*3
		framecheck = frame
		ticker = 0
	@warning_ignore("integer_division")
	value = frame/3
	if framecheck != frame:
		ticker += 1
		framecheck = frame
	if ticker == 3:
		ticker = 0
		pause()
	if is_playing():
		$Up.disabled = true
		$Down.disabled = true
	else:
		$Up.disabled = false
		$Down.disabled = false

func up():
	play()

func down():
	play_backwards()
