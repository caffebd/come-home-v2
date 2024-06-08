extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.drop_dome.connect(_dome_active)


func _dome_active(state):
	visible = state
	if visible:
		$SphereAnim.play("pulse")
	else:
		$SphereAnim.stop()
