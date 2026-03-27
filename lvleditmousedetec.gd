extends Control
var mousing = false
signal clone
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(mousin)
	mouse_exited.connect(mousout)
	clone.connect(get_parent().get_parent().clone)
	$Button.button_down.connect(input) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	size = Vector2($"../WIDTH".value,$"../HEIGHT".value)*32
	$Button.size = size
	if g.lvlediting:
		mouse_filter = Control.MOUSE_FILTER_PASS
		$Button.mouse_filter = Control.MOUSE_FILTER_PASS
	else:
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		$Button.mouse_filter = Control.MOUSE_FILTER_IGNORE

func input() -> void:
			clone.emit(get_global_mouse_position())
			#print(913018410)

func mousin():
	mousing = true
func mousout():
	mousing = false
