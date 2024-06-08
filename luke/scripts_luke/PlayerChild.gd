extends CharacterBody3D


var  walk_speed:float = 0.75

var jump_height:float = 2.5
#const SENSITIVITY:float = 0.003
const SENSITIVITY:float = 0.0008

const WALK_SPEED: float = 2.0
const RUN_SPEED: float = 4.0

var normal_speed: float = 2.0

@onready var the_torch := %Torch
@onready var the_lamp := %Lamp
@onready var matches := %MatchesHand
@onready var fuel := %FuelHand

@export var attack_marker: Marker3D
@export var rotate_marker: Marker3D
@export var lunge_marker: Marker3D

@export var clearing_two_marker: Marker3D

@export var voice_path_reset_marker: Marker3D
@export var cave_path_reset_marker: Marker3D
@export var lake_path_reset_marker: Marker3D

@export var into_lake_marker: Marker3D
@export var reset_before_lake: Marker3D
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
@onready var hud = %Hud
@onready var hand = %Hand

@onready var dad_gone_drone = %DadGoneDrone

var torch_scene = preload("res://luke/scenes_luke/torch.tscn")
var lamp_scene = preload("res://luke/scenes_luke/Lamp.tscn")

@export var father: CharacterBody3D


@export var wobble_head:bool = true

@export var start_mound_marker: Marker3D
@export var start_clearing_marker: Marker3D
@export var start_night_path_marker: Marker3D
@export var start_fork_marker: Marker3D
@export var start_house_marker: Marker3D
@export var start_cave_maker: Marker3D
@export var in_cave_marker: Marker3D

@export var throwForce = 0.3
@export var followSpeed = 10.0
@export var followDistance = 0.8
@export var maxDistanceFromCamera = 5.0

var current_dragged_item

var dad_gone_sound_played: bool = false

var the_log: Node3D

var use_cursor: bool = false

var too_far: bool = false

var max_dad_dist: float = 10.0

var log_dragging: bool = false

var holding_torch: bool = false

var all_freeze: bool = false

#head wobble settings here

#3
#0.05

var BOB_FREQ = 3.0
var BOB_AMP = 0.05
var t_bob = 0.0

var lean_amount = 1.5
var lean_weight = 0.05

var can_warp: bool = true

var heldObject: RigidBody3D

var joy_rotate_x : float = 0.0
var joy_rotate_y : float = 0.0

var last_distance: float = 0.0

var following_dad: bool = true

var can_trigger_orb: bool = true

var crouching: bool = false

var ready_to_hide: bool = false

var torch_parts: Array[String]
var lamp_parts: Array[String]
#end head wobble settings

var torch: Node3D
var lamp: Node3D

var has_light: bool = false

var light_on: bool = false

var in_dark: bool = false

var path_chosen: String = ""

var being_pulled_lake: bool = false

var can_run: bool = false

var can_start_crouch_timer: bool = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GlobalSignals.start_clearing.connect(_start_clearing)
	GlobalSignals.change_dad_max_dist.connect(_change_dad_max_dist)
	GlobalSignals.clearing_trigger_orb.connect(_clearing_trigger_orb)
	GlobalSignals.player_to_mound.connect(_start_mound)
	GlobalSignals.father_gone.connect(_father_gone)
	GlobalSignals.night_path_set_up.connect(_night_path_set_up)
	GlobalSignals.fork_set_up.connect(_fork_set_up)
	GlobalSignals.item_collected.connect(_item_collected)
	GlobalSignals.start_house.connect(_start_house)
	GlobalSignals.start_in_cave.connect(_start_in_cave)
	GlobalSignals.dark_place.connect(_dark_place)

	GlobalSignals.mouse_capture.connect(_mouse_capture)
	GlobalSignals.mouse_capture_read.connect(_mouse_capture_read)
	GlobalSignals.caught_by_buzz.connect(_caught_by_buzz)
	GlobalSignals.path_chosen.connect(_path_chosen)
	GlobalSignals.pull_into_lake.connect(_pull_into_lake)
	GlobalSignals.start_lake.connect(_start_lake_reset)
	GlobalSignals.orb_to_clearing_two.connect(_clearing_two_start)
	GlobalSignals.voice_to_clearing_two.connect(_clearing_two_start)
	
	GlobalSignals.give_torch.connect(_give_torch)
	GlobalSignals.give_lamp.connect(_give_lamp)
	%SpotLight3D.visible = false
	head.rotation_degrees.y = 0.0
	last_distance = global_position.distance_to(father.global_position)
	
	if hud.use_fade:
		all_freeze = true
	

