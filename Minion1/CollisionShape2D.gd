extends CollisionShape2D

signal land
export (int) var gravity
export (int) var movement

var base_jump = 20 #Proper jump force of the doodle
var jump_force = 0 #Jump force gained by specific items in the world
var screensize

func _ready():
	screensize = get_viewport_rect().size

func _process(delta):
	#Represent the speed of fall and rise per frame
	var velocity = Vector2(0, gravity - jump_force)
	#Move the Doodle and get an object that collides if exists
	var info = move_and_collide(velocity)
	if info != null: 
		#Calculates the next jump_foce of the Doodle
		jump_force = base_jump + info.collider.impulse
	if (jump_force > 0):
		#Determines how much the Doodle will rise, eventually it's going to fall
		jump_force -= (gravity + jump_force)/2 * delta
	move()
	

func move():
	if Input.is_action_pressed("ui_left"):
		position.x -= movement
	if Input.is_action_pressed("ui_right"):
		position.x += movement
