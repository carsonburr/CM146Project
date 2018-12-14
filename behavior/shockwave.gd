extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var dir
var ent
var dir_inc
var timer 
var last_shot

func _init(_ent):
	name = "Behavior"
	ent = _ent
	dir = Vector2(0, 1)
	dir_inc = PI/50
	timer = 0
	last_shot = timer
	

func _process(delta):
	timer += delta
	if last_shot + 3 < timer:
		last_shot = timer
		_attack()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var hello = 2
	

func _attack():
	var i = 0
	while i < 100:
		ent.shoot(dir)
		dir = dir.rotated(dir_inc)
		i += 1
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
