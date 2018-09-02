extends KinematicBody2D

signal defeat
signal y_fall
export (int) var gravity
export (int) var movement

export var base_jump = 20 #Proper jump force of the doodle
var jump_force = 0 #Jump force gained by specific items in the world
var screensize

func _ready():
	hide()
	pass

func _process(delta):
	screensize = get_viewport_rect().size
	var info = fall()
	jump(info)
	law_of_universal_gravitation(delta)
	move()
	_on_Doodle_y_fall()

func fall():
	#Move the Doodle and get a collision information if a collision happen
	return move_and_collide(Vector2(0, gravity - jump_force))

func jump(information):
	#Calculates the next jump_foce of the Doodle
	if information != null:
		jump_force = base_jump + information.collider.impulse
		get_parent().generate()

func law_of_universal_gravitation(delta_time):
	#Determines how much the Doodle will rise, eventually it's going to fall
	if (jump_force > 0): jump_force -= (gravity + jump_force)/2 * delta_time

func move():
	if Input.is_action_pressed("ui_left"): position.x -= movement
	if Input.is_action_pressed("ui_right"): position.x += movement
	position.x = clamp(position.x, 0, screensize.x)

func _on_Doodle_y_fall():
	if(position.y >= screensize.y):
		queue_free() #or hide()?
		emit_signal("defeat")
		$CollisionShape2D.disabled = true