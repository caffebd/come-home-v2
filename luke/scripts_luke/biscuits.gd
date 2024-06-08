extends Node3D


var clicked_once: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact():
	if not clicked_once:
		clicked_once = true
		Narration.main_index = Narration.energy_bisucit_index
		Narration.narrate()
	else:
		GlobalSignals.emit_signal("hide_narration_simple")
		GlobalSignals.emit_signal("show_player_info", "I decdided to eat the biscuits. Hopefully, no-one would mind.")
		queue_free()
