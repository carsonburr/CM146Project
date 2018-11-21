extends Area2D

"""
Using temp player images, mage-f-32x36-sprite-png,
from https://opengameart.org/content/antifareas-rpg-sprite-set-1-enlarged-w-transparent-background-fixed
by Antifarea.

Online sprite sheet cutter: https://ezgif.com/sprite-cutter/ezgif-4-4210e31654a4.png
Had to use cutting by tile size.
"""

# signal hit
signal shoot

export (int) var speed # How fast the player will move (pixels/sec).
var screensize

# bullet = fireball
export (PackedScene) var Bullet
export (float) var bullet_cooldown

var can_shoot = true

func _ready():
	screensize = get_viewport_rect().size
	
	# initial player position
	position.x = screensize.x / 2
	position.y = screensize.y / 2
	
	# set wait time to bullet cooldown
	$BulletTimer.wait_time = bullet_cooldown
	
	$BulletSpawnPoint.position = position

func _process(delta):
	var velocity = Vector2()
	# player's movement keys: WASD
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	# prevent player from leaving the screen
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x > 0:
		$AnimatedSprite.animation = "right"
	elif velocity.x < 0:
		$AnimatedSprite.animation = "left"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "up"
	elif velocity.y > 0:
		$AnimatedSprite.animation = "down"
		
	if Input.is_action_pressed("click"):
		shoot()
		
	control(delta)
		
func control(delta):
	# normally would be ex. the turret of a tank not AnimatedSprite
	# $AnimatedSprite.look_at(get_global_mouse_position())
	$BulletSpawnPoint.look_at(get_global_mouse_position())
	$BulletSpawnPoint.global_position = position
	pass
		
func shoot():
	if can_shoot:
		can_shoot = false
		$BulletTimer.start()
		# $AnimatedSprite.global_rotation
		var dir = Vector2(1, 0).rotated($BulletSpawnPoint.global_rotation)
		emit_signal('shoot', Bullet, $BulletSpawnPoint.global_position, dir)

func _on_BulletTimer_timeout():
	can_shoot = true
