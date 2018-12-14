extends Node

const Selector = preload("res://behavior/primitives/Selector.gd")
const Action = preload("res://behavior/primitives/Action.gd")
const HomingMissileAttack = preload("res://behavior/HomingMissileAttack.gd")
const SpreadAttack = preload("res://behavior/SpreadAttack.gd")
const LaserAttack = preload("res://behavior/LaserAttack.gd")
const Rush = preload("res://behavior/Rush.gd")
var tree
var ent

func _init(_ent):
	ent = _ent
	tree = Selector.new()
	tree.add_btchild(\
			Action.new(\
				funcref(ent, "set_behavior_node"),\
				{"new_behavior": HomingMissileAttack, "new_args": ent}))

	tree.add_btchild(\
			Action.new(\
				funcref(ent, "set_behavior_node"),\
				{"new_behavior": Rush, "new_args": ent}))

	tree.add_btchild(\
			Action.new(\
				funcref(ent, "set_behavior_node"),\
				{"new_behavior": LaserAttack, "new_args": ent}))

func execute():
	tree.execute()
