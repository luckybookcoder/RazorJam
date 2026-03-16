extends lock
var ons = {
	"V1":false,"V2":false,"V3":false,
	"V4":false,"V5":false,"V6":false,
	"H1":false,"H2":false,"H3":false,
	"H4":false,"H5":false,"H6":false,
	"D1":false,"D2":false,"D3":false,"D4":false,
	"D5":false,"D6":false,"D7":false,"D8":false,}
var ticks = 0
@onready var butposses = {
	$Button1:Vector2(0,0), 
	$Button2:Vector2(1,0),
	$Button3:Vector2(2,0),
	$Button4:Vector2(0,1), 
	$Button5:Vector2(1,1),
	$Button6:Vector2(2,1),
	$Button7:Vector2(0,2), 
	$Button8:Vector2(1,2),
	$Button9:Vector2(2,2),}
const lines = {
	true:{
		Vector2(.5,0):"H1",Vector2(1.5,0):"H2",
		Vector2(.5,1):"H3",Vector2(1.5,1):"H4",
		Vector2(.5,2):"H5",Vector2(1.5,2):"H6",

		Vector2(0,.5):"V1",Vector2(0,1.5):"V2",
		Vector2(1,.5):"V4",Vector2(1,1.5):"V3",
		Vector2(2,.5):"V5",Vector2(2,1.5):"V6",

		Vector2(.5,.5):"D7", Vector2(1.5,.5):"D4",
		Vector2(.5,1.5):"D1", Vector2(1.5,1.5):"D6"},
	false:{
		Vector2(.5,0):"H1",Vector2(1.5,0):"H2",
		Vector2(.5,1):"H3",Vector2(1.5,1):"H4",
		Vector2(.5,2):"H5",Vector2(1.5,2):"H6",

		Vector2(0,.5):"V2",Vector2(0,1.5):"V1",
		Vector2(2,.5):"V6",Vector2(2,1.5):"V5",

		Vector2(.5,.5):"D3", Vector2(1.5,.5):"D8",
		Vector2(.5,1.5):"D5", Vector2(1.5,1.5):"D2"
		}}
const patterns = {
	1:["D2","D3","D5","D8"],
	2:["V2","V1","H5","H6","D6","D7"],
	3:["V1", "V2", "V5", "V6", "H1", "H2", "H5", "H6"],
	4:["V1", "V2", "V5", "V6", "H1", "H2", "H5", "H6", "D1", "D4", "D6", "D7"],
	5:["V1", "V2", "V5", "V6", "D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8"]
}
var but1
var but2
var rand

func _ready() -> void:
	super()
	for i in get_children():
		if i is Button:
			i.button_down.connect(Callable(self,i.name.replace("Button","b")))
var wait = false
func spec():
	num = 8
	if not locked:
		for i in ons:
			ons[i] = false
		ticks = 0
		rand = randi()%5+1
	var good = patterns[rand].size()
	var fails = 0
	for i in ons:
		if ons[i] == true:
			if i in patterns[rand]:
				good -= 1
			else:
				fails -= 1
	if fails < 0:
		g.tick.emit()
		for i in ons:
			ons[i] = false
		ticks = 0
		rand = randi()%5+1
	#if Input.is_action_just_pressed("cancel"):
		#var array = []
		#for i in ons:
			#if ons[i]:
				#array.append(i)
		#print(array)
		#*-*-*
		#|X|X|
		#*-*-*
		#|X|X|
		#*-*-*

	if good < 1:
		unlock()
	for i in get_children():
		if i is RichTextLabel:
			if ons[i.name]:
				i.modulate = Color(0.0, 18.892, 0.0, 1.0)
			else:
				(i).modulate = Color(1.0, 1.0, 1.0, 1.0)
		else:
			if but1:
				if butposses[but1].distance_to(butposses[i]) >= 2:
					i.disabled = true
					i.modulate = Color(18.892, 0.0, 0.0, 999)
				else:
					i.disabled = false
					if but1 == i:
						i.modulate = Color(0.0, 18.892, 0.0, 1.0)
					else:
						i.modulate = Color(0.0, 0.0, 0.0, 1.0)
	var text = ""
	var looks = {
	"H1":false,"H2":false,

	"V2":false,
	"D7":false,"D3":false,
	"V4":false,
	"D8":false,"D4":false,
	"V6":false,

	"H3":false,"H4":false,

	"V1":false,
	"D5":false,"D1":false,
	"V3":false,
	"D2":false,"D6":false,
	"V5":false,

	"H5":false,"H6":false,
	}
	for i in patterns[rand]:
		looks[i] = true
	for i in looks:
		if i.contains("D") and looks[i]:
			await g.wait(.001)
			if looks[{"D2"="D6","D6"="D2","D5"="D1","D1"="D5","D8"="D4","D7"="D3","D4"="D8","D3"="D7"}[i]]:
				text += "X"
			elif ["D1","D2","D3","D4"].has(i):
				text += "/"
			else:
				text += "\\"
		elif i.contains("D"):
			text += " "
		elif looks[i]:
			if i.contains("H"):
				text += "*-"
				if int(i.replace("H",""))%2 == 0:
					text += "*\n"
			elif i.contains("V"):
				if int(i.replace("V","")) > 4:
					
					text += "|\n"
				else:
					text += "|[font_size=8] [/font_size]"
		else:
			if i.contains("H"):
				text += "*[font_size=8]  [/font_size]"
				if int(i.replace("H",""))%2 == 0:
					text += "*\n"
			elif i.contains("V"):
				text += " "
				if int(i.replace("V","")) > 4:
					text += "\n"
	text = text.replace("XX","X")
	text = text.replace(" X","X")
	text = text.replace(" X","X")
	text = text.replace(" X","X")
	text = text.replace(" X","X")
	#text = (text.replace(" ",""))
	if locked:
		phoneify(text)

func merge():
	var con = (butposses[but1]+butposses[but2])/Vector2(2,2)
	var mid = false
	if Vector2(Vector2i(con)) == con:
		return
	if but1 == $Button5 or but2 == $Button5:
		mid = true
	ons[(lines[mid][con])] = true
	but1 = but2
	ticks += 1
	but2 = null

func b1() -> void:
	var but = $Button1
	if but1:
		but2 = but
		merge()
	else:
		but1 = but

func b2() -> void:
	var but = $Button2
	if but1:
		but2 = but
		merge()
	else:
		but1 = but


func b3() -> void:
	var but = $Button3
	if but1:
		but2 = but
		merge()
	else:
		but1 = but



func b4() -> void:
	var but = $Button4
	if but1:
		but2 = but
		merge()
	else:
		but1 = but


func b5() -> void:
	var but = $Button5
	if but1:
		but2 = but
		merge()
	else:
		but1 = but


func b6() -> void:
	var but = $Button6
	if but1:
		but2 = but
		merge()
	else:
		but1 = but


func b7() -> void:
	var but = $Button7
	if but1:
		but2 = but
		merge()
	else:
		but1 = but


func b8() -> void:
	var but = $Button8
	if but1:
		but2 = but
		merge()
	else:
		but1 = but


func b9() -> void:
	var but = $Button9
	if but1:
		but2 = but
		merge()
	else:
		but1 = but
