extends Node3D


var trans_time: float = 10.0

var cave_trans_time: float = 5.0

var short_trans_time: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.time_transition_0.connect(_time_transition_0)
	GlobalSignals.time_transition_1.connect(_time_transition_1)
	GlobalSignals.time_transition_2.connect(_time_transition_2)
	GlobalSignals.time_transition_3.connect(_time_transition_3)
	GlobalSignals.time_transition_4.connect(_time_transition_4)
	GlobalSignals.time_transition_5.connect(_time_transition_5)
	GlobalSignals.time_transition_6.connect(_time_transition_6)
	GlobalSignals.time_transition_7.connect(_time_transition_7)
	GlobalSignals.time_transition_8.connect(_time_transition_8)
	GlobalSignals.time_transition_9.connect(_time_transition_9)
	
	GlobalSignals.to_night.connect(_to_night)

func _input(event: InputEvent) -> void:
	pass
	#if event.is_action_pressed("night_0"):
		#_time_transition_0()
	#if event.is_action_pressed("night_1"):
		#_time_transition_1()
	#if event.is_action_pressed("night_2"):
		#_time_transition_2()
	#if event.is_action_pressed("night_3"):
		#_time_transition_3()
	#if event.is_action_pressed("night_4"):
		#_time_transition_4()
	#if event.is_action_pressed("night_5"):
		#_time_transition_5()
	#if event.is_action_pressed("night_6"):
		#_time_transition_6()
	#if event.is_action_pressed("night_7"):
		#_time_transition_7()
	#if event.is_action_pressed("night_8"):
		#_time_transition_8()
	#if event.is_action_pressed("night_9"):
		#_time_transition_9()

# DAY TO NIGHT

func _time_transition_0():
	print ("Transition 0")
	var tween = create_tween().set_parallel()
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_top_color", Color("947140"), trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_horizon_color", Color("121d1c"), trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_horizon_color", Color("121d1c"), trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_curve", 0.03306, trans_time)
	tween.tween_property($WorldEnvironment, "environment:ambient_light_sky_contribution", 0.744, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_density", 0.0268, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_length", 79.2, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_ambient_inject", 0.78, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_sky_affect", 0.7528, trans_time)

func _time_transition_1():
	print ("Transition 1")
	pass
	var tween = create_tween().set_parallel()
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_top_color", Color("796440"), trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_horizon_color", Color("253a38"), trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_horizon_color", Color("253a38"), trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_curve", 0.04622, trans_time)
	tween.tween_property($WorldEnvironment, "environment:ambient_light_sky_contribution", 0.808, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_density", 0.0326, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_length", 94.4, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_ambient_inject",0.71, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_sky_affect", 0.8146, trans_time)


func _time_transition_2():
	print ("Transition 2")
	pass
	var tween = create_tween().set_parallel()
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_top_color", Color("5d583f"), trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_horizon_color", Color("375753"), trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_horizon_color", Color("375753"), trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_curve", 0.05938, trans_time)
	tween.tween_property($WorldEnvironment, "environment:ambient_light_sky_contribution", 0.872, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_density", 0.0384, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_length", 109.6, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_ambient_inject", 0.64, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_sky_affect", 0.8764, trans_time)

func _time_transition_3():
	print ("Transition 3")
	pass
	var tween = create_tween().set_parallel()
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_top_color", Color("424b3f"), trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_horizon_color", Color("4a746f"), trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_horizon_color", Color("4a746f"), trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_curve", 0.07254, trans_time)
	tween.tween_property($WorldEnvironment, "environment:ambient_light_sky_contribution", 0.936, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_density", 0.0442, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_length", 124.8, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_ambient_inject", 0.57, trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_sky_affect", 0.9382, trans_time)
	
func _time_transition_4():
	print ("Transition 4")
	pass
	var tween = create_tween().set_parallel()
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_top_color", Color("263e3e"), 5.0)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_horizon_color", Color("5c918b"), 5.0)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_horizon_color", Color("5c918b"), 5.0)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_curve", 0.0857, 5.0)
	tween.tween_property($WorldEnvironment, "environment:ambient_light_sky_contribution", 1.0, 5.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_density", 0.05, 5.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_length", 140.0, 5.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_ambient_inject", 0.5, 5.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_sky_affect", 1.0, 5.0)
	
	# NIGHT TO CAVE
	
func _time_transition_5():
	print ("Transition 5")
	pass
	var tween = create_tween().set_parallel()
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_top_color", Color("000000"), cave_trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_horizon_color", Color("000000"), cave_trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_horizon_color", Color("000000"), cave_trans_time)
	$WorldEnvironment.environment.fog_enabled = true
	tween.tween_property($WorldEnvironment, "environment:fog_light_energy", 1, cave_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_density", 0.0728, cave_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_albedo", Color("000000"), cave_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_emission", Color("213c38"), cave_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_length", 64.0, cave_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_ambient_inject", 0.0, cave_trans_time)
	
	# CAVE ROOM TO EXIT
	
func _time_transition_6():
	print ("Transition 6")
	pass
	var tween = create_tween().set_parallel()	
	$WorldEnvironment.environment.fog_enabled = true
	tween.tween_property($WorldEnvironment, "environment:fog_light_energy", 0, 2)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_density", 0.03, 2.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_albedo", Color("000000"), 2.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_emission", Color("213c38"), 2.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_length", 64.0, 2.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_ambient_inject", 0.0, 2.0)
func _time_transition_7():
	print ("Transition 7")
	pass

func _time_transition_8():
	print ("Transition 8")
	pass

func _time_transition_9():
	print ("Transition 9")
	pass


func _to_night():
	var tween = create_tween().set_parallel()
	

	$WorldEnvironment.environment.fog_enabled = true
	
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_curve", 0.0857, short_trans_time)
	tween.tween_property($WorldEnvironment, "environment:ambient_light_sky_contribution", 1.0, short_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_density", 0.05, short_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_length", 140.0, short_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_ambient_inject", 0.5, short_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_sky_affect", 1.0, short_trans_time)

	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_top_color", Color("000000"), short_trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_horizon_color", Color("000000"), short_trans_time)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_horizon_color", Color("000000"), short_trans_time)
	
	tween.tween_property($WorldEnvironment, "environment:fog_light_energy", 0, short_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_density", 0.03, short_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_albedo", Color("000000"), short_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_emission", Color("213c38"), short_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_length", 64.0, short_trans_time)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_ambient_inject", 0.0, short_trans_time)
