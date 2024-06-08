extends CharacterBody3D


var attack_player: bool = false

var start_pos := Vector3.ZERO

var start_speed: float = 4.0
var close_speed: float = 2.4

@export var player :CharacterBody3D

@export var linked_switch: Node3D

@export var use_speed = 2.5

@export var final_buzz:bool = false

@export var using_navmesh: bool = true

@onready var nav_agent: NavigationAgent3D = %NavAgent

@export var harmless: bool = true

@export var buzz_cave_home: Marker3D
@export var buzz_house_home: Marker3D

var buzz_home: Marker3D

var go_home: bool = false

var buzz_active: bool = false

func _ready():
	start_pos = position
	GlobalSignals.buzz_attack.connect(_buzz_attack)
	GlobalSignals.buzz_active.connect(_set_buzz_active)
	GlobalSignals.buzz_home_set.connect(_buzz_home_set)
	GlobalSignals.light_state.connect(_light_state)
	GlobalSignals.buzz_off.connect(_buzz_off)

func _buzz_home_set(home:String):
	if home == "cave":
		buzz_home = buzz_cave_home
	else:
		buzz_home = buzz_house_home
	global_position = buzz_home.global_position
	buzz_active = true
	harmless = false
	_buzz_attack(true)

func _set_buzz_active(state):
	buzz_active = state

func _light_state(state):
	if buzz_active:
		_buzz_attack(state)

func _buzz_off():
	attack_player = false
	use_speed = start_speed
	buzz_active = false
	harmless = true
	
func _buzz_attack(state):
	if buzz_active:
		print ("buzz attack! "+str(state))
		attack_player = state
		use_speed = start_speed

func _physics_process(delta):
	if harmless: return
	if attack_player:
		if using_navmesh:
			move_using_nav(delta, use_speed)
		else:
			MoveTowardsPoint(delta, use_speed)
		chase_audio(true)
		var player_dist: float = global_position.distance_to(player.global_position)
		player.hud.animal_distance_bar(player_dist)
	else:
		player.hud.distance_bar.visible = false
		var direction = global_position.direction_to(buzz_home.global_position)
		velocity = direction * use_speed
		
		chase_audio(false)
		move_and_slide()

func chase_audio(state):
	if state and not %ChaseSoundA.is_playing():
		%ChaseSoundA.play()
		%BuzzSound.play()
		%BuzzSound.max_distance = 40.0
		var chase_tween = create_tween().set_parallel(true)
		chase_tween.tween_property(%ChaseSoundA, "volume_db", -5.0, 2.0)
		chase_tween.tween_property(%BuzzSound, "volume_db", -5.0, 1.0)
		await chase_tween.finished	
	elif not state and %ChaseSoundA.is_playing():
		var chase_tween = create_tween().set_parallel(true)
		chase_tween.tween_property(%ChaseSoundA, "volume_db", -80.0, 3.0)
		chase_tween.tween_property(%BuzzSound, "volume_db", -80.0, 4.0)
		#chase_tween.tween_property(%BuzzSound, "max_distance", 10.0, 6.0)
		await chase_tween.finished
		%ChaseSoundA.stop()
		%BuzzSound.stop()

func MoveTowardsPoint(delta, speed):
	#var targetPos = navigationAgent.get_next_path_position()
	var direction = global_position.direction_to(player.global_position)
	var dist = global_position.distance_to(player.global_position)
	if dist < 7.0:
		use_speed = close_speed
	else:
		use_speed = start_speed
	faceDirection(player.position)
	velocity = direction * speed
	move_and_slide()


	

func nav_towards_point(delta, speed):
	var targetPos = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(targetPos)
	faceDirection(player.position)
	velocity = direction * speed
	move_and_slide()

func move_using_nav(delta, speed):
	nav_agent.set_target_position(player.global_position)
	nav_towards_point(delta, speed)
	var distance_to_player:float = global_position.distance_to(player.global_position)	

func faceDirection(direction : Vector3):
	look_at(Vector3(direction.x, global_position.y, direction.z), Vector3.UP)


func _on_death_area_body_entered(body):
	if body.get_groups().has("player") and not harmless:
		attack_player = false
		print ("reload")
		if final_buzz:
			call_deferred("game_over_call")
		else:
			print ("CAUGHT BY BUZZZZ") 
			GlobalSignals.emit_signal("caught_by_buzz")
			#player.playing_active = false	
			#player.hud.cover_fade_death()

func game_over_call():
	print ("CAUGHT BY BUZZZZ")
	#get_tree().change_scene_to_file("res://scenes/outro.tscn")

func _on_warn_area_body_entered(body):
	if body.get_groups().has("player"):
		pass
		#use_speed = close_speed
		#if linked_switch!=null: linked_switch.flicker()
