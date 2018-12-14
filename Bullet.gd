extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime

var velocity = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed
	$Lifetime.start()

func _process(delta):
	position += velocity * delta
	pass
	
func explode():
	queue_free()

# normal enemybullet and playerbullet share this function
func _on_Bullet_body_entered(body):
	# explode()
	# otherwise, if hit boss or player
	# if body.has_method("take_damage"):
		# body.take_damage(body)\
	pass

# bullet explodes after a certain time, optional
func _on_Lifetime_timeout():
	print("explode")
	explode()

# we don't want bullets to disappear on contact with shooter itself
func _on_PlayerBullet_body_entered(body):
	if body.get_name() != "Player":
		explode()


func _on_EnemyBullet_body_entered(body):
	if body.get_name() != "Boss":
		explode()
