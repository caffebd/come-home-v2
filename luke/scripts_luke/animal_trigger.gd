extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print ("ENERT ANINAL TRIGGER")
		#set_deferred("monitoring", false)
		GlobalSignals.emit_signal("animal_trigger")
		Narration.main_index = Narration.animal_stick_index
		Narration.sub_index = 0
		Narration.narrate()
