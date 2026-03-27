extends Node2D
var playerpos = g.playerpos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	unpause()
	menu()
	$Popup.exclusive = true
	g.playerpos = &"menu"
	esc()
	await $"Popup/Button3".pressed
	#g.lvl -= 1
	playerpos = &"box"
	g.endlvl.emit()

func esc():
	while $Popup.visible:
		await get_tree().process_frame
	queue_free()

func unpause():
	await $Popup/Button.pressed
	queue_free()

func menu():
	await $Popup/Button2.pressed
	g.playerpos = &"transfer"
	$"..".menu()
	queue_free()

func _exit_tree() -> void:
	g.playerpos = playerpos
