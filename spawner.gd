extends Node2D
var popup
var inc = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu()
	g.endlvl.connect(endlvl)
	g.lvltext.connect(lvlend)
	g.playerpos = &"menu"

func menu():
	if g.playerpos != &"menu":
		for i in get_children():
			if i != $Canla:
				i.queue_free()
		add_child(load("menu.tscn").instantiate())
		$Canla.hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset") and g.reset and g.lvl:
		if not g.lvl is String:
			g.lvl -= 1
		g.time = min(g.time, g.oldtime+3)
		g.endlvl.emit()
	if Input.is_action_just_pressed("pause") and g.playerpos != &"menu":
		add_child(load('pause.tscn').instantiate())

func endlvl():
	g.longest = 0
	if g.lvl is int:
		g.lvl += 1
	g.oldtime = g.time
	if get_children().has(popup):
		popup.queue_free()
	$Canla.show()
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

func extras():
	add_child(load("extras.tscn").instantiate())
