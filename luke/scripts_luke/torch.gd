extends Node3D

@onready var body_part := %torchTube
@onready var bulb_part :=%torchHead
@onready var battery_part := %Battery

var collect_state_one: float = 0.15
var collect_state_two: float = 0.4
var collect_state_three: float = 1.0

var mat_1
var mat_2
var mat_3
var mat_4
var mat_5
var mat_6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#mat_1 = mesh_one.get_surface_override_material(0)
	#mat_2 = mesh_one.get_surface_override_material(1)
	#mat_3 = mesh_one.get_surface_override_material(2)
	#mat_4 = mesh_one.get_surface_override_material(3)
	#mat_5 = mesh_two.get_surface_override_material(0)
	#mat_6 = mesh_two.get_surface_override_material(1)


func collected_state(parts: String):
	match parts:
		"torch_body":
			body_part.visible = true
		"bulb":
			bulb_part.visible = true
		"battery":
			battery_part.visible = true
			

#func collected_state(parts: String):
	#match parts:
		#1:
#
			#var tween = create_tween().set_parallel()
			#tween.tween_property(mat_1, "albedo_color:a", collect_state_one, 1.0)
			#tween.tween_property(mat_2, "albedo_color:a", collect_state_one, 1.0)
			#tween.tween_property(mat_3, "albedo_color:a", collect_state_one, 1.0)
			#tween.tween_property(mat_4, "albedo_color:a", collect_state_one, 1.0)
			#tween.tween_property(mat_5, "albedo_color:a", collect_state_one, 1.0)
			#tween.tween_property(mat_6, "albedo_color:a", collect_state_one, 1.0)
			##tween.tween_property(mesh_two, "mesh:material:albedo_color:a", collect_state_one, 1.0)
		#2:
			#var tween = create_tween().set_parallel()
			#tween.tween_property(mat_1, "albedo_color:a", collect_state_two, 1.0)
			#tween.tween_property(mat_2, "albedo_color:a", collect_state_two, 1.0)
			#tween.tween_property(mat_3, "albedo_color:a", collect_state_two, 1.0)
			#tween.tween_property(mat_4, "albedo_color:a", collect_state_two, 1.0)
			#tween.tween_property(mat_5, "albedo_color:a", collect_state_two, 1.0)
			#tween.tween_property(mat_6, "albedo_color:a", collect_state_two, 1.0)
		#3:
			#var tween = create_tween().set_parallel()
			#tween.tween_property(mat_1, "albedo_color:a", collect_state_three, 1.0)
			#tween.tween_property(mat_2, "albedo_color:a", collect_state_three, 1.0)
			#tween.tween_property(mat_3, "albedo_color:a", collect_state_three, 1.0)
			#tween.tween_property(mat_4, "albedo_color:a", collect_state_three, 1.0)
			#tween.tween_property(mat_5, "albedo_color:a", collect_state_three, 1.0)
			#tween.tween_property(mat_6, "albedo_color:a", collect_state_three, 1.0)
