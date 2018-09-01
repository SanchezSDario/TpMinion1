extends Camera2D

func _ready():
	limit_left = get_parent().position.x
	limit_right = get_viewport_rect().size.x