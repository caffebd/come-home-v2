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
		body.jump_height = 3.5
		GlobalScene.start_saif_theme()
		Narration.main_index = Narration.not_quit_index
		Narration.sub_index = 0
		Narration.narrate()
		
