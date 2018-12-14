extends "res://Bullet.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed
var target

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	print("hello")
	speed = 200
	_attack()
	
func _getNewTarget():
	var playerLocation = get_node("Player").get_pos()
	return playerLocation
	
	
func _shake():
	var bossCurPos = get_node("Boss").get_pos()
	var i = 0
	bossCurPos.x += 1
	var left = true
	while i < 10:
		if left:
			get_node("Boss").set_pos(bossCurPos)
			bossCurPos.x -= 2
			left = false
		else:
			get_node("Boss").set_pos(bossCurPos)
			bossCurPos.x += 2
			left = true
		i += 1
	
func _rush():
	var targetVector = (target - get_node("Boss").get_pos()).normalized()
	get_node("Boss").move(targetVector * 10 * 1)
	
func _attack():
	var attempt = 0
	while attempt != 3:
		attempt += 1
		target = _getNewTarget()
		_shake()
		_rush()
		
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
