# extends Area2D
extends KinematicBody2D

signal shoot

signal respawn_laser

export (PackedScene) var Bullet

# laser separate from bullet
export (PackedScene) var Laser

const ChooseBehavior = preload("res://behavior/ChooseBehavior.gd")
var action_choice_tree

func _ready():
	var screensize = get_viewport_rect().size
	position.x = screensize.x / 2
	position.y = screensize.y / 2 - 100
	action_choice_tree = ChooseBehavior.new(self)
	action_choice_tree.execute()
	
	$LaserRespawnTimer.start()

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
	
func respawn_laser():
	emit_signal('respawn_laser', Laser, $BulletSpawnPoint.global_position, Vector2(0, 0))
	# print("sent out laser signal")

func move(args):
	pass

# for testing purposes only
# can remove this timer
func _on_LaserRespawnTimer_timeout():
	respawn_laser()
