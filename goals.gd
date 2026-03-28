extends Node2D
var filled = true
var herewait = false
@export var charger = false ##if false, detects items. if true, robots
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	filled = false
	g.goals +=1
	$Button.pressed.connect(kill)


func kill():
	if g.lvlediting:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if filled and not charger:
		if g.itemtype == "laundry":
			$Sprite2D.play("laundry")
		else:
			$Sprite2D.stop()
			$Sprite2D.animation = "default"
			$Sprite2D.frame = {"books":3,"dishes":4}[g.itemtype]
			
	elif not charger:
			$Sprite2D.stop()
			$Sprite2D.animation = "default"
			$Sprite2D.frame = {"books":0,"dishes":1,"laundry":2}[g.itemtype]
	if g.focus:
		if g.focus.global_position.distance_to(global_position) < 32:
			g.ongoal = true
	if g.lvlediting:
		$Button.mouse_filter = Control.MOUSE_FILTER_STOP
		var good = (position-$"/root/Main/Lvl Editor/Griddisplay".position)
		if good.x > g.lvleditsize.x or good.y > g.lvleditsize.y:
			queue_free()
	else:
		if $Button:
			$Button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	global_position = round(global_position/32)*32
	if ($Area2D.get_overlapping_areas() and not charger) or ($Area2D.get_overlapping_bodies() and charger):
		await get_tree().process_frame
		if ($Area2D.get_overlapping_areas() and not charger) or ($Area2D.get_overlapping_bodies() and charger):
			if not filled:
				filled = true
				g.goals -= 1
				if not charger:
					g.itemposses[$Area2D.get_overlapping_areas().front().get_parent()] = "Held"
				if g.goals == 0:
					herewait = true
	else:
		if filled:
			filled = false
			g.goals +=1
	if herewait and g.playerpos != &"door":
		g.lvltext.emit()
		herewait = false

func _exit_tree() -> void:
	if not filled:
		g.goals -= 1
