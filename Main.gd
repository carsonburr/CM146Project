extends Node

func _on_shoot(bullet, _position, _direction):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction)

