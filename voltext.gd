extends RichTextLabel

func _process(delta: float) -> void:
	text = str("Volume:", int($"..".value), "%")
	g.volume = $"..".value