func _start_mound():
	#Narration.main_index = Narration.mound_index
	global_position = start_mound_marker.global_position

func _start_clearing():
	#Narration.main_index = Narration.clearing_index
	global_position = start_clearing_marker.global_position

func _clearing_trigger_orb():
	can_trigger_orb = true


func _father_gone():
	following_dad = false

func _night_path_set_up():
	following_dad = false
	can_trigger_orb = false
	GlobalSignals.emit_signal("father_gone")
	global_position = start_night_path_marker.global_position

func _fork_set_up():
	following_dad = false
	can_trigger_orb = false
	GlobalSignals.emit_signal("father_gone")
	global_position = start_fork_marker.global_position

func _start_house():
	head.rotation_degrees.y = 0.0
	following_dad = false
	can_trigger_orb = false
	GlobalSignals.emit_signal("father_gone")
	global_position = start_house_marker.global_position	

func _start_in_cave():
	following_dad = false
	can_trigger_orb = false
	GlobalSignals.emit_signal("father_gone")
	
	global_position = in_cave_marker.global_position	

func _clearing_two_start(start_state):
	if start_state:
		jump_height = 3.5
		GlobalSignals.emit_signal("animal_to_lake")
		following_dad = false
		can_trigger_orb = false
		GlobalSignals.emit_signal("father_gone")
		global_position = clearing_two_marker.global_position
		if GlobalVars.path_chosen == "house":
			GlobalSignals.emit_signal("dad_call")
		

func _start_lake_reset():
	head.rotation_degrees.y = 0.0
	GlobalScene.stop_all_music()
	being_pulled_lake = false
	global_position = reset_before_lake.global_position
	if not GlobalVars.path_chosen == "cave":
		GlobalSignals.emit_signal("dad_call")

func _dark_place(state):
	in_dark = state
	if not in_dark:
		normal_speed = 2.0

func _path_chosen(path):
	path_chosen = path
	GlobalVars.path_chosen = path

func _caught_by_buzz():
	if path_chosen == "cave":
		hud.back_to_cave()
	else:
		hud.back_to_house()

func voice_path_reset():
	head.rotation_degrees.y = 0.0
	global_position = voice_path_reset_marker.global_position
	GlobalSignals.emit_signal("stick_create")
	GlobalSignals.emit_signal("show_player_info","I had to find a way to distract that animal.")

func cave_path_reset():
	head.rotation_degrees.y = 0.0
	global_position = cave_path_reset_marker.global_position
	GlobalSignals.emit_signal("show_player_info","I had to find somewhere to hide from that animal.")

func lake_path_reset():
	head.rotation_degrees.y = 0.0
	global_position = lake_path_reset_marker.global_position
	GlobalSignals.emit_signal("show_player_info","I had to run to get away from that animal.")
	if GlobalVars.path_chosen == "house":
		GlobalSignals.emit_signal("dad_call")

func _pull_into_lake():
	being_pulled_lake = true
	GlobalSignals.emit_signal("show_player_info", "I feel something bad would have happened if I had gone that way.")
	await get_tree().create_timer(4.0).timeout
	hud.back_to_lake()
	if GlobalVars.path_chosen == "cave":
		GlobalSignals.emit_signal("orb_lake_reset")
	else:
		GlobalSignals.emit_signal("dad_lake_reset")
		

func run_active():
	GlobalSignals.emit_signal("show_player_info", "Hold 'SHIFT' to run.")
	can_run = true
	await get_tree().create_timer(4.0).timeout
	GlobalSignals.emit_signal("hide_player_info")
	

