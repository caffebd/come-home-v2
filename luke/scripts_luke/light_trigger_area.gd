extends Area3D

@export var trigger_number:int = 0

var trigger_array:Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trigger_array.append("time_transition_0")
	trigger_array.append("time_transition_1")
	trigger_array.append("time_transition_2")
	trigger_array.append("time_transition_3")
	trigger_array.append("time_transition_4")
	trigger_array.append("time_transition_5")
	trigger_array.append("time_transition_6")
	trigger_array.append("time_transition_7")
	trigger_array.append("time_transition_8")
	trigger_array.append("time_transition_9")

	




func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if trigger_number < trigger_array.size():
			var trigger_to_use = trigger_array[trigger_number]
			print (trigger_to_use)
			GlobalSignals.emit_signal(trigger_to_use)
