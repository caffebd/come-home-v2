extends Node3D

var stick_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.stick_drop.connect(_stick_drop)
	GlobalSignals.father_gone.connect(_arrow_broken)

func _stick_drop():
	stick_count += 1
	for i in stick_count:
		%MadeArrow.get_child(i).visible = true
	var needed = 3 - stick_count
	if needed == 2:
		GlobalSignals.emit_signal("show_speech", "Great. Now find another two")
		GlobalSignals.emit_signal("dad_audio", "two_more")
	elif needed == 1:
		GlobalSignals.emit_signal("show_speech", "Well done. Now find one more")
		GlobalSignals.emit_signal("dad_audio", "one_more")
	else:
		GlobalSignals.emit_signal("show_speech", "Look, we can use this arrow to see which way we went.")
		GlobalSignals.emit_signal("drop_dome", false)
		GlobalSignals.emit_signal("dad_audio", "arrow_done")
		await get_tree().create_timer(6).timeout
		GlobalSignals.emit_signal("hide_speech")
		Narration.main_index = Narration.teach_index
		Narration.sub_index = 0
		Narration.narrate()
		#GlobalSignals.emit_signal("show_narration", "Dad always liked to teach me something when we went walking.")
		await get_tree().create_timer(5).timeout
		Narration.main_index = Narration.taka_index
		Narration.sub_index = 0
		Narration.narrate()
		#GlobalSignals.emit_signal("show_narration", "I suddenly realised I lost the 10 Taka note my dad gave me, I had to find it.")
		await get_tree().create_timer(10).timeout
		GlobalSignals.emit_signal("clearing_trigger_orb")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _arrow_broken():
	%MadeArrow.visible = false
	%BrokeArrow.visible = true
