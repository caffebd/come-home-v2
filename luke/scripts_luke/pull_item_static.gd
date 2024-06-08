extends StaticBody3D

var dragging: bool = false

var target_pos: Vector3

var follow_speed :float = 20.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var can_fall: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if dragging:
		global_position.z = target_pos.z
		global_position.x = target_pos.x
		global_position.y = target_pos.y
		#constant_linear_velocity = (target_pos - global_position) * follow_speed
	else:
		if can_fall:
			#print ("falling")
			global_position.y -= 3.0 * delta
			

func dragged(drag_marker):
	#print ("dragged")
	target_pos = drag_marker.global_position
	dragging = true

func dropped():
	dragging = false
	can_fall = true


func _on_fall_area_body_entered(body: Node3D) -> void:
	if not dragging:
		can_fall = false
		
