extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = round(position/32)*32
	if g.lvlediting:
		var good = (position-$"/root/Main/Lvl Editor/Griddisplay".position)
		if good.x > g.lvleditsize.x or good.y > g.lvleditsize.y:
			queue_free()
# Called when the node enters the scene tree for the first time.

func kill():
	if g.lvleditem is String:
		if g.lvleditem == "ERASE":
			queue_free()
