extends Node

export (PackedScene) var Platform
var score

func _ready():
	get_node("StartTimer").start()
	get_node("ScoreTimer").start()