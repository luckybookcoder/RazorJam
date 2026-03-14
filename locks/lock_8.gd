extends lock
var correct = ''
var result


# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec() -> void:
	if not locked:
		result = &""
		#shift = randi()%25 + 1
		var x = ""
		for i in randi_range(4,8):
			x += char("abcdefghijklmnopqrstuvwxyz".unicode_at(randi()%26))
		correct = x
		
		var array = []
		var pointer = 0
		var reverse
		array.resize(correct.length())
		for i in correct:
			var rand = randi()%array.size()
			while array.get(rand) is int:
				rand = randi()%array.size()
			result += String.chr(correct.unicode_at(rand))
			array.set(rand, pointer+1)
			pointer += 1
		reverse = correct
		correct = result
		result = reverse
	if $TextEdit.has_focus():
		g.reset = false
		g.reset1 = false
	else:
		g.reset1 = true
	num = 6
	#show()
	$RichTextLabel.text = result
	if ($TextEdit.text).capitalize() == (correct).capitalize():
		print("Y")
