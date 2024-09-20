extends CharacterBody2D

const speed = 90


var direction = 1
var pervious_position = 0
var timer_is_started = false

signal emit_damage(call_status) 

var call_status: String = ""




#print(random_number)

#@onready var ray_cast_r: RayCast2D = $RayCastR
#@onready var ray_cast_l: RayCast2D = $RayCastL
@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#@onready var manager_player: CharacterBody2D #= $"Manager-player"
@onready var manager_player: CharacterBody2D = $ManagerPlayer

var direction2 := Vector2(1, 0)

func _ready() -> void:
	pervious_position = position
	#print(!timer_is_started)
	pass
	#timer.set_wait_time(10)
	#timer.start()

func damage():
	pass
	


var directions = [
	Vector2(0, -1), #up
	Vector2(0, 1), #down
	Vector2(-1, 0), #left
	Vector2(1, 0) #right
	]

var getMeTheManager = false






func seekAndDestroy():
	#var direction = (manager_player.global_position - global_position).normalized()
	#print(manager_player.global_position)
	#print(global_position)
	
	
	velocity = (manager_player.global_position - global_position).normalized() * speed;
	#print(velocity)

	



func switch_direction():
	var new_direction = randi() % 4
	
	if direction == new_direction:
		new_direction = (new_direction + 1) % 4
	direction2 = directions[new_direction]
	direction = new_direction
	if direction2.x < 0:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
		pass
		 # new_direction:
		
	
	#direction2 = directions[randi() % 4]

func _physics_process(delta: float) -> void:
	
	if pervious_position == position and !timer_is_started:
		timer.start()
		timer_is_started = true
		#print("timer her")
	elif pervious_position != position and timer_is_started:
		timer.stop()
		timer_is_started = false
		
	
	if getMeTheManager == true:
		seekAndDestroy()
	else:
		velocity = direction2 * speed 
	
	pervious_position = position
	#print(pervious_position)
	move_and_slide()
	
func _on_karen_area_body_entered(body: Node2D) -> void:
	print(body.name)
	#print("test")
	if body.has_method("wall"):
		switch_direction()
	
	

func _on_Timer_timeout():
	#print("test")
	switch_direction()

func flip():
	if direction2.x < 0:
		pass
		#print("test1")

		
#func _on_timer_timeout() -> void:
#	print("test")
#	switch_direction()


func _on_awareness_body_entered(body: Node2D) -> void:
	if body.name == "Manager-player":
		manager_player = body
		#print(manager_player.name)
		getMeTheManager = true
		


func _on_awareness_body_exited(body: Node2D) -> void:
	if body.name == "Manager-player":
		getMeTheManager = false


func _on_karen_area_area_entered(area: Area2D) -> void:
	#print("test")
	pass # Replace with function body.


func _on_new_test_body_entered(body: Node2D) -> void:
	var body_name = body.name
	print("send signal1")
	
	if body_name.contains("Walls"):
		switch_direction()
		
	if body_name == "ManagerPlayer":
		call_status = "entered"
		print("send signal2")
		emit_signal("emit_damage", call_status)
	
func _on_new_test_body_exited(body: Node2D) -> void:
	var body_name = body.name
	
	if body_name == "ManagerPlayer":
		call_status = "exit"
		print("send signal3")
		emit_signal("emit_damage", call_status)
		#emit_damage.emit("exit")
	# Replace with function body.
	#print(body.name)
	#if body.has_method("wall"):
	#	switch_direction()
	#if body.has_method("wall"):
	#	switch_direction()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	switch_direction()
	pass # Replace with function body.


func _on_awareness__body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "ManagerPlayer":
		manager_player = body
		print(manager_player.name)
		getMeTheManager = true
	pass # Replace with function body.
	
	



func _on_awareness__body_exited(body: Node2D) -> void:
	if body.name == "ManagerPlayer":
		getMeTheManager = false
	pass # Replace with function body.
