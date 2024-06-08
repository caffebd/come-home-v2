extends Node3D

@onready var mesh_one := $RigidBody3D2/Sphere
@onready var push_part:= $RigidBody3D2

@onready var spot_marker := %SpotMarker

var collect_state_one: float = 0.25
var collect_state_two: float = 0.4
var collect_state_three: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.light_state.connect(_wick)
	$RigidBody3D2/Sphere.get_surface_override_material(0).albedo_color.a = 0.0


func _wick(state):
	if not state:
		$RigidBody3D2/Sphere.get_surface_override_material(0).albedo_color.a = 0.0
	else:
		$RigidBody3D2/Sphere.get_surface_override_material(0).albedo_color.a = 1.0


#func collected_state(parts: String):
	#match parts:
		#"lamp_body":
			#body_part.visible = true
		#"bulb":
			#bulb_part.visible = true
		#"battery":
			#battery_part.visible = true

func collected_state(parts: int):
	match parts:
		1:
			var mat = $RigidBody3D2/Sphere.get_surface_override_material(2)
			var tween = create_tween()
			tween.tween_property(mat, "albedo_color:a", collect_state_one, 1.0)

		2:
			var mat = $RigidBody3D2/Sphere.get_surface_override_material(2)
			var tween = create_tween()
			tween.tween_property(mat, "albedo_color:a", collect_state_two, 1.0)

		3:
			var mat = $RigidBody3D2/Sphere.get_surface_override_material(2)
			var tween = create_tween()
			tween.tween_property(mat, "albedo_color:a", collect_state_three, 1.0)
