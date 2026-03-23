extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		i.pressed.connect(but, CONNECT_APPEND_SOURCE_OBJECT) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = g.phone
	for i in get_children():
		if g.locks.has(int(i.name)):
			i.mouse_filter = MOUSE_FILTER_PASS
			var num = 0
			for x in g.locks:
				if x < int(i.name):
					num += {1:2.5,2:1,3:4.5,4:1,5:3,6:1,7:5,8:4.5,9:1}[x]
			i.position.y = 9+num*18
			i.show()
		else:
			i.mouse_filter = MOUSE_FILTER_IGNORE
			i.get_child(0).hide()

func but(num:Node):
	num.get_child(0).show()
	#hideall(num)

func hideall(num:Node):
	for i in get_children():
		if i != num:
			i.get_child(0).hide()
