extends Node2D
var popup
var inc = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(load("menu.tscn").instantiate())
	$Canla.hide() # Replace with function body.
	g.endlvl.connect(endlvl)
	g.lvltext.connect(lvlend)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset") and g.reset:
		g.lvl -= 1
		g.endlvl.emit()
		g.time = min(g.time, g.oldtime+3)

func endlvl():
	g.lvl += 1
	g.oldtime = g.time
	if get_children().has(popup):
		popup.queue_free()
	#await get_tree().process_frame
	#await get_tree().process_frame
	#await get_tree().process_frame
	add_child(g.lvlitems[g.lvl].instantiate())
	g.locked = false
	g.playerpos = &"box"
	g.focus = null


func lvlend():
	popup = load("res://lvlend.tscn").instantiate()
	add_child(popup)
