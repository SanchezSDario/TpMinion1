extends Node

var score
var platform_scene = load("res://Platform.tscn")
var platforms
var platform_generator_limit
var counter
var movable_counter
var fragile_counter
var y_1
var y_2
var viewport_rect

func _ready():
	randomize()
	viewport_rect = get_viewport()
	platforms = []
	counter = 0
	score = 0
	movable_counter = 10
	fragile_counter = 5
	platform_generator_limit = 0
	y_1 = -50
	y_2 = -200
	platforms.append(platform_scene.instance())
	add_child(platforms.front())

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
	var new_position = platforms.back().position
	var x = rand_range(-240, 240)
	var y = rand_range(y_1 , y_2 - new_position.y)
	var platform = platform_scene.instance()
	counter += 1
	platform.set_name("Plataforma"+str(counter))
	movable_platform(platform)
	fragile_platform(platform)
	add_child(platform)
	platform.translate(Vector2(x, y))
	platform.show()
	platforms.append(platform)
	y_1 += -50
	y_2 += -80

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

func _on_DeathSound_finished():
	get_tree().reload_current_scene()
