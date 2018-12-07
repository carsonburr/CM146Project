# currently extending Bullet and adding AnimatedSprite

extends "res://Bullet.gd"

# extends Area2D

# var velocity = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	speed = 0
	
	# arbitrary position, can change later
	# (250, 250) set in inspector
	# boss positon: (screensize.x / 2, screensize.y / 2 - 100)

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed

func _process(delta):
	# position += velocity * delta
	$AnimatedSprite.play()
	
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
