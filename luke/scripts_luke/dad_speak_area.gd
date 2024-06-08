extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		set_deferred("monitoring", false)
		GlobalSignals.emit_signal("dad_use_log")
		GlobalSignals.emit_signal("show_speech", "Saif, drag that log over and use it to climb up.")
		GlobalSignals.emit_signal("log_emit")
		GlobalSignals.emit_signal("change_dad_max_dist", 8.0)
		GlobalSignals.emit_signal("dad_repeat_log", true)
