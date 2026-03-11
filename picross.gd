extends RichTextLabel
@export var xy = true ##off is y, on is x
@export var num = 1 ##range of 1 to 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	num -= 1 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if xy:
		text = g.phonevars[8]["x"].get(num)
	else:
		text = g.phonevars[8]["y"].get(num)
		print(g.phonevars[8])
#	text = "AA"
