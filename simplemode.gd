extends Button
var toggle = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if g.simplemode:
		toggle = 1
	else:
		toggle = 0 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if toggle%2:
		g.simplemode = true
		text = "Simpler gameplay:On"
	else:
		g.simplemode = false
		text = "Simpler gameplay:Off"


func _on_pressed() -> void:
	toggle +=1  # Replace with function body.
