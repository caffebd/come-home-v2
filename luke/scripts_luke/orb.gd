extends CharacterBody3D

@export var clearing_markers: Array[Marker3D]
@export var path_one_markers: Array[Marker3D]
@export var cave_path_markers: Array[Marker3D]

@export var ghost_markers: Array[Marker3D]

@export var player: CharacterBody3D
@export var father: CharacterBody3D

@export var breath_1: AudioStreamPlayer3D
@export var breath_2: AudioStreamPlayer3D
@export var breath_3: AudioStreamPlayer3D

@export var wait_at_path_marker: Marker3D

@onready var orb_collider: CollisionShape3D = %OrbCollider



var use_check_points: Array[Marker3D]

enum {CLEARING, PATHONE, CAVE, GHOST}

var  speed = 10.0

var intro_orb_speech: bool = false

var target_position: Vector3

var check_index:int = 0#

var moving: bool = false

var sense_player: bool = false

var start_speed = 40.0

var timer_running: bool = false

var on_path_one: bool = false

var to_lake_path: bool = false

var no_slow: bool = false

func _ready() -> void:
	GlobalSignals.clearing_trigger_orb.connect(_clearing_trigger_orb)
	GlobalSignals.orb_sense_player.connect(_orb_sense_player)
	GlobalSignals.orb_next_position.connect(_orb_next_position)
	GlobalSignals.night_path_set_up.connect(_night_path_set_up)
	GlobalSignals.orb_to_night_path.connect(_night_path_set_up)
	GlobalSignals.cave_path_set_up.connect(_cave_path_set_up)
	GlobalSignals.cave_path_trigger.connect(_cave_path_trigger)
	GlobalSignals.fork_set_up.connect(_fork_set_up)
	GlobalSignals.cave_path_reset.connect(_cave_path_reset)
	GlobalSignals.orb_to_clearing_two.connect(_clearing_two)
	GlobalSignals.orb_lake_reset.connect(_lake_reset)
	GlobalSignals.orb_lake_player_caught.connect(_lake_player_caught_reset)
	_set_check_points(CLEARING)
	await get_tree().create_timer(3.0).timeout
	moving = false
	$OrbHover.play("hover")


func _clearing_trigger_orb():
	speed = start_speed
	moving = false
	check_index = 0
	sense_player = false
	_next_position()
	#var tween = create_tween()
	#tween.tween_property(self, "global_position:y", 9.4, 5.0)


func _night_path_set_up():
	moving = false
	global_position = clearing_markers[clearing_markers.size()-1].global_position
	_set_check_points(PATHONE)
	check_index = 0
	sense_player = true
	timer_running = true
	on_path_one = true

func _fork_set_up():
	moving = false
	global_position = path_one_markers[path_one_markers.size()-1].global_position
	_set_check_points(CAVE)
	check_index = 0
	sense_player = true
	timer_running = true
	on_path_one = true

func _cave_path_set_up():
	moving = false
	global_position = path_one_markers[path_one_markers.size()-1].global_position
	_set_check_points(CAVE)
	check_index = 0
	sense_player = true
	timer_running = true

func _cave_path_reset():
	moving = false
	global_position = cave_path_markers[2].global_position
	_set_check_points(CAVE)
	check_index = 2
	sense_player = true


func _cave_path_trigger():
	moving = false
	on_path_one = false
	#global_position = path_one_markers[path_one_markers.size()-1].global_position
	_set_check_points(CAVE)
	check_index = 0
	sense_player = true
	timer_running = true
	GlobalVars.path_chosen = "cave"
	_next_position()

func _clearing_two(start_state):
	moving = false
	visible = true
	_set_check_points(GHOST)
	check_index = 0
	sense_player = true
	timer_running = true
	global_position = ghost_markers[0].global_position

func _lake_reset():
	_set_check_points(GHOST)
	visible = true
	check_index = 10
	sense_player = true
	global_position = ghost_markers[10].global_position

func _lake_player_caught_reset():
	check_index = 1
	sense_player = true
	global_position = ghost_markers[1].global_position	

func _orb_sense_player(state):
	sense_player = state

