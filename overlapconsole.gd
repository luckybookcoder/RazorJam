extends RichTextLabel



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	g.onitem = false
	g.ondoor = false
	g.ongoal = false
	g.oncharge = false
	if g.playerpos == &"box" and g.focus:
		show()
	else:
		hide()
	var words = "Other objects:"
	await get_tree().process_frame
	for i in ["onitem","ondoor","ongoal","oncharge"]:
		if g.get(i):
			print(i, g.itemtype,g.goaltypes[g.itemtype])
			words += {"onitem":g.itemtype,'ondoor':"Door",'ongoal':g.goaltypes[g.itemtype],'oncharge':"Charging station"}[i]
	if words == "Other objects:":
		words += "Nothing"
	text = words