func _item_collected(item):
	print ("item collected")
	match item:
		"torch_body":
			if not torch_parts.has(item):
				torch_parts.append(item)
				_check_torch_status("torch_body")
		"bulb":
			if not torch_parts.has(item):
				torch_parts.append(item)
				_check_torch_status("bulb")
		"battery":
			if not torch_parts.has(item):
				torch_parts.append(item)
				_check_torch_status("battery")	
		"lamp_body":
			if not lamp_parts.has(item):
				lamp_parts.append(item)
				_check_lamp_status("lamp_body")
		"fuel":
			if not lamp_parts.has(item):
				lamp_parts.append(item)
				_check_lamp_status("fuel")
		"matches":
			if not lamp_parts.has(item):
				lamp_parts.append(item)		
				_check_lamp_status("matches")

func _check_torch_status(part: String):
	match torch_parts.size():
		1:
			pass
			#%HandLight.global_position = %TorchMarker.global_position
			#the_torch.visible = true		
		2:
			pass
		3:
			has_light = true	
			GlobalSignals.emit_signal("show_player_info", "Press 'f' to use.")	
			holding_torch = true
	the_torch.collected_state(part)		

func _check_lamp_status(part: String):
	match part:
		"lamp_body":
			%HandLight.global_position = %LampMarker.global_position
			the_lamp.visible = true
		"fuel":
			fuel.visible = true
		"matches":
			matches.visible = true
			
	if 	lamp_parts.size() == 3:
		has_light = true
		fuel.visible = false
		matches.visible = false
		GlobalSignals.emit_signal("show_player_info", "Press 'f' to use.")	
				
		
		#the_lamp.collected_state(part)	

func _mouse_capture(state):
	use_cursor = state
	if use_cursor:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		hud.exit_cover(true)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		hud.exit_cover(false)

func _mouse_capture_read(state):
	use_cursor = state
	if use_cursor:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

		
func _input(event):
	if all_freeze: return
	
	if event is InputEventMouseMotion:
		if use_cursor:
			return
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60)) 
	
	_controller_support()
	
	if Input.is_action_just_pressed("ui_cancel") and not hud.reading_panel.visible:
		if use_cursor:
			_mouse_capture(false)
			
		else:
			_mouse_capture(true)
			

	if Input.is_action_just_pressed("torch") and has_light:
		%SpotLight3D.visible = !%SpotLight3D.visible
		light_on = %SpotLight3D.visible
		GlobalSignals.emit_signal("light_state", %SpotLight3D.visible)
		if in_dark:
			if not light_on:
				GlobalSignals.emit_signal("show_player_info", "It was so dark I had to walk slowly.")
			else:
				GlobalSignals.emit_signal("hide_player_info")
	if Input.is_action_just_pressed("use"):
		_take_action()
	
	#if Input.is_action_just_pressed("dad_call"):
		#GlobalSignals.emit_signal("dad_call",1)

	if Input.is_action_pressed("crouch"):

		if not crouching:		
			GlobalSignals.emit_signal("hide_player_info")			
			var tween = create_tween()
			tween.tween_property(head, "position:y", 0.2, 0.5)
			crouching = true

		if ready_to_hide and can_start_crouch_timer:
			can_start_crouch_timer = false
			hud.hide_timer.visible = true
			%CrouchTimer.start()


	if Input.is_action_pressed("run") and can_run:
		speed = RUN_SPEED
	else:
		speed = normal_speed	
	
	if Input.is_action_just_released("crouch"):
		hud.hide_timer.value = 100
		hud.hide_timer.visible = false
		can_start_crouch_timer = true
		var tween = create_tween()
		tween.tween_property(head, "position:y", 0.5, 0.5)
		crouching = false
		
	if Input.is_action_just_pressed("skip_end"):
		can_run = true
		_pull_into_lake()
		
func _controller_support():
	
	if Input.is_action_pressed("joy_left"):
		joy_rotate_x = 10.0
	if Input.is_action_just_released("joy_left"):
		joy_rotate_x = 0.0
	if Input.is_action_pressed("joy_right"):
		joy_rotate_x = -10.0
	if Input.is_action_just_released("joy_right"):
		joy_rotate_x = 0.0

	if Input.is_action_pressed("joy_up"):
		joy_rotate_y = 10.0
	if Input.is_action_just_released("joy_up"):
		joy_rotate_y = 0.0
	if Input.is_action_pressed("joy_down"):
		joy_rotate_y = -10.0
	if Input.is_action_just_released("joy_down"):
		joy_rotate_y = 0.0	
	
