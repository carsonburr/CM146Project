extends Node

const Selector = preload("res://behavior/primitives/Selector.gd")
const Action = preload("res://behavior/primitives/Action.gd")
const SpreadAttack = preload("res://behavior/SpreadAttack.gd")
var tree
var ent

func _init(_ent):
	ent = _ent
	tree = Selector.new()
	tree.add_btchild(\
			Action.new(\
				funcref(ent, "set_behavior_node"),\
				{"new_behavior": SpreadAttack, "new_args": ent}))

func execute():
	tree.execute()