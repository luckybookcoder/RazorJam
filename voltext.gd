extends RichTextLabel

func _ready() -> void:
	$"..".value = g.volume * 100

func _process(delta: float) -> void:
	text = str("Volume:", int($"..".value), "%")
	g.volume = $"..".value / 100.0
