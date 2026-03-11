extends lock
var wait = true
var clicked = {1:true,2:true,3:true,4:true,5:true}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec() -> void:
	num = 7
	if not locked:
		reset()
	if not clicked.find_key(true):
		unlock()
	click1()
	click2()
	click3()
	click4()
	click5()
	badclick()
	var text = ""
	var pos1 = $Goodbutton1.position/21.5
	var pos2 = $Goodbutton2.position/21.5
	var pos3 = $Goodbutton3.position/21.5
	var pos4 = $Goodbutton4.position/21.5
	var pos5 = $Goodbutton5.position/21.5
	var textnum := 0
	for y in Vector2(6,6).x:
		for x in Vector2(6,6).y:
			if Vector2(x,y).distance_to(pos1) <=1:# and Vector2(x,y) != pos1:
				textnum += 1
			if Vector2(x,y).distance_to(pos2) <=1:#and Vector2(x,y) != pos2:
				textnum += 1
			if Vector2(x,y).distance_to(pos3) <=1:# and Vector2(x,y) != pos3:
				textnum += 1
			if Vector2(x,y).distance_to(pos4) <=1:#and Vector2(x,y) != pos4:
				textnum += 1
			if Vector2(x,y).distance_to(pos5) <=1:# and Vector2(x,y) != pos5:
				textnum += 1
			if textnum:
				text += str(textnum)
			else:
				text += "x"
			textnum = 0
		text += "\n"
	if locked:
		phoneify(text)

func reset():
		$Goodbutton1.modulate = Color(1,1,1,0)
		$Goodbutton2.modulate = Color(1,1,1,0)
		$Goodbutton3.modulate = Color(1,1,1,0)
		$Goodbutton4.modulate = Color(1,1,1,0)
		$Goodbutton5.modulate = Color(1,1,1,0)
		clicked = {1:true,2:true,3:true,4:true,5:true}
		$Goodbutton1.position = Vector2(1%6,1%6)*21.5
		$Goodbutton2.position = Vector2(randi()%6,randi()%6)*21.5
		while $Goodbutton2.position.distance_to($Goodbutton1.position) < 1:
			$Goodbutton2.position = Vector2(randi()%6,randi()%6)*21.5
		$Goodbutton3.position = Vector2(randi()%6,randi()%6)*21.5
		while $Goodbutton3.position.distance_to($Goodbutton1.position) < 1 or $Goodbutton3.position.distance_to($Goodbutton2.position) < 5:
			$Goodbutton3.position = Vector2(randi()%6,randi()%6)*21.5
		$Goodbutton4.position = Vector2(randi()%6,randi()%6)*21.5
		while $Goodbutton4.position.distance_to($Goodbutton1.position) < 1 or $Goodbutton4.position.distance_to($Goodbutton2.position) < 5 or $Goodbutton4.position.distance_to($Goodbutton3.position) < 1:
			$Goodbutton4.position = Vector2(randi()%6,randi()%6)*21.5
		$Goodbutton5.position = Vector2(randi()%6,randi()%6)*21.5
		while $Goodbutton5.position.distance_to($Goodbutton1.position) < 1 or $Goodbutton5.position.distance_to($Goodbutton2.position) < 5 or $Goodbutton5.position.distance_to($Goodbutton3.position) < 1 or $Goodbutton5.position.distance_to($Goodbutton4.position) < 5:
			$Goodbutton5.position = Vector2(randi()%6,randi()%6)*21.5

func badclick():
	if wait:
		wait = false
		await $Badbutton.button_down
		g.tick.emit()
		reset()
		wait = true

func click1():
	await $Goodbutton1.button_down
	clicked[1] = false
	$Goodbutton1.modulate = Color(0.0, 100.0, 0.0, 1.0)
func click2():
	await $Goodbutton2.button_down
	clicked[2] = false
	$Goodbutton2.modulate = Color(0.0, 100.0, 0.0, 1.0)
func click3():
	await $Goodbutton3.button_down
	clicked[3] = false
	$Goodbutton3.modulate = Color(0.0, 100.0, 0.0, 1.0)
func click4():
	await $Goodbutton4.button_down
	clicked[4] = false
	$Goodbutton4.modulate = Color(0.0, 100.0, 0.0, 1.0)
func click5():
	await $Goodbutton5.button_down
	clicked[5] = false
	$Goodbutton5.modulate = Color(0.0, 100.0, 0.0, 1.0)
