extends ProgressBar

@onready var player = self.get_parent()

func _ready() -> void:
	updateValue()
	pass # Replace with function body.

func _process(_delta: float) -> void:
	pass

func updateValue():
	value = player.currentSanity
	pass
