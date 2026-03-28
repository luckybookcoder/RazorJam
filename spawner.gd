extends Node2D
var popup
var inc = 0
var pause
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu()
	g.endlvl.connect(endlvl)
	g.lvltext.connect(lvlend)
	g.playerpos = &"menu"

func menu():
	if g.playerpos != &"menu":
		for i in get_children():
			if i != $Canla and i != $Mainmusic:
				i.queue_free()
		add_child(load("menu.tscn").instantiate())
		$Canla.hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset") and g.reset and g.lvl:
		if g.lvl is String:
			g.waiter = false
			g.endlvl.emit()
			for i in 3:
				await get_tree().process_frame
				#g.lvlediting = true
		else:
			g.lvl -= 1
			g.endlvl.emit()
	$Mainmusic.volume_linear = g.volume
	if g.playerpos == &"box" or g.playerpos == &"door" or g.playerpos == &"text" or is_instance_valid(pause):
		if $Mainmusic.stream == load("res://null.mp3"):
			$Mainmusic.stop()
			
		if not $"Mainmusic".playing:
			$Mainmusic.stream = load("res://Drones.mp3")
			$"Mainmusic".play()
		#AudioStreamPlayer
	else:
		if $Mainmusic.stream == load("res://Drones.mp3"):
			$Mainmusic.stop()
		if not $"Mainmusic".playing:
			$Mainmusic.stream = load("res://null.mp3")
			$"Mainmusic".play()
	if Input.is_action_just_pressed("pause") and g.playerpos != &"menu" and g.playerpos != &"text":
		pause = load('pause.tscn').instantiate()
		add_child(pause)


func endlvl():
	g.longest = 0
	if g.lvl is int:
		g.lvl += 1
	g.time = 0
	if get_children().has(popup):
		popup.queue_free()
	$Canla.show()
	$"Canla/Dore controls".hide()
	#await get_tree().process_frame
	#await get_tree().process_frame
	#await get_tree().process_frame
	add_child(g.lvlitems[g.lvl].instantiate())
	g.locked = false
	g.playerpos = &"box"
	g.focus = null
	if g.lvl is String:
		for i in 3:
			await get_tree().process_frame
			#g.lvlediting = true


func lvlend():
	popup = load("res://lvlend.tscn").instantiate()
	add_child(popup)
	g.lvlsdone.set(g.lvl, true)

func extras():
	add_child(load("extras.tscn").instantiate())
	g.playerpos = &"menu"
