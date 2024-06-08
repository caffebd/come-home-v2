extends Area3D

var can_monitor: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.father_gone.connect(_father_gone)
	monitoring = can_monitor

func _father_gone():
	can_monitor = true
	monitoring = can_monitor



func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		can_monitor = false
		set_deferred("monitoring", can_monitor)
		body.dad_gone_from_clearing()
