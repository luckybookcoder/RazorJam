extends RichTextLabel
var texter :Array[String]=[]
var empty = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in g.text:
		g.ticksleft += 1
		texter.append({Vector2(0,-32):"^",Vector2(0,32):"v",Vector2(-32,0):"<",Vector2(32,0):">",Vector2(0,-64):"^",Vector2(0,64):"v",Vector2(-64,0):"<",Vector2(64,0):">",Vector2.ZERO:"X", "pickup":"PU", "putdown":"PD"}[i])
	var s = "Current commands: "
	for i in g.pointer+1:
		texter.pop_front()
		g.ticksleft -= 1
	for i in texter:
		s += i
		if i:
			empty = false
	if empty:
		s = 'Current commands: Nothing'
	text = s
	empty = true
	texter = []
	if g.focus and g.playerpos == &"box":
		show()
	else:
		hide()
