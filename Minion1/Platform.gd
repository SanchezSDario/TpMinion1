extends StaticBody2D

export (int) var impulse = 0

func _ready():
	hide()
	get_node("CollisionShape2D").one_way_collision =  true