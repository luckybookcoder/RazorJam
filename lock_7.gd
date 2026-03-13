extends lock
var shift = 0
var correct = &"CATS"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec() -> void:
	num = 8
	if not locked:
		#shift = randi()%25 + 1
		var x = ""
		for i in randi_range(4,8):
			x += char(("abcdefghijklmnopqrstuvwxyz".unicode_at(randi()%26) - 65) % 26 + 65)
		correct = x
	#show()
	if $TextEdit.has_focus():
		g.reset = false
		g.reset2 = false
	else:
		g.reset2 = true
	var result = &""
	for i in correct.length():
		var char_code = correct.unicode_at(i)
		if char_code >= 65 and char_code <= 90:
			result += char((char_code - 65 + shift) % 26 + 65)
		elif char_code >= 97 and char_code <= 122:
			result += char((char_code - 97 + shift) % 26 + 97)
	$RichTextLabel.text = result
	if ($TextEdit.text).capitalize() == (correct).capitalize():
		print("Y")
	
