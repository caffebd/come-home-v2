extends Node3D

@export var item_name: String



func item_collected():
	print ("click collected")
	GlobalSignals.emit_signal("item_collected", item_name)
	queue_free()
