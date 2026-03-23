extends RichTextLabel
var pointer = 0
var oldplace = &""
const speeds = {1:{0:.007,1:.01,2:.004,4:.01,3:.008,5:.008, 6:.05},9:{}, 13:{}}
var done = {1:false,9:false, 13:false}
var lvl = 0
const texts = {
	1:{
		0:"Oh, there you are![font_size=8]    [/font_size]Finally.[font_size=4]        [/font_size]You're here with Tek2B, right?[font_size=2]            [/font_size]Alright, let's get you started.",
		1:"First things first, here's your company phone for the job.[font_size=8]    [/font_size]It should have everything you'll need on it.",
		2:"Real basic rundown, you have to calibrate the robots to do the chores. Things like[font_size=3]     [/font_size]putting dishes in the washer, doing laundry, stuff like that.[font_size=8]    [/font_size]The more efficient, the better the pay.",
		4:"The robots [font_size=48][i]do[/i] only turn on when you leave, unfortunately. Apparently the company's trying not to get sued.",
		3:"If a robot doesn't do what you tell it to, figure out what its doing wrong.[font_size=8]    [/font_size]The robots should work consistently, even if something's messing with the commands.",
		5:"Last thing, the door does lock automatically when you leave, but if you just tap whatever pops up on your phone, it'll show you what to do.",
		6:"Good luck!"
	},
	9:{
		
	},
	13:{
		
	}
}
func _ready() -> void:
	g.endlvl.connect(show) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if g.lvl != lvl:
		lvl = g.lvl
		pointer = 0
	if speeds.get(g.lvl) and speeds.get(g.lvl).get(pointer):
		show()
		if g.playerpos != &"menu":
			oldplace = g.playerpos
			g.playerpos = &"menu"
	else:
		if g.playerpos == &"menu" && oldplace != '':
			g.playerpos = oldplace
			oldplace = ''
		hide()


	#if [2].has(pointer):
		##print(get_theme_color("default_color"))
		#add_theme_color_override("default_color", Color(0.0, 1.0, 0.0, 1.0))
	#else:
		#remove_theme_color_override("default_color")

	if visible_ratio == 1:
		$advance.show()
		
	else:
		$advance.hide()

	if has_focus() or Input.is_action_just_pressed("cancel") and texts.get(pointer):
		focus_mode = Control.FOCUS_NONE
		if visible_ratio == 1:
			pointer += 1
			visible_ratio = 0
			if not speeds.get(g.lvl).get(pointer):
				done[g.lvl] = true
				hide()
		else:
			visible_ratio = 1
		await get_tree().process_frame
		focus_mode = Control.FOCUS_CLICK

	if $"..".visible and visible and texts.get(pointer):
		text = texts.get(pointer)
		visible_ratio += speeds.get(g.lvl).get(pointer)
	else:
		visible_ratio = 0