func _orb_next_position():
	_next_position()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	
	var player_dist: float = global_position.distance_to(player.global_position)
	#print (player_dist)
	
	var factor = 1.0
	if player_dist < 4:
		factor = 0.2
	elif player_dist < 8:
		factor = 0.4
	elif  player_dist <12:
		factor = 0.6
	elif  player_dist <16:
		factor = 0.8
	elif player_dist >= 16:
		factor = 1.0
	var set_scale = Vector3(factor, factor, factor)
	$orbplane.scale = lerp($orbplane.scale, Vector3(factor,factor,factor), 0.05)
	#clamp(set_scale, Vector3(0.2, 0.2, 0.2), Vector3(1.0, 1.0, 1.0))
	#print ($orbplane.scale)
	if player_dist < 4.0 and sense_player:
		print ("PLAYER CLOSE")
		sense_player = false
		_next_position()
		%SenseTimer.start()
	
	if not moving: return

	var direction = global_position.direction_to(target_position)
	if global_position.distance_to(target_position) > 0.2:
		#rotation.y=lerp_angle(rotation.y,atan2(velocity.x,velocity.z),.1)
		#speed = lerp(10, speed, 0.5)
		if speed > 2:
			speed *= 0.95
		velocity = direction * speed
	else:
		moving = false
		if not father.visible:
			sense_player = true
	_face_direction(player.position)
	
	move_and_slide()


func _face_direction(direction: Vector3):
	look_at(Vector3(direction.x, global_position.y, direction.z), Vector3.UP)
	

func _set_check_points(phase):
	use_check_points.clear()
	match phase:
		CLEARING:
			on_path_one = false
			to_lake_path = false
			use_check_points = clearing_markers.duplicate()
		PATHONE:
			on_path_one = true
			to_lake_path = false
			use_check_points = path_one_markers.duplicate()
		CAVE:
			on_path_one = false
			to_lake_path = false
			use_check_points = cave_path_markers.duplicate()
		GHOST:
			on_path_one = false
			to_lake_path = true
			use_check_points = ghost_markers.duplicate()

func _next_position():
	print (use_check_points.size())
	if check_index < use_check_points.size():
		target_position = use_check_points[check_index].global_position
		speed = start_speed
		moving = true
		_check_for_narration(use_check_points[check_index].name)
		print ("select next")
		check_index += 1
	else:
		print ("orb select done")
		moving = false
		timer_running = false
		%SenseTimer.stop()
		sense_player = false
		check_index = 0
		if on_path_one:
			#on_path_one = false
			target_position = wait_at_path_marker.global_position
			speed = start_speed
			_set_check_points(CAVE)
			check_index = 0
			sense_player = true
			timer_running = true
			on_path_one = true
			print ("wait at path")
		else:
			visible = false
			if to_lake_path: visible = true

		

func _check_for_narration(check_point: String):
	print(check_point)
	match check_point:
		"OrbNight1":
			GlobalSignals.emit_signal("time_transition_0")
			Narration.main_index = Narration.night_path_index
			Narration.sub_index = 0
			Narration.narrate()
		"OrbNight2":
			GlobalSignals.emit_signal("time_transition_1")
			Narration.main_index = Narration.night_path_index + 1
			Narration.sub_index = 0
			Narration.narrate()
		"OrbNight4":
			GlobalSignals.emit_signal("time_transition_2")
			Narration.main_index = Narration.night_path_index + 2
			Narration.sub_index = 0
			Narration.narrate()		
		"OrbNight6":
			GlobalSignals.emit_signal("time_transition_3")
			breath_1.play()
		"OrbNight8":
			Narration.main_index = Narration.night_path_index + 3
			Narration.sub_index = 0
			Narration.narrate()
		"OrbNight9":
			GlobalSignals.emit_signal("time_transition_4")
			breath_2.play()
		"OrbC12":
			Narration.main_index = Narration.hungry_index
			Narration.sub_index = 0
			Narration.narrate()
		"OrbC13":
			Narration.main_index = Narration.dad_not_working_index
			Narration.sub_index = 0
			Narration.narrate()


		#"OrbNight10":
			#Narration.narrate()
		#"OrbNight11":
			#moving = false
			#timer_running = false
			#%SenseTimer.stop()
			#sense_player = false

			
func _on_sense_timer_timeout() -> void:
	if timer_running: sense_player = true
