extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = false
	GlobalSignals.father_gone.connect(_start_monitor)

func _start_monitor():
	monitoring = true



func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		set_deferred("monitoring", false)
		Narration.main_index = Narration.leave_clearing_index
		Narration.sub_index = 0
		Narration.narrate()
		await get_tree().create_timer(5.0).timeout
		GlobalScene.start_night_path_music()
		
