extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.dad_end_call.connect(_dad_end_call)

func _dad_end_call():
	$DadEndCallAudio.play()
	await get_tree().create_timer(5.0)
	GlobalSignals.emit_signal("show_speech", "Saif... Saif... Saif!")



func _on_dad_end_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.hud.fade_to_end()
