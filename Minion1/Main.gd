extends Node

export (PackedScene) var Platform
var score

func _ready():
	randomize()

func game_over():
	get_tree().reload_current_scene()

func new_game():
	score = 0
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$Doodle.show()
	$Platform.show()
	$Platform2.show()
	$Platform3.show()
	$Platform4.show()

func _on_ScoreTimer_timeout():
	score = max((int($Doodle.position.y * -1)), score)
	$HUD.update_score(score)