extends CharacterBody3D


const WALK_SPEED:float = 0.75

const JUMP_VELOCITY:float = 0.0
#const SENSITIVITY:float = 0.003
const SENSITIVITY:float = 0.0008



@export var attack_marker: Marker3D
@export var rotate_marker: Marker3D
@export var lunge_marker: Marker3D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 2.0

const BASE_FOV = 70.0
const FOV_CHANGE = 1.5

var constant_wobble:bool = false

#@onready var head = %Head
@onready var camera = %PlayerCam
@onready var ray: RayCast3D = %PlayerRay
@onready var player_hand = %Hand
@onready var head = %Head



@export var wobble_head:bool = true


var use_cursor: bool = false

#head wobble settings here

#3
#0.05

var BOB_FREQ = 3.0
var BOB_AMP = 0.05
var t_bob = 0.0

var lean_amount = 1.5
var lean_weight = 0.05

var can_warp: bool = true

@export var start_clearing_marker: Marker3D

#end head wobble settings

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GlobalSignals.start_clearing.connect(_start_clearing)
	
	#camera.current = false

func _start_clearing():
	global_position = start_clearing_marker.global_position

							
func _input(event):
	if event is InputEventMouseMotion:
		if use_cursor:
			return
		head.rotate_y(-event.relative.x * SENSITIVITY)
		#rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60)) 
	if Input.is_action_just_pressed("ui_cancel"):
		if use_cursor:
			use_cursor = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			use_cursor = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("torch"):
		%SpotLight3D.visible = !%SpotLight3D.visible


	
func _take_action():
	var collider = ray.get_collider()
	if collider != null:
		print ("clicked")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()

	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * 2.0
	var query = PhysicsRayQueryParameters3D.create(origin, end)

	var result = space_state.intersect_ray(query)
	
	
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("use"):
		var collider = ray.get_collider()
		if collider != null:
			print (collider.name)
			if collider.get_parent().is_in_group("log"):
				print ("is log")
				var object = collider.get_parent()
				object.global_position.z = attack_marker.global_position.z
				object.global_position.x = attack_marker.global_position.x
	
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			#velocity.x = direction.x * speed
			#velocity.z = direction.z * speed
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)


	if wobble_head:
		if input_dir.x>0:
			head.rotation.z = lerp_angle(head.rotation.z, deg_to_rad(-lean_amount), lean_weight)
		elif input_dir.x<0:
			head.rotation.z = lerp_angle(head.rotation.z, deg_to_rad(lean_amount), lean_weight)
		else:
			head.rotation.z = lerp_angle(head.rotation.z, deg_to_rad(0), lean_weight)
		
		if not constant_wobble:	
			t_bob += delta * velocity.length() * float(is_on_floor())
			camera.transform.origin =_headbob(t_bob)

	if constant_wobble:
		t_bob += delta * 2.0 * float(is_on_floor())
		camera.transform.origin =_headbob(t_bob)


	move_and_slide()


func _headbob(time)->Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ/ 2) * BOB_AMP
	return pos

func _to_menu():
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
