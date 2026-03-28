extends Button
var dict



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await pressed
	if not dict:
		dict = str_to_var($TextEdit.text)
		if not dict is Dictionary:
			dict = null
			return
		for i in dict.keys():
			if not i in ["WALLS", "GLITCHES", "DOORS", "ROBOTS", "ITEMS", "GOALS", "CHARGERS", "COUNTS", "HEIGHT", "WIDTH"]:
				dict.erase(i)
				
				print(i, dict)
		for i in ["WALLS", "GLITCHES", "DOORS", "ROBOTS", "ITEMS", "GOALS", "CHARGERS", "COUNTS", "HEIGHT", "WIDTH"]:
			dict.get_or_add(i, null)
		$"..".savedict = dict
		$"..".lvload(dict)
