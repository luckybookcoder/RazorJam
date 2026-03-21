extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lvl()
	xtra() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	g.playerpos = &"menu"

func lvl():
	await $Levels.pressed
	if g.lvl is int:
		g.lvl -= 1
	$"..".endlvl()
	g.playerpos = &"box"
	queue_free()

func xtra():
	await $Extras.pressed
	$"..".extras()
	queue_free()
