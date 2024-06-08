extends Area3D

var saif_music: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if saif_music:
			saif_music = false
			GlobalScene.start_saif_theme()
			if GlobalVars.path_chosen == "house":
				GlobalSignals.emit_signal("stop_dad_calling")
		else:
			saif_music = true
			GlobalScene.stop_all_music()
			if GlobalVars.path_chosen == "house":
				GlobalSignals.emit_signal("dad_call")
