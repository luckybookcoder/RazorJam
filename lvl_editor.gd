extends Node2D
var kiddo
var kid
var kids = {"ITEM":load("res://items.tscn"), "GOAL":load("res://goal.tscn"), "WALL": load('res://wall.tscn')}
var robs = {0:load("res://robot.gd"),1:load("res://rotrobotclock.gd"),2:load("res://rotrobocounter.gd"), 3:load("res://oprobot.gd"), 4:load("res://reverserobot.gd"),5:load("res://droprobot.gd"), 6:load("res://startrobot.gd")}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func clone(pos:Vector2, num := 2):
	if g.lvleditem:
		if g.lvleditem is int:
			kiddo = load("res://roblvledit.tscn").instantiate()
			add_child(kiddo)
			kid = kiddo.get_node("Robot")
			if g.lvleditem == 6:
				kid.set_script(load("res://droprobot.gd"))
				kid.droppoint = 0
			else:
				kid.set_script(robs[g.lvleditem])
				if "count" in robs[g.lvleditem]:
					kid.count = num
			kid.position = pos
		elif g.lvleditem != "ERASE":
			kid = kids[g.lvleditem].instantiate()
			add_child(kid)
			kid.position = pos
