extends CharacterBody2D

@export var speed = 200
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _gameover = $Camera2D/GameEnd
#Variables to keep track of sanity("health")
@export var maxSanity = 50
@onready var currentSanity: int = maxSanity
@onready var sanityBar = $SanityBar
@onready var timer: Timer = $TakeDamage
#@onready var karen = load("res://karen1.tscn")
@onready var manager: CharacterBody2D = $store
@onready var karen: CharacterBody2D = $"../../Karen"
@onready var karen2: CharacterBody2D = $"../../Karen2"
@onready var karen3: CharacterBody2D = $"../../Karen3"
@onready var karen4: CharacterBody2D = $"../../Karen4"

var take_sanity_damage = false

func _ready():
	#print(karen)
	#call_deferred("karen.connect", "emit_damage", Callable(manager, "check_for_damage")))
	karen.connect("emit_damage", Callable(self, "check_for_damage"))
	karen2.connect("emit_damage", Callable(self, "check_for_damage"))
	karen3.connect("emit_damage", Callable(self, "check_for_damage"))
	karen4.connect("emit_damage", Callable(self, "check_for_damage"))

func check_for_damage(status: String):
	print("signal here")
	if status == "entered":
		take_sanity_damage = true
		take_damage()
	if status == "exit":
		take_sanity_damage = false
	pass
	


func take_damage():
	currentSanity -= 5;
	sanityBar.updateValue()
	if currentSanity < 0:
		currentSanity = 0;
	if currentSanity == 0:
		gameOver()

	timer.start()

func gameOver():
	 #changes GameEnd visibulity
	_gameover.visible = true

#A callname for each 2D direction in one variable and defining velocity
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

#what happens when the directions keys are pressed
func _process(_delta):
	if Input.is_action_pressed("up"):
		_animated_sprite.play("back walk")
	elif Input.is_action_pressed("right"):
		_animated_sprite.play("right walk")
	elif Input.is_action_pressed("left"):
		_animated_sprite.play("left walk")
	elif Input.is_action_pressed("down"):
		_animated_sprite.play("front walk")
	else:
		_animated_sprite.play("stand still")

#sync grafic and physics 
func _physics_process(_delta):
	get_input() 
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "ManagerPlayer":
		take_sanity_damage = true
		take_damage()
	pass # Replace with function body.


func _on_area_2d_body_exited(_body: Node2D) -> void:
	take_sanity_damage = false
	pass # Replace with function body.


func _on_take_damage_timeout() -> void:
	if take_sanity_damage == true:
		take_damage()
	pass # Replace with function body.
