extends Area3D

var play_night: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if play_night:
			play_night = false
			GlobalScene.start_night_path_music_lake()
		else:
			play_night = true
			GlobalScene.stop_all_music()
			
