extends StaticBody2D

var trampoline_text = preload("res://Assets/Art/tram.png")
var rocket_text = preload("res://Assets/Art/rocket.png")
var trampoline_fx = load("res://Assets/Sound/wav/Trampoline.wav")
var rocket_fx = load("res://Assets/Sound/wav/Misile.wav")
export (int) var impulse
var type
var powerUps = [trampoline_text, rocket_text]
var screensize


func _ready():
	screensize = get_tree().get_root().get_node("Main").viewport_rect.size
	powerUps = [trampoline_text, rocket_text]

func setRandomType():
	type = powerUps[randi() % powerUps.size()]

func impulse():
	if(type == (trampoline_text)):
		$AudioStreamPlayer.stream = trampoline_fx
		$AudioStreamPlayer.play()
		return 10
	if(type == (rocket_text)):
		$AudioStreamPlayer.stream = rocket_fx
		$AudioStreamPlayer.play()
		return 20

func setSprite():
	if(type == (trampoline_text)): $Sprite.texture = trampoline_text
	if(type == (rocket_text)): $Sprite.texture = rocket_text

func generate_platforms(main):
	if(type == (trampoline_text)): main.generate(10)
	if(type == (rocket_text)): main.generate(20)