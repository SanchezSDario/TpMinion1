extends Node

var score = 0
var platform_scene = load("res://Platform.tscn")
var platforms = []
var platform_generator_limit = 0
var counter = 0
var movable_counter = 10
var fragile_counter = 5
var powerUp_counter = 15
var min_y_distance = -50
var max_y_distance = -80
var viewport_rect
var new_position



func _ready():
	randomize()
	viewport_rect = get_viewport()
	platforms.append(platform_scene.instance())
	add_child(platforms.front())
	new_position = platforms.back().position

func _process(delta):
	new_position = platforms.back().position

func game_over():
	$ScoreTimer.stop()
	$DoodleCam.queue_free()
	$DeathSound.play()

func new_game():
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_StartTimer_timeout():
	initialize(20)
	$ScoreTimer.start()
	$Doodle.show()
	platforms.front().show()

func _on_ScoreTimer_timeout():
	score = max((int($Doodle.position.y * -1)), score)
	$HUD.update_score(score)

func generate_platform():
	var x = rand_range(-240, 240)
	var y = rand_range(min_y_distance , max_y_distance)
	var platform = platform_scene.instance()
	platform.set_name("Plataforma"+str(counter))
	movable_platform(platform)
	fragile_platform(platform)
	add_child(platform)
	platform.translate(Vector2(x, y))
	give_powerUp(platform)
	platform.show()
	platforms.append(platform)
	min_y_distance += -50
	max_y_distance += -60
	counter += 1

func initialize(amount):
	for i in range(amount): generate_platform()

func generate(amount):
	if(score > platform_generator_limit):
		initialize(amount)
		platform_generator_limit += 300

func movable_platform(plat):
	if(counter >= movable_counter):
		plat.be_movable()
		movable_counter += rand_range(5, 10)

func fragile_platform(plat):
	if(counter >= fragile_counter):
		plat.be_fragile()
		fragile_counter += rand_range(3, 7)

func give_powerUp(plat):
	if(counter >= powerUp_counter):
		plat.set_random_powerUp()
		powerUp_counter += rand_range(15, 30)

func broke_signal():
	$Broke.play()

func _on_DeathSound_finished():
	get_tree().reload_current_scene()