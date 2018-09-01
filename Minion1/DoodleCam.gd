extends Camera2D

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	current = true
	var doodle = get_parent().get_node("Doodle")
	limit_left = doodle.position.x
	limit_right = get_viewport_rect().size.x
	position.y = doodle.position.y
	if(doodle.position.y < position.y):
		position.y = doodle.y
