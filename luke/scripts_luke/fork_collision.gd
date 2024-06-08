extends CollisionShape3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.follow_voice.connect(_enable_divider)

func _enable_divider():
	set_deferred("disabled", false)

