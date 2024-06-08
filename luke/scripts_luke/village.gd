extends Node3D

var fade_in: bool = false

#480 test steam add id
var app_id = "480"

var throw_stick_scene = preload("res://luke/scenes_luke/stick_throw.tscn")

@export var throw_stick_marker_node: Node3D

enum {PATH, CLEARING, LOST, CHOICE, CAVE, HOUSE, FINAL}

#func _init() -> void:
	#OS.set_environment("SteamAppID", app_id)
	#OS.set_environment("SteamGameID", app_id)	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#steam_init()
	$path.visible = false
	GlobalSignals.stick_create.connect(_set_throw_sticks)
	#GlobalSignals.emit_signal("start_house")
	#GlobalSignals.emit_signal("start_in_cave")
	#GlobalSignals.emit_signal("start_clearing")
	#GlobalSignals.emit_signal("fork_set_up")
	#GlobalSignals.emit_signal("dad_to_mound")
	#GlobalSignals.emit_signal("night_path_set_up")
	#GlobalSignals.emit_signal("orb_to_clearing_two")
	#GlobalSignals.emit_signal("start_lake")
	
	_set_throw_sticks()
	_start_chapter()

	
	
	#GlobalSignals.emit_signal("night_path_set_up")
	#GlobalSignals.emit_signal("fork_set_up")
	
	
	#var tween = create_tween().parallel()
	#tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_top_color", Color("327085"), 2.0)
	#tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_horizon_color", Color("000000"), 2.0)
	#tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_horizon_color", Color("000000"), 2.0)
	#tween.tween_property($WorldEnvironment, "environment:volumetric_fog_albedo", Color("3c3c3c"), 2.0)
	#tween.tween_property($WorldEnvironment, "environment:volumetric_fog_emission", Color("0f2722"), 2.0)
	#tween.tween_property($WorldEnvironment, "environment:volumetric_fog_density", 0.05, 2.0)
	#tween.tween_property($sun, "light_energy", 0.0, 2.0)
	#tween.tween_property($moon, "light_energy", 0.08, 2.0)
	#%WorldEnvironment.environment.sky.sky_material.sky_top_color = Color("a1a95a")

func _start_chapter():
	match GlobalVars.selected_chapter:
		PATH:
			pass
			#GlobalSignals.emit_signal("dad_to_mound")
			#GlobalSignals.emit_signal("player_to_mound")
		CLEARING:
			GlobalSignals.emit_signal("start_clearing")
		LOST:
			GlobalSignals.emit_signal("night_path_set_up")
		CHOICE:
			GlobalSignals.emit_signal("time_transition_4")
			GlobalSignals.emit_signal("fork_set_up")
		CAVE:
			GlobalSignals.emit_signal("time_transition_4")
			GlobalSignals.emit_signal("path_chosen", "cave")
			GlobalSignals.emit_signal("start_in_cave")
		HOUSE:
			GlobalSignals.emit_signal("time_transition_4")
			GlobalSignals.emit_signal("path_chosen", "house")
			GlobalSignals.emit_signal("start_house")
		FINAL:
			GlobalSignals.emit_signal("time_transition_4")
			if GlobalVars.path_chosen == "" or GlobalVars.path_chosen == "cave":
				GlobalVars.path_chosen = "cave"
				GlobalSignals.emit_signal("orb_to_clearing_two", true)
				GlobalSignals.emit_signal("give_lamp")
				GlobalScene.start_saif_theme()
				#GlobalSignals.emit_signal("pull_into_lake")
				#GlobalSignals.emit_signal("dad_call")
			else:
				GlobalVars.path_chosen = "house"
				GlobalScene.start_saif_theme()
				GlobalSignals.emit_signal("give_torch")
				GlobalSignals.emit_signal("voice_to_clearing_two", true)
				#GlobalSignals.emit_signal("pull_into_lake")
				#GlobalSignals.emit_signal("dad_call")
				
	await get_tree().create_timer(2.0).timeout
	GlobalSignals.emit_signal("start_game")
	
func _set_throw_sticks():
	for s in throw_stick_marker_node.get_children():
		var stick_throw = throw_stick_scene.instantiate()
		throw_stick_marker_node.add_child(stick_throw)
		stick_throw.global_position = s.global_position

#func steam_init():
	#Steam.steamInit()
	#var is_running = Steam.isSteamRunning()
	#if !is_running:
		#print ("ERROR.... STEAM NOT RUNNING")
		#return
	#
	#print ("STEAM RUNNING")
	#
	#var steam_id = Steam.getSteamID()
	#var steam_name = Steam.getFriendPersonaName(steam_id)
	#
	#print ("Welcome "+str(steam_name))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
