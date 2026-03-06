extends RichTextLabel
var texter = []
var empty = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in g.lastmoves:
		texter.append({Vector2(0,-32):"^ ",Vector2(0,32):"v ",Vector2(-32,0):"< ",Vector2(32,0):"> ",Vector2(0,-64):"^ ",Vector2(0,64):"v ",Vector2(-64,0):"< ",Vector2(64,0):"> ",Vector2.ZERO:"X ", "pickup":"pickup ", "putdown":"putdown "}[i])
	var s = "Last commands: "
	for i in g.pointer-1-texter.size():
		texter.pop_back()
		print(g.pointer)
	for i in texter:
		s += i
		if i:
			empty = false
		
	text = s
	if g.focus and not empty:
		show()
	else:
		hide()
	empty = true
	texter = []
