@tool
extends GridDisplay


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in 21:
		for y in 17:
			var sprite =Sprite2D.new()
			add_child(sprite)
			sprite.texture = load("res://sprites/pixil-frame-0(35).png")
			sprite.set_meta("pos", Vector2(x,y)) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	grid_size = Vector2($WIDTH.value, $HEIGHT.value)
	if not Engine.is_editor_hint():
		g.lvleditsize = Vector2($WIDTH.value, $HEIGHT.value)*32
	for i in get_children():
		if i.has_meta("pos"):
			var pos = i.get_meta("pos")
			i.position = pos*32
			if (pos.y == 0 and pos.x <= $WIDTH.value) or (pos.x == 0 and pos.y <= $HEIGHT.value):
				i.show()
			elif (pos.x <= $WIDTH.value + 1 and pos.y == $HEIGHT.value+ 1) or (pos.y <= $HEIGHT.value + 1 and pos.x == $WIDTH.value + 1):
				i.show()
			else:
				i.hide()
			i.position -= Vector2.ONE * 16
		else:
			if not Engine.is_editor_hint():
				if g.lvlediting:
					i.show()
				else:
					i.hide()
