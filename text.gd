extends RichTextLabel
var pointer = 0
const texts = {0:"",1:"",2:"BOOTING:Training.MP3..."}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $"..".visible:
		visible_ratio += {0:0,1:.01,2:.01}.get(pointer)
	else:
		visible_ratio = 0
	text = texts.get(pointer)
	if [2].has(pointer):
		print(get_theme_color("default_color"))
		add_theme_color_override("default_color", Color(0.0, 1.0, 0.0, 1.0))
	else:
		remove_theme_color_override("default_color")
	if has_focus():
		focus_mode = Control.FOCUS_NONE
		if visible_ratio == 1:
			print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
			pointer += 1
			visible_ratio = 0
		else:
			print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB")
			visible_ratio = 1
		await get_tree().process_frame
		focus_mode = Control.FOCUS_CLICK 
