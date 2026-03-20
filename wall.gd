extends Node2D

func _ready() -> void:
	$Button.pressed.connect(kill)


func kill():
	if g.lvlediting:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = round(position/32)*32
	if g.lvlediting:
		$Button.mouse_filter = Control.MOUSE_FILTER_STOP
		var good = (position-$"/root/Main/Lvl Editor/Griddisplay".position)
		if good.x > g.lvleditsize.x or good.y > g.lvleditsize.y:
			queue_free()
	else:
		buttonoff()
		
func buttonoff():
		if $Button:
			$Button.mouse_filter = Control.MOUSE_FILTER_IGNORE
# Called when the node enters the scene tree for the first time.
