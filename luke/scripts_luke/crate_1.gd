extends RigidBody3D

var dragging: bool = false

var target_pos: Vector3

var follow_speed :float = 20.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var can_fall: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		#freeze = false
		linear_velocity = (target_pos - global_position) * follow_speed 
	#else:
		#if $RayA.is_colliding() or $RayA2.is_colliding():
			#print ("sleep npw")
			#sleeping = true
	#else:
		#if can_fall:
			#linear_velocity.y -= gravity * delta

			#print (abs(angular_velocity.length()))

func dragged(drag_marker):
	axis_lock_angular_x = true
	axis_lock_angular_y = true
	axis_lock_angular_z = true
	target_pos = drag_marker.global_position
	dragging = true

func dropped():
	print ("dropped")
	dragging = false
	axis_lock_angular_x = false
	axis_lock_angular_y = false
	axis_lock_angular_z = false
