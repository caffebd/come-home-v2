extends Area3D


var used: bool = false

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and not used:
		used = true
		GlobalSignals.emit_signal("dad_to_clearing")
