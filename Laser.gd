# currently extending Bullet and adding AnimatedSprite

extends "res://Bullet.gd"

# extends Area2D

# inherited Sprite and velocity unused
# var velocity = Vector2()

var screensize

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	speed = 0
	
	screensize = get_viewport_rect().size
	# arbitrary position, can change later
	# boss positon: (screensize.x / 2, screensize.y / 2 - 100)
	position.x = screensize.x / 2
	position.y = screensize.y / 2 - 100
	
	# speed in frames per second
	$AnimatedSprite.frames.set_animation_speed("shooting", 10)
	#print($AnimatedSprite.frames.get_animation_speed("shooting"))

func start(_position, _direction):
	# position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed

func _process(delta):
	# position += velocity * delta
	$AnimatedSprite.play()
	# PI / 6 = 30 deg / 6 = 5 deg
	rotation = rotation + PI / 36
	
	if $AnimatedSprite.animation == "shooting" and $AnimatedSprite.frame == 5:
		$AnimatedSprite.stop()
		# $AnimatedSprite.animation = "final beam"
	
func explode():
	queue_free()

func _on_Bullet_body_entered(body):
	# when hit wall
	explode()
	# otherwise, if hit boss or player
	# if body.has_method("take_damage"):
		# body.take_damage(body)

# bullet explodes after a certain time, optional
func _on_Lifetime_timeout():
	explode()
