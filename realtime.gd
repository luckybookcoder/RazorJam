extends Button
var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = g.realtime - 3 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time = time%4
	g.realtime = (time + 3)*10
	if g.realtime:
		text = str("Real Time(ish):",g.realtime, "s->1 min")
	else:
		text = "Real Time(ish):Off"


func _on_pressed() -> void:
	time -= 1 # Replace with function body.
