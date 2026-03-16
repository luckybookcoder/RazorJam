extends lock
var shift = 0
var correct = &"CATS"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec() -> void:
	num = 9
	if not locked:
		shift = randi()%25 + 1
		var x = ""
		$TextEdit.text = ''
		for i in randi_range(3,5):
			x += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"[randi()%26]
		correct = x
	#show()
	if $TextEdit.has_focus():
		g.reset = false
		g.reset2 = false
		if Input.is_key_label_pressed(KEY_ESCAPE):
			set_focus_mode(Control.FOCUS_ALL)
			grab_focus()
			set_focus_mode(Control.FOCUS_NONE)
	else:
		g.reset2 = true
	var result = &""
	for i in correct.length():
		var char_code = correct.unicode_at(i)
		if char_code >= 65 and char_code <= 90:
			result += char((char_code - 65 + shift) % 26 + 65)
		elif char_code >= 97 and char_code <= 122:
			result += char((char_code - 97 + shift) % 26 + 97)
	$RichTextLabel.text = str(result, "\n", correct)
	if ($TextEdit.text).capitalize() == (correct).capitalize():
		unlock()
	elif $TextEdit.text.length() == correct.length():
		$TextEdit.text = ""
		g.tick.emit()
		
	if locked:
		var phone = ((26-shift))
		phone = (wrapi(int(phone),-13, 13))
		if (phone) > 0:
			phone = str("+", phone)
		phoneify(str(phone))
	
