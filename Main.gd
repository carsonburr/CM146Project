extends Node

func _on_shoot(bullet, _position, _direction):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction)

func _on_Boss_respawn_laser(laser, _position, _direction):
	var la = laser.instance()
	add_child(la)
	# print("added laser")
	la.start(_position, _direction)