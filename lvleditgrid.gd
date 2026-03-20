@tool
extends GridDisplay


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	grid_size = Vector2($WIDTH.value, $HEIGHT.value)
	if not Engine.is_editor_hint():
		g.lvleditsize = Vector2($WIDTH.value, $HEIGHT.value)*32
	for i in get_children():
		
		if not Engine.is_editor_hint():
			if g.lvlediting:
				i.show()
			else:
				i.hide()