func _take_action():
	var collider = ray.get_collider()
	if collider != null:
		print (collider.name)
		if collider.is_in_group("collect_item"):
			if collider.get_parent().has_method("item_collected"):
				collider.get_parent().item_collected()
		if collider.is_in_group("reading_material"):
			var text = collider.get_parent().book_text
			GlobalSignals.emit_signal("read", text)
		if collider.get_parent().has_method("interact"):
			collider.get_parent().interact()
		print ("clicked")

func _change_dad_max_dist(dist):
	max_dad_dist = dist

func _physics_process(delta):
	# Add the gravity.
	
	#if %SpotLight3D.visible:
		#%SpotLight3D.global_position = hand.get_child(0).spot_marker.global_position
	
	
	
	if following_dad:
	
		var dist = global_position.distance_to(father.global_position)
		#print (dist)
		if dist > max_dad_dist:
			if not too_far:
				GlobalSignals.emit_signal("show_player_info", "I didn't want to go too far from dad.")
			too_far = true
			normal_speed = 0.75
			if dist > max_dad_dist + 1:
				normal_speed = 0.25
			if dist < last_distance:
				normal_speed = 1.5
		else:
			if too_far:
				GlobalSignals.emit_signal("hide_player_info")
			normal_speed = 2.0
			too_far = false
		
		
		last_distance = dist
	
	if in_dark:
		if light_on:
			normal_speed = 2.0
		else:
			normal_speed = 0.5
	
	handle_holding_objects()
	
	_hud_target()
	
	head.rotate_y(joy_rotate_x * SENSITIVITY)
	camera.rotate_x(joy_rotate_y * SENSITIVITY)
	if joy_rotate_y != 0:
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
	
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
	
	
	if Input.is_action_just_pressed("jump") and is_on_floor() and not crouching:
		%Jump.play()
		velocity.y = jump_height
	
	if Input.is_action_pressed("use"):
		var collider = ray.get_collider()
		if collider != null:

			if collider.get_parent().is_in_group("log"):
				var object = collider.get_parent()
				the_log = object
				the_log.dragged(attack_marker)
				the_log.disable_col()
				log_dragging = true
				%FootLogCollision.disabled = false
				#object.global_position.z = attack_marker.global_position.z
				#object.global_position.x = attack_marker.global_position.x
			if collider.is_in_group("pull_item"):
				#print ("pull item")
				current_dragged_item = collider
				collider.dragged(lunge_marker)
				%HoldingBodyCollision.disabled = false

		else:
			if current_dragged_item != null:
				%HoldingBodyCollision.disabled = true
				
				current_dragged_item.dropped()
				current_dragged_item = null
	
	if Input.is_action_just_released("use"):
		if current_dragged_item != null:
			%HoldingBodyCollision.disabled = true
			current_dragged_item.dropped()
			current_dragged_item = null
		if log_dragging:
			log_dragging = false
			%FootLogCollision.disabled = true
			the_log.enable_col()
			
	
	if being_pulled_lake:
		var direction = global_position.direction_to(into_lake_marker.global_position)
		if global_position.distance_to(into_lake_marker.global_position) > 0.2:
			#rotation.y=lerp_angle(rotation.y,atan2(velocity.x,velocity.z),.1)
			speed = lerp(speed, 6.0, 0.5)
			velocity = direction * speed
			move_and_slide()
		
			return
			
		else:
			
			print ("RESET HERE")
			return
	
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	if crouching: return
	if input_dir != Vector2(0,0) and is_on_floor() and speed >= 1.5:
		hand.get_child(0).push_part.apply_central_impulse(Vector3(input_dir.x/90, 0, input_dir.y/90))
		if holding_torch:
			%TorchMovement.play("torch_move")
		if not %Footsteps.playing:
			%Footsteps.play()
	else:
		%Footsteps.stop()
		if holding_torch:
			%TorchMovement.pause()
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
	
	#if all_freeze:
		#if not is_on_floor():
			#velocity.y -= gravity * delta
			#move_and_slide()


