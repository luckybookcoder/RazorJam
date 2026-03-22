extends RichTextLabel
var pointer = 0
const speeds = {1:{0:.01,1:.01,2:.008,3:.01,4:.008,5:.008},5:{}}
const texts = {
	0:"Oh, there you are![font_size=8]    [/font_size]Finally.[font_size=4]        [/font_size]You're here with Tek2B, right?[font_size=1]                [/font_size]Alright, let's get you started.",
	1:"First things first, here's your company phone for the job.[font_size=8]    [/font_size]It should have everything you'll need on it.",
	2:"Real basic rundown, you have to calibrate the robots to do the chores.[font_size=8]    [/font_size]The more efficient, the better the pay. Think putting dishes in the washer, doing laundry, stuff like that.",
	3:"The robots [font_size=32][i]do[/i] only turn on when you leave, unfortunately. Apparently the companies trying not to get sued.",
	4:"If a robot doesn't do what you tell it to, figure out what its doing wrong. The robots should work consistently, even if something's messing with the commands.",
	5:"Last thing, the door does lock automatically when you leave, but if you just tap whatever pops up on your phone, it'll tell you what to do."}
func _ready() -> void:
	g.endlvl.connect(show) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not speeds.get(g.lvl):
		hide()

	if $"..".visible and visible:
		text = texts.get(pointer)
		visible_ratio += speeds.get(g.lvl).get(pointer)
	else:
		visible_ratio = 0

	#if [2].has(pointer):
		##print(get_theme_color("default_color"))
		#add_theme_color_override("default_color", Color(0.0, 1.0, 0.0, 1.0))
	#else:
		#remove_theme_color_override("default_color")

	if visible_ratio == 1:
		$advance.show()
		
	else:
		$advance.hide()

	if has_focus() or Input.is_action_just_pressed("cancel"):
		focus_mode = Control.FOCUS_NONE
		if visible_ratio == 1:
			pointer += 1
			visible_ratio = 0
			if not speeds.get(g.lvl).get(pointer):
				hide()
		else:
			visible_ratio = 1
		await get_tree().process_frame
		focus_mode = Control.FOCUS_CLICK 
