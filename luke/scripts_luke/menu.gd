extends Control

enum {PATH, CLEARING, LOST, CHOICE, CAVE, HOUSE, FINAL}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalScene.stop_all_music()
	GlobalVars.selected_chapter = PATH



func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://luke/scenes_luke/narrative/intro.tscn")


func _on_chapters_button_pressed() -> void:
	get_tree().change_scene_to_file("res://luke/scenes_luke/ChaptersMenu.tscn")


func _on_exit_btn_pressed() -> void:
	get_tree().quit()