func _hud_target():
	var collider = ray.get_collider()
	if collider != null:
		if collider.is_in_group("highlight"):
			hud.target.modulate = Color(1,1,1,1)
		else:
			hud.target.modulate = Color(1,1,1,0.2)
		#print (collider.name)
		if collider.is_in_group("left_click_prompt"):
			hud.show_left_click.visible = true
		else:
			hud.show_left_click.visible = false
		
		if collider.is_in_group("orb") and can_trigger_orb:
			collider.orb_collider.set_deferred("disabled", true)
			can_trigger_orb = false
			Narration.main_index = Narration.orb_index
			Narration.sub_index = 0
			Narration.narrate()
			GlobalSignals.emit_signal("father_gone")
			await get_tree().create_timer(10.0).timeout
			dad_gone_from_clearing()
			#GlobalSignals.emit_signal("show_narration", "While I was looking, I saw something glowing.")
			#await get_tree().create_timer(5.0).timeout
			#collider.sense_player = true
	else:
		hud.target.modulate = Color(1,1,1,0.2)	
		hud.show_left_click.visible = false

func set_held_object(body):
	if body is RigidBody3D:
		if body.is_in_group("pick_item"):
			heldObject = body
			heldObject.held = true
			heldObject.my_collision.disabled = true
			hud.show_right_click.visible = true

				
	
func drop_held_object():
	heldObject = null
	
func throw_held_object():
	var obj = heldObject
	heldObject.held = false
	if heldObject.has_method("set_thrown"):
		heldObject.set_thrown()
	drop_held_object()
	obj.apply_central_impulse(-camera.global_basis.z * throwForce * 10)
	obj.angular_velocity.z = 2
	obj.gravity_scale = 0.1
	obj.my_collision.disabled = false
	hud.show_right_click.visible = false

func release_held_object():
	if heldObject != null:
		var obj = heldObject
		heldObject.held = false
		drop_held_object()
		obj.my_collision.set_deferred("disabled", false)
		print ("released held object")
	
func handle_holding_objects():
	# Throwing Objects
	if Input.is_action_just_pressed("throw"):
		if heldObject != null: throw_held_object()
		
	# Dropping Objects
	if Input.is_action_just_pressed("use"):
		if ray.is_colliding():
			if heldObject != null: throw_held_object()
			set_held_object(ray.get_collider())
		
	# Object Following
	if heldObject != null:
		var targetPos = camera.global_transform.origin + (camera.global_basis * Vector3(0.25, -0.25, -followDistance)) # 2.5 units in front of camera
		#var targetPos = %HoldPosition.global_transform.origin
		var objectPos = heldObject.global_transform.origin # Held object position
		
		heldObject.linear_velocity = (targetPos - objectPos) * followSpeed # Our desired position
		heldObject.rotation_degrees.z = 90.0
		# Drop the object if it's too far away from the camera
		if heldObject.global_position.distance_to(camera.global_position) > maxDistanceFromCamera:
			drop_held_object()
			
		# Drop the object if the player is standing on it (must enable dropBelowPlayer and set a groundRay/RayCast3D below the player)
		#if dropBelowPlayer && groundRay.is_colliding():
			#if groundRay.get_collider() == heldObject: drop_held_object()

func _headbob(time)->Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ/ 2) * BOB_AMP
	return pos

func _to_menu():
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")



func _on_crouch_timer_timeout() -> void:
	hud.hide_timer.value -= 0.1
	if hud.hide_timer.value <= 0.0:
		%CrouchTimer.stop()
		ready_to_hide = false
		hud.hide_timer.visible = false
		GlobalSignals.emit_signal("hiding")
		GlobalSignals.emit_signal("orb_next_position")
		GlobalSignals.emit_signal("show_player_info", "I think it's gone.")
		can_start_crouch_timer = true


func dad_gone_from_clearing():
	if not dad_gone_sound_played:
		dad_gone_sound_played = true
		%DadGoneDrone.play()
		await get_tree().create_timer(2.4).timeout
		Narration.main_index = Narration.dad_gone_index
		Narration.sub_index = 0
		Narration.narrate()
		#GlobalSignals.emit_signal("orb_sense_player", true)
		GlobalSignals.emit_signal("orb_to_night_path")		


func _give_torch():
	has_light = true	
	GlobalSignals.emit_signal("show_player_info", "Press 'f' to use.")	
	holding_torch = true
	the_torch.collected_state("torch_body")	
	the_torch.collected_state("battery")
	the_torch.collected_state("bulb")		

func _give_lamp():
	has_light = true
	the_lamp.visible = true
