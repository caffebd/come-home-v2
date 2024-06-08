extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		GlobalSignals.emit_signal("buzz_off")
		GlobalSignals.emit_signal("dark_place", false)
		body.hud.distance_bar.visible = false
		body.jump_height = 3.5
		GlobalSignals.emit_signal("animal_to_lake")
		if GlobalVars.path_chosen == "house":
			GlobalSignals.emit_signal("dad_call")
