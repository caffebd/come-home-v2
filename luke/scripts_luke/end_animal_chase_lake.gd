extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		GlobalSignals.emit_signal("stick_drop_forest")
		GlobalSignals.emit_signal("show_player_info", "I manged to get away from whatever that was. This night was nearly over.")
		GlobalScene.stop_saif_theme()
		if GlobalVars.path_chosen == "house":
			GlobalSignals.emit_signal("dad_lake_reset")
