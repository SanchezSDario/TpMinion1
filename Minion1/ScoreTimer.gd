extends Timer

var time = 0
var time_mult = 1.0

func _ready():
  set_process(true)

func _process(delta):
  if not paused:
    time += delta * time_mult