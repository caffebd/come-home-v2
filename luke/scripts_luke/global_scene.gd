extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func start_bg_music():
	var tween = create_tween()
	tween.tween_property(%BgMusic, "volume_db", -10.0,  5.0)
	%BgMusic.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func start_night_path_music():
	$NightPathMusic.play()
	$NightPathMusic.volume_db = 0.0
	var tween = create_tween()
	tween.tween_property(%BgMusic, "volume_db", -80.0,  10.0)
	await tween.finished
	%BgMusic.stop()


func start_night_path_music_lake():
	$NightPathMusic.play()
	var tween = create_tween().set_parallel()
	tween.tween_property(%SaifTheme, "volume_db", -80.0,  6.0)
	tween.tween_property($NightPathMusic, "volume_db", 0.0,  6.0)
	await tween.finished
	%SaifTheme.stop()

func start_saif_music_turned_around():
	$SaifTheme.play()
	var tween = create_tween()
	tween.tween_property($NightPathMusic, "volume_db", -80.0,  6.0)
	tween.tween_property(%SaifTheme, "volume_db", -15.0,  6.0)
	await tween.finished
	$NightPathMusic.stop()

func start_bg_music_again():
	var tween = create_tween()
	tween.tween_property(%NightPathMusic, "volume_db", -80.0,  5.0)
	%BgMusic.play()
	var tween_2 = create_tween()
	tween_2.tween_property(%BgMusic, "volume_db", -10.0,  5.0)
	await tween_2.finished
	%NightPathMusic.stop()
	
func stop_bg_music():
	var tween = create_tween()
	tween.tween_property(%BgMusic, "volume_db", -80.0,  10.0)
	await tween.finished
	%BgMusic.stop()

func stop_saif_theme():
	var tween = create_tween()
	tween.tween_property(%SaifTheme, "volume_db", -80.0,  10.0)
	await tween.finished
	%SaifTheme.stop()
	
func start_saif_theme():
	%SaifTheme.volume_db = -15
	%SaifTheme.play()
	print ("start saif theme")
	#var tween = create_tween()
	#tween.tween_property(%SaifTheme, "volume_db", 0.0,  5.0)


func stop_all_music():
	var tween = create_tween().set_parallel()
	tween.tween_property(%SaifTheme, "volume_db", -80.0,  1.0)
	tween.tween_property(%BgMusic, "volume_db", -80.0,  1.0)
	tween.tween_property(%NightPathMusic, "volume_db", -80.0,  1.0)
	await tween.finished
	
	%BgMusic.stop()
	%NightPathMusic.stop()
	%SaifTheme.stop()
