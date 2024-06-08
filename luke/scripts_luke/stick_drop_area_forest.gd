extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("pick_item"):
		if body.held == false:
			GlobalSignals.emit_signal("stick_drop_forest")
			if body.has_method("play_stick_fall"):
				body.play_stick_fall()
			await get_tree().create_timer(3.0).timeout
			body.queue_free()
