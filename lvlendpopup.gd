extends Node2D
var lerper = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Popup/Reset.button_down.connect(same) # Replace with function body.
	$Popup/Continue.button_down.connect(next)
	$Popup/Menu.button_down.connect(menu)

func _process(delta: float) -> void:
	await get_tree().process_frame;await get_tree().process_frame;await get_tree().process_frame;await get_tree().process_frame
	print(g.earned)
	lerper = lerp(float(lerper),g.earned[g.lvl],.25)
	if abs(lerper-g.earned[g.lvl]) < .05:
		lerper = g.earned[g.lvl]
	lerper = snapped(lerper, .01)
	$"Popup/Moneh".text = str("Money Earned: $",lerper)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func next():
	g.endlvl.emit()

func same():
	if g.lvl is int:
		g.lvl -= 1
	g.endlvl.emit()

func menu():
	$"..".menu()
