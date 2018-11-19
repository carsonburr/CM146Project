extends Area2D

"""
Using temp player images, mage-f-32x36-sprite-png,
from https://opengameart.org/content/antifareas-rpg-sprite-set-1-enlarged-w-transparent-background-fixed
by Antifarea.

Online sprite sheet cutter: https://ezgif.com/sprite-cutter/ezgif-4-4210e31654a4.png
Had to use cutting by tile size.
"""

export (int) var speed # How fast the player will move (pixels/sec).
var screensize

func _ready():
	screensize = get_viewport_rect().size
	
	# initial player position
	position.x = screensize.x / 2
	position.y = screensize.y / 2

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