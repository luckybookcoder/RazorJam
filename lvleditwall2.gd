extends CollisionShape2D
var other

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent().name == "x":
		other = "y"
	else:
		other = "x" # Replace with function body

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shape.size[get_parent().name] = get_node("..").get_node("..").value*32
	position[get_parent().name] = get_node("..").get_node("..").value*16
	if other == "y":
		position[other] = get_node("/root/Main/Lvl Editor/Griddisplay/HEIGHT").value*32 +16
	else:
		position[other] = get_node("/root/Main/Lvl Editor/Griddisplay/WIDTH").value*32 +16
	position.y += 32
	#print(other)
