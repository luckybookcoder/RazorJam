extends lock
var key = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	$Button.pressed.connect(pressed)

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
	$Text1.text = str(int($Dial1.value))
	$Text2.text = str(int($Dial2.value))
	$Text3.text = str(int($Dial3.value))
	if locked:
		var phoney = (key.get(0))*100+(key.get(1))*10+key.get(2)
		phoneify(phoney)

func pressed():
	if $Dial1.value == key.get(0) and $Dial2.value == key.get(1) and $Dial3.value == key.get(2):
		unlock()
	else:
		g.tick.emit()
		key = [randi()%10,randi()%10,randi()%10]
		while $Dial1.value == key.get(0) or $Dial2.value == key.get(1) or $Dial3.value == key.get(2):
			key = [randi()%10,randi()%10,randi()%10]
