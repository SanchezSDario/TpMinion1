extends Node

var score
var platform_scene = load("res://Platform.tscn")
var platforms = []
var platform_generator_limit = 0
var counter
var y_1 = -50
var y_2 = -200

func _ready():
	randomize()
	counter = 0
	score = 0
	platforms.append(platform_scene.instance())
	add_child(platforms.front())

func game_over():
	get_tree().reload_current_scene()

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
	var y = rand_range(y_1, y_2)
	var platform = platform_scene.instance()
	platform.set_name("Plataforma"+str(counter))
	add_child(platform)
	platform.translate(Vector2(x, y))
	platform.show()
	y_1 += -30
	y_2 += -150
	platforms.append(platform)

func initialize(amount):
	for i in range(amount): generate_platform()

func generate():
	if(score > platform_generator_limit):
		initialize(10)
		platform_generator_limit += 500