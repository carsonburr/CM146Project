extends Area2D

signal shoot

export (PackedScene) var Bullet

const ChooseBehavior = preload("res://behavior/ChooseBehavior.gd")
var action_choice_tree

func _ready():
	var screensize = get_viewport_rect().size
	position.x = screensize.x / 2
	position.y = screensize.y / 2 - 100
	action_choice_tree = ChooseBehavior.new(self)
	action_choice_tree.execute()

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

func move(args):
	pass