extends Camera2D

var doodle

func _ready():
	current = true

func _process(delta):
	var doodle = get_parent().get_node("Doodle")
	limit_left = doodle.position.x
	limit_right = get_viewport_rect().size.x
	position.y = doodle.position.y