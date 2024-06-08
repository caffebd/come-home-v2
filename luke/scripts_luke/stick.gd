extends RigidBody3D

var held: bool = false

@onready var my_collision: CollisionShape3D = %MyCollision

@onready var stick_fall_forest: AudioStreamPlayer3D = $StickFallForest


func play_stick_fall():
	gravity_scale = 1
	var tween = create_tween()
	tween.tween_property($StickMesh, "mesh:material:albedo_color:a", 0.0, 1.5)
	stick_fall_forest.play()
