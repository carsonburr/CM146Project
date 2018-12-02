extends Area2D

"""
Using temp player images, mage-f-32x36-sprite-png,
from https://opengameart.org/content/antifareas-rpg-sprite-set-1-enlarged-w-transparent-background-fixed
by Antifarea.

purple-f-32x32-sprite-png/,
from http://himeworks.com/2014/11/introducing-diagonal-movement-into-rpg-maker/
by HIME.

Online sprite sheet cutter: https://ezgif.com/sprite-cutter/ezgif-4-4210e31654a4.png
Had to use cutting by tile size.

Tutorial links:
http://docs.godotengine.org/en/3.0/getting_started/step_by_step/your_first_game.html

Parts of video series, top-down tank shooter
https://www.youtube.com/watch?v=sQ1FpD0DYF8
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
	position.y = screensize.y / 2 + 100
	
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
	
	
	var mouse_pos = get_global_mouse_position()
	
	# convert from rad to deg w/ rad2deg() or vice versa w/ deg2rad()
	var deg_angle = rad2deg($AnimatedSprite.get_angle_to(mouse_pos))
	
	# character starts by facing right = 0 degrees
	# right = 0, up = -90, left = 179 or -179, down = 90
	# face the general direction of the mouse
	
	# 8-way rotation animation
	if deg_angle > -30 and deg_angle < 30:
		$AnimatedSprite.animation = "right"
	elif deg_angle >= -60 and deg_angle <= -30:
		$AnimatedSprite.animation = "up-right"
	elif deg_angle < -60 and deg_angle > -120:
		$AnimatedSprite.animation = "up"
	elif deg_angle >= -150 and deg_angle <= -120:
		$AnimatedSprite.animation = "up-left"
	elif (deg_angle < -150 and deg_angle > -180) or (deg_angle > 150 and deg_angle < 180):
		$AnimatedSprite.animation = "left"
	elif deg_angle >= 30 and deg_angle <= 60:
		$AnimatedSprite.animation = "down-right"
	elif deg_angle > 60 and deg_angle < 120:
		$AnimatedSprite.animation = "down"
	elif deg_angle >= 120 and deg_angle <= 150:
		$AnimatedSprite.animation = "down-left"
		
	if Input.is_action_pressed("click"):
		shoot()
		
	control(delta)
		
func control(delta):
	# normally would be ex. the turret of a tank not BulletSpawnPoint or AnimatedSprite
	# $AnimatedSprite.look_at(get_global_mouse_position())
	$BulletSpawnPoint.look_at(get_global_mouse_position())
	$BulletSpawnPoint.global_position = position
		
func shoot():
	if can_shoot:
		can_shoot = false
		$BulletTimer.start()
		# $AnimatedSprite.global_rotation
		var dir = Vector2(1, 0).rotated($BulletSpawnPoint.global_rotation)
		emit_signal('shoot', Bullet, $BulletSpawnPoint.global_position, dir)

func _on_BulletTimer_timeout():
	can_shoot = true
