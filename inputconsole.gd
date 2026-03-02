extends RichTextLabel
var texter :Array[String]=[]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in g.text:
		texter.append({Vector2(0,-32):"^",Vector2(0,32):"v",Vector2(-32,0):"<",Vector2(32,0):">",Vector2.ZERO:"X"}[i])
	var s = ""
	for i in texter:
		s += i
	text = s
	s = ""
	texter = []
