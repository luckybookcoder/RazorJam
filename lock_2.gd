extends lock
var key = []
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec() -> void:
	if not locked:
		key = [randi()%10,randi()%10,randi()%10]
		$Dial1.value = randi()%10
		$Dial2.value = randi()%10
		$Dial3.value = randi()%10
		while $Dial1.value == key.get(0) or $Dial2.value == key.get(1) or $Dial3.value == key.get(2):
			key = [randi()%10,randi()%10,randi()%10]
	num = 2
	if $Dial1.value == key.get(0) and $Dial2.value == key.get(1) and $Dial3.value == key.get(2):
		unlock()
	
	if $Dial1.value == key.get(0):
		$Dial1.editable = false
	else:
		$Dial1.editable = true
	if $Dial2.value == key.get(1):
		$Dial2.editable = false
	else:
		$Dial2.editable = true
	if $Dial3.value == key.get(2):
		$Dial3.editable = false
	else:
		$Dial3.editable = true
