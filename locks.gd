extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		print(i.name)
		i.pressed.connect(button,CONNECT_APPEND_SOURCE_OBJECT) # Replace with function body.

func _process(delta: float) -> void:
	if not g.locks.size():
		for i in get_children():
			i.show()
	else:
		#print(g.phone)
		$'/root/Main/Canla/Dore controls/Phone'.show()
		$'/root/Main/Canla/Dore controls'.show()
		$'/root/Main/Canla'.show()
		for i in $'/root/Main/Canla/Dore controls/Phone'.get_children():
			i.show()

func button(num:Node):
	if num == $Menu:
		g.playerpos = &"transfer"
		$"..".menu()
		for i in $'/root/Main/Canla/Dore controls/Locks'.get_children():
			i.unlock()
		queue_free()
	else:
		g.locked = 1
		print(g.locks)
		g.lock.emit({$Button1:1,$Button2:2,$Button3:3,$Button4:4,$Button5:5,$Button6:6,$Button7:7,$Button8:8,$Button9:9}[num],0,0)
		for i in get_children():
			if not num == $Menu:
				i.hide()
	($Menu.show())
