extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	g.itemposses.get_or_add($".", position)
	$Button.pressed.connect(kill)
	g.items += 1
	$Sprite2D.texture = {"books":load("sprites/books.png"), "laundry":load("res://sprites/laundry.png"), "dishes":load("res://sprites/dishes.png")}[g.itemtype]
	


func kill():
	if g.lvlediting:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Sprite2D.texture = {"books":load("sprites/books.png"), "laundry":load("res://sprites/laundry.png"), "dishes":load("res://sprites/dishes.png")}[g.itemtype]
	#$Sprite2D.scale = Vector2.ONE*2
	if g.focus:
		if g.focus.global_position.distance_to(global_position) < 32:
			g.onitem = true
	if g.lvlediting:
		$Button.mouse_filter = Control.MOUSE_FILTER_STOP
		var good = (position-$"/root/Main/Lvl Editor/Griddisplay".position)
		if good.x > g.lvleditsize.x or good.y > g.lvleditsize.y:
			queue_free()
	else:
		if $Button:
			$Button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if g.itemposses[$"."] is Vector2:
		position = g.itemposses[$"."]
		show()
	else:
		hide()
	position = round(position/32)*32

func _exit_tree() -> void:
	g.items -= 1
