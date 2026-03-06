extends Node2D
var filled = 1
var herewait = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	filled = 0
	g.goals +=1


func kill():
	if g.lvleditem is String:
		if g.lvleditem == "ERASE":
			queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = round(global_position/32)*32
	if $Area2D.get_overlapping_areas():
		if not filled:
			filled = 1
			g.goals -= 1
			print()
			if g.goals == 0:
				herewait = true
	else:
		if filled:
			filled = 0
			g.goals +=1
	if herewait and g.playerpos != &"door":
		g.lvltext.emit()
		herewait = false
