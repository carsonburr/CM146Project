extends Node2D # KinematicBody2D

signal shoot

signal respawn_laser

export (PackedScene) var Bullet

export (PackedScene) var Missile
export (PackedScene) var Laser
# laser separate from bullet
const ChooseBehavior = preload("res://behavior/ChooseBehavior.gd")
var action_choice_tree

var disabled_gun

func _ready():
	var screensize = get_viewport_rect().size
	position.x = screensize.x / 2
	position.y = screensize.y / 2 - 100
	action_choice_tree = ChooseBehavior.new(self)
	action_choice_tree.execute()
	
	# $LaserRespawnTimer.start()

func _process(delta):
	pass

func change_behavior(args):
	action_choice_tree.execute()

func set_behavior_node(args):
	$Behavior.queue_free()
	remove_child($Behavior)
	add_child(args.new_behavior.new(args.new_args))

func shoot(dir):
	emit_signal('shoot', Bullet, $BulletSpawnPoint.global_position, dir)
	
func shoot_missile(dir):
	emit_signal('shoot', Missile, get_node("gun_missile/spawnpoint_missile").global_position, dir)
	
func respawn_laser():
	emit_signal('respawn_laser', Laser, get_node("gun_laser/spawnpoint_laser").global_position, Vector2(0, 0))
	# print("sent out laser signal")

func move(args):
	position.x += args[0]
	position.y += args[1]
	
func disable():
	print("boss disabled")
	var gun = $gun_laser
	#gun.modulate = Color(0,0,0,0.6)
	are_disabled(gun)
	
func are_disabled(disabled_gun):
	disabled_gun.modulate = Color(0,0,0,0.6)
	