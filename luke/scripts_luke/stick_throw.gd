extends RigidBody3D

var held: bool = false

var thrown: bool = false

@onready var my_collision: CollisionShape3D = %MyCollision

@onready var stick_fall_forest: AudioStreamPlayer3D = $StickFallForest

var reset_position: Vector3

func _ready() -> void:
	reset_position = global_position
	GlobalSignals.stick_reset.connect(_reset)

func play_stick_fall():
	thrown = false
	#gravity_scale = 1
	var tween = create_tween()
	tween.tween_property($StickMesh, "mesh:material:albedo_color:a", 0.0, 1.5)
	stick_fall_forest.play()
	GlobalSignals.emit_signal("stick_drop_forest")
	await get_tree().create_timer(0.25).timeout
	queue_free()
	

func _reset():
	queue_free()
	
func set_thrown():
	thrown = true

func _on_drop_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("ground") and thrown:
		play_stick_fall()
		
