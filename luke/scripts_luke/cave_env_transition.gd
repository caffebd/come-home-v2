extends Area3D

var block_player: bool = false

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	GlobalSignals.start_in_cave.connect(_start_cave_set_up)

func _start_cave_set_up():
	block_player = true
	%GoBackBlockColl.disabled = false

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if not block_player:
			GlobalSignals.emit_signal("time_transition_4")
			block_player = true
		else:
			body.normal_speed = 0.2
			GlobalSignals.emit_signal("show_player_info", "I didn't want to go back the way I came.")


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		%GoBackBlockColl.set_deferred("disabled", false)
		if block_player:
			body.normal_speed = 2.0
			GlobalSignals.emit_signal("hide_player_info")
