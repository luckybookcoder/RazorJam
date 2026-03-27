extends Node2D
var kiddo
var kid
var kids = {"ITEM":load("res://items.tscn"), "GOAL":load("res://goal.tscn"), "WALL": load('res://wall.tscn'), "DOOR":load("res://door.tscn"), "CHARGE": load('res://charge.tscn')}
var robs = {0:load("res://robot.gd"),1:load("res://rotrobotclock.gd"),2:load("res://rotrobocounter.gd"), 3:load("res://oprobot.gd"), 5:load("res://reverserobot.gd"),6:load("res://droprobot.gd"), 8:load("res://startrobot.gd"), 4:load("res://dubrobot.gd")}
var count = 2
var kidset = []
var savedict= {"HEIGHT":4, "WIDTH":4, }
var kiddict = []
var countsdict = {}
var subtypes = {}
var clipboard
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	name = "Lvl Editor"
	g.endlvl.connect(endlvl)
	$Button3.pressed.connect(lvload)
	for i in get_children():
		if i is robot:
			i.get_node("Control").tooltip_text = '' # Replace with function body.
	g.lvlediting = true
	g.items = 0
	g.robots = false
	g.playerpos = &"editor"

func _process(delta: float) -> void:
	name = "Lvl Editor"
	if g.lvleditem is int:
		if g.lvleditem == -1:
			g.lvleditem = null
	var kidcheck = []
	for i in get_children():
		if not i.is_in_group("lvleditors"):
			kidcheck.append(i)
	if kidcheck != kidset:
		$Button2.reset()
	kidset.clear()
	for i in get_children():
		if not i.is_in_group("lvleditors"):
			kidset.append(i)
	for i in get_children():
		if not i.is_in_group("lvleditors"):
			if i.get_meta("type") == "ITEM":
				kiddict.append(i.position)
	savedict.set("ITEMS", kiddict.duplicate())
	kiddict.clear()
	for i in get_children():
		if not i.is_in_group("lvleditors"):
			if i.get_meta("type") == "WALL":
				kiddict.append(i.position)
	savedict.set("WALLS", kiddict.duplicate())
	kiddict.clear()
	for i in get_children():
		if not i.is_in_group("lvleditors"):
			if i.get_meta("type") == "GOAL":
				kiddict.append(i.position)
	savedict.set("GOALS", kiddict.duplicate())
	kiddict.clear()
	for i in get_children():
		if not i.is_in_group("lvleditors"):
			if i.get_meta("type") == "ROBOT":
				if i.get_children().size():
					kiddict.append(i.get_node("Robot").position)
					subtypes.set(i.get_node("Robot").position, i.get_meta("bug"))
					if i.get("count"):
						countsdict.set(i.get_node("Robot").position, i.get("count"))
	savedict.set("ROBOTS", kiddict.duplicate())
	savedict.set("GLITCHES", subtypes)
	kiddict.clear()
	for i in get_children():
		if not i.is_in_group("lvleditors"):
			if i.get_meta("type") == "CHARGE":
				kiddict.append(i.position)
	savedict.set("CHARGERS", kiddict.duplicate())
	kiddict.clear()
	for i in get_children():
		if not i.is_in_group("lvleditors"):
			if i.get_meta("type") == "DOOR":
				kiddict.append(i.position)
				countsdict.set(i.position, i.get("count"))
	savedict.set("DOORS", kiddict.duplicate())
	kiddict.clear()
	savedict.WIDTH = $"Griddisplay/WIDTH".value
	savedict.HEIGHT = $"Griddisplay/HEIGHT".value
	savedict.set("COUNTS", countsdict)
	#print(savedict)

func clone(pos:Vector2):
	if g.lvleditem != null:
		if g.lvleditem is int:
			if g.lvleditem != -1:
				kiddo = load("res://roblvledit.tscn").instantiate()
				add_child(kiddo)
				kid = kiddo.get_node("Robot")
				if g.lvleditem == 7:
					kid.set_script(load("res://droprobot.gd"))
					kid.droppoint = 0
				elif robs[g.lvleditem]:
					kid.set_script(robs[g.lvleditem])
					if "count" in robs[g.lvleditem]:
						kid.count = count
			kid.position = pos
			kiddo.set_meta("type", "ROBOT")
			kiddo.set_meta("bug", g.lvleditem)
		elif g.lvleditem != "ERASE":
			kid = kids[g.lvleditem].instantiate()
			add_child(kid)
			if "count" in kid:
				kid.count = count
			if g.lvleditem == "ITEM":
				g.itemposses.set(kid, pos)
			kid.position = pos
			print(kid.position)
			kid.set_meta("type", g.lvleditem)

func endlvl():
	queue_free()

func lvload():
	print(clipboard)
	if clipboard:
		for i in get_children():
			if not i.is_in_group("lvleditors"):
				i.queue_free()
		$Griddisplay/HEIGHT.value = clipboard.HEIGHT
		$Griddisplay/WIDTH.value = clipboard.WIDTH
		for i in clipboard.WALLS:
			kid = kids.WALL.instantiate()
			add_child(kid)
			kid.position = i
			kid.set_meta("type", "WALL")
		for i in clipboard.DOORS:
			kid = kids.DOOR.instantiate()
			add_child(kid)
			kid.position = i
			kid.set_meta("type", "DOOR")
		for i in clipboard.ROBOTS:
			kid = load("res://roblvledit.tscn").instantiate()
			add_child(kid)
			kid.get_node("Robot").position = i
			kid.get_node("Robot").set_script( robs[
				savedict.GLITCHES[kid.get_node("Robot").position]
			])
			kid.set_meta("type",savedict.GLITCHES[kid.get_node("Robot").position])
			#print(kid.get_node("Robot").get_script())
	for i in get_children():
		for o in savedict.COUNTS:
			if i.position == o:
				i.count = savedict.COUNTS[o]

func _exit_tree() -> void:
	g.lvlediting = false
	g.items = 0
	g.robots = false
