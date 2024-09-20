extends CanvasLayer

var MyPadsCollected = 0


func _ready() -> void:
	$Mypads.text = "Mypads collected: " + str(MyPadsCollected)


func _process(delta: float) -> void:
	pass
	
	
	
