extends lock
var correct = ''
var result


# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec() -> void:
	num = 6
	if not locked:
		$TextEdit.text = ''
		result = ""
		var x = ""
		var arr = ["a",'b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y',"z"]
		for i in randi_range(4,8):
			x += arr.pop_at(randi()%arr.size())
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
	else:
		var numed = ""
		for i in result:
			var numer = correct.find(i)
			numed += str(numer+1)
		phoneify(numed)
	if $TextEdit.has_focus():
		g.reset = false
		g.reset1 = false
		if Input.is_key_label_pressed(KEY_ESCAPE):
			set_focus_mode(Control.FOCUS_ALL)
			grab_focus()
			set_focus_mode(Control.FOCUS_NONE)
	else:
		g.reset1 = true
	#show()
	if ($TextEdit.text).to_lower() == (correct).to_lower():
		unlock()
	elif ($TextEdit.text).length() == (correct).length():
		$TextEdit.text = ''
		result = ""
		var x = ""
		var arr = ["a",'b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y',"z"]
		for i in randi_range(4,8):
			x += arr.pop_at(randi()%arr.size())
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
	$RichTextLabel.text = str(result)
	if g.playerpos == &"door":
		print("Output:",result,"Correct:",correct)
