extends CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shape.size[get_parent().name] = get_node("..").get_node("..").value*32
	position[get_parent().name] = (get_node("..").get_node("..").value*16)
	if name == "left":
		position.y += 32
	
