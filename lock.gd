extends Button
class_name lock
var locked = false
var num
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	g.lock.connect(locker) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func locker(a,b,c):
	if [a,b,c].has(num):
		locked = true
