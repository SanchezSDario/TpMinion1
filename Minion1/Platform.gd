extends StaticBody2D


var mov_text = preload("res://Assets/Art/movable-platform.png")
var broke_text = preload("res://Assets/Art/fragile-platform.png")
var mov_broke_text = preload("res://Assets/Art/movable-fragile-platform.png")
var powerUp_scene = load("res://PowerUp.tscn")
export (int) var impulse = 0
export (bool) var movable
export (bool) var fragile
signal broke_signal
var screensize
var x_variable = 0
var X_MOVEMENT
var jumps
var death = false
var powerUp

func _ready():
	hide()
	jumps = 0
	X_MOVEMENT = rand_range(0.5, 1.2)
	get_node("CollisionShape2D").one_way_collision =  true

func be_movable():
	movable = true

func be_fragile():
	fragile = true

func set_powerUp(pwrUp):
	powerUp = pwrUp

func set_random_powerUp():
	powerUp = powerUp_scene.instance()
	powerUp.setRandomType()
	powerUp.position = self.position
	powerUp.translate(Vector2(0, -10))
	powerUp.setSprite()

func impulse():
	if(powerUp != null): return powerUp.impulse()
	else: 
		$AudioStreamPlayer.play()
		return 0

func _process(delta):
	screensize = get_tree().get_root().get_node("Main").viewport_rect.size
	move()
	broke()
	sprite_type()

func move():
	if(movable):
		if(x_variable >= 0):
			move_right()
		else:
			move_left()

func move_right():
	translate(Vector2(X_MOVEMENT,0))
	x_variable += X_MOVEMENT
	if(x_variable >= 150):
		x_variable = -1

func move_left():
	translate(Vector2(-X_MOVEMENT,0))
	x_variable -= X_MOVEMENT
	if(x_variable <= -150):
		x_variable = 0

func count_jump():
	if(fragile): jumps += 1

func broke():
	if(fragile && jumps > 0):
		get_parent().broke_signal()
		$CollisionShape2D.disabled = true
		queue_free()

func generate_platforms():
	get_parent().generate(10)
	if(powerUp != null): powerUp.generate_platforms(get_parent())

func sprite_type():
	if(movable): $Sprite.texture = mov_text
	if(fragile): $Sprite.texture = broke_text
	if(movable && fragile): $Sprite.texture = mov_broke_text

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	var doodle = get_parent().get_node("Doodle")
	if((doodle != null) && doodle.position.y  < self.position.y + 20):
		queue_free()
