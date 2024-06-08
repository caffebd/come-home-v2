extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.ready_to_hide = true
		GlobalSignals.emit_signal("hide_narration_simple")
		GlobalSignals.emit_signal("show_player_info", "'c' to crouch")
		#GlobalSignals.emit_signal("hiding")


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		GlobalSignals.emit_signal("hide_player_info")
