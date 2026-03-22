extends Node2D
@export var num:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	g.endlvl.connect(endlvl)
	for i in get_children():
		if i is robot:
			i.get_node("Control").tooltip_text = '' # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func endlvl():
	if g.lvl != num:
		g.lvlsdone[num] = true
		print(num)
	queue_free()
