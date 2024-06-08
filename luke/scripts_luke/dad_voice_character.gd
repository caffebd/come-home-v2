extends CharacterBody3D

@export var player: CharacterBody3D

@export var to_house_markers: Array[Marker3D]

@export var ghost_markers: Array[Marker3D]

var use_check_points: Array[Marker3D]

enum {HOUSEPATH, GHOST}

var  speed = 15.0


var target_position: Vector3

var check_index:int = 0#

var moving: bool = false

var sense_player: bool = false

var player_sense_dist: float = 18.0

var lake_path: bool = false

func _ready() -> void:
	GlobalSignals.fork_set_up.connect(_fork_set_up)
	GlobalSignals.follow_voice.connect(_follow_voice)
	GlobalSignals.voice_to_clearing_two.connect(_clearing_two)
	GlobalSignals.dad_lake_reset.connect(_lake_reset)
	GlobalSignals.voice_path_reset.connect(_voice_path_reset)
	GlobalSignals.voice_lake_player_caught.connect(_lake_player_caught_reset)
	%DadVoice.player = player
	#print ("hosue markers "+str(to_house_markers.size()))
	#_fork_set_up()


	

func _fork_set_up():
	check_index = 0
	global_position = to_house_markers[0].global_position
	_set_check_points(HOUSEPATH)

func _clearing_two(start_state):
	moving = false
	#global_position = path_one_markers[path_one_markers.size()-1].global_position
	_set_check_points(GHOST)
	check_index = 0
	sense_player = true
	player_sense_dist = 8.0
	global_position = ghost_markers[0].global_position
	lake_path = true
	


func _lake_reset():
	print ("LAKE RESET AFTER DROWN")
	_set_check_points(GHOST)
	check_index = 10
	
	global_position = ghost_markers[10].global_position
	print ("GM PS "+str(ghost_markers[10].global_position))
	lake_path = true
	#%DadVoice.voice_blocked = true
	await get_tree().create_timer(10.0).timeout
	sense_player = true
	#print (str(check_index) + str("sense player actuve"))
	#print ("MY VOICE PS "+str(global_position))
	global_position = ghost_markers[10].global_position

func _lake_player_caught_reset():
	print ("LAKE RESET AFER ANIMAL CATC")
	check_index = 1
	sense_player = true
	global_position = ghost_markers[1].global_position	
	GlobalSignals.emit_signal("dad_call")
	lake_path = true
	
func _voice_path_reset():
	check_index = 1
	global_position = to_house_markers[1].global_position

func _follow_voice():
	print ("follwo dad voice")
	_set_check_points(HOUSEPATH)
	_next_position()

func _physics_process(delta: float) -> void:
	var player_dist: float = global_position.distance_to(player.global_position)
	#print (player_dist)
	if player_dist < player_sense_dist and sense_player:
		print ("PLAYER CLOSE")
		sense_player = false
		_next_position()
		#%SenseTimer.start()
	
	if not moving: return

	var direction = global_position.direction_to(target_position)
	if global_position.distance_to(target_position) > 0.2:
		sense_player = false
		#rotation.y=lerp_angle(rotation.y,atan2(velocity.x,velocity.z),.1)
		speed = lerp(speed, 4.0, 0.5)
		velocity = direction * speed
	else:
		moving = false
		sense_player = true

	move_and_slide()


func _next_position():
	print (use_check_points.size())
	if check_index < use_check_points.size():
		target_position = use_check_points[check_index].global_position
		moving = true
		sense_player = true
		_check_for_narration(use_check_points[check_index].name)
		print ("select next "+use_check_points[check_index].name)
		check_index += 1
		#GlobalSignals.emit_signal("dad_call", 3)
	else:
		print ("select done")
		moving = false
		sense_player = false
		check_index = 0


func _check_for_narration(check_point: String):
	print(check_point)
	match check_point:
		"VoicePath8":
			Narration.main_index = Narration.hungry_index
			Narration.sub_index = 0
			Narration.narrate()
		"VoicePath9":
			Narration.main_index = Narration.dad_not_working_index
			Narration.sub_index = 0
			Narration.narrate()

func _set_check_points(phase):
	use_check_points.clear()
	match phase:
		HOUSEPATH:
			use_check_points = to_house_markers.duplicate()
		GHOST:
			use_check_points = ghost_markers.duplicate()
	
