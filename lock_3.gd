extends lock
var wait = false
var clicked = {1:true,2:true,3:true}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec() -> void:
	num = 3
	if not locked:
		$Goodbutton1.modulate = Color(1,1,1,1)
		$Goodbutton2.modulate = Color(1,1,1,1)
		$Goodbutton3.modulate = Color(1,1,1,1)
		clicked = {1:true,2:true,3:true}
		$Goodbutton1.position = Vector2(1%6,1%6)*21.5
		$Goodbutton2.position = Vector2(randi()%6,randi()%6)*21.5
		while $Goodbutton2.position.distance_to($Goodbutton1.position) < 1:
			$Goodbutton2.position = Vector2(randi()%6,randi()%6)*21.5
		$Goodbutton3.position = Vector2(randi()%6,randi()%6)*21.5
		while $Goodbutton3.position.distance_to($Goodbutton1.position) < 1 or $Goodbutton3.position.distance_to($Goodbutton2.position) < 5:
			$Goodbutton3.position = Vector2(randi()%6,randi()%6)*21.5
	if not clicked.find_key(true):
		unlock()
	click1()
	click2()
	click3()

func click1():
	await $Goodbutton1.button_down
	clicked[1] = false
	$Goodbutton1.modulate = Color(0.0, 100.0, 0.0, 1.0)
	print($Goodbutton1.modulate)
func click2():
	await $Goodbutton2.button_down
	clicked[2] = false
	$Goodbutton2.modulate = Color(0.0, 100.0, 0.0, 1.0)
func click3():
	await $Goodbutton3.button_down
	clicked[3] = false
	$Goodbutton3.modulate = Color(0.0, 100.0, 0.0, 1.0)
