extends Area3D

var passed_through: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if not passed_through:
			print ("go voie route")
			passed_through = true
			GlobalScene.start_bg_music_again()
			GlobalSignals.emit_signal("follow_voice")
			%BlockCollisionVoice.set_deferred("disabled", false)
		else:
			GlobalSignals.emit_signal("show_player_info", "I knew there was no going back.")
