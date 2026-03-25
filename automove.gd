extends Button
var toggle = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if g.automove:
		toggle = 1
	else:
		toggle = 0 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if toggle%2:
		g.automove = true
		text = "Automatically wait for all commands to finish:On"
	else:
		g.automove = false
		text = "Automatically wait for all commands to finish:Off"


func _on_pressed() -> void:
	toggle +=1  # Replace with function body.
