extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is Button:
			i.set_meta("num", int(i.name)-1)
			i.pressed.connect(start, CONNECT_APPEND_SOURCE_OBJECT) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in get_children():
		if i is Button:
			if g.lvlsdone[i.get_meta("num")]:
				i.disabled = false
			else:
				i.disabled = true
			if g.earned.has(i.get_meta("num")+1):
				i.get_child(0).text = str("Earned in this level:$",snapped(g.earned[i.get_meta("num")+1],.01))
			else:
				i.get_child(0).text = ''
		else:
			var moneh :float= 0
			for cash in g.earned:
				moneh += g.earned[cash]
			i.text = str('Total money earned: $', snapped(moneh,.01))

func start(level:Node):
	g.lvl = level.get_meta("num")
	g.endlvl.emit()
	queue_free()
