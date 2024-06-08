extends Control

enum {PATH, CLEARING, LOST, CHOICE, CAVE, HOUSE, FINAL}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_the_path_pressed() -> void:
	GlobalVars.selected_chapter = PATH
	get_tree().change_scene_to_file("res://luke/scenes_luke/village.tscn")


func _on_clearing_pressed() -> void:
	GlobalVars.selected_chapter = CLEARING
	get_tree().change_scene_to_file("res://luke/scenes_luke/village.tscn")


func _on_lost_pressed() -> void:
	GlobalVars.selected_chapter = LOST
	get_tree().change_scene_to_file("res://luke/scenes_luke/village.tscn")


func _on_choice_pressed() -> void:
	GlobalVars.selected_chapter = CHOICE
	get_tree().change_scene_to_file("res://luke/scenes_luke/village.tscn")


func _on_cave_pressed() -> void:
	GlobalVars.selected_chapter = CAVE
	get_tree().change_scene_to_file("res://luke/scenes_luke/village.tscn")



func _on_house_pressed() -> void:
	GlobalVars.selected_chapter = HOUSE
	get_tree().change_scene_to_file("res://luke/scenes_luke/village.tscn")


func _on_final_pressed() -> void:
	GlobalVars.selected_chapter = FINAL
	get_tree().change_scene_to_file("res://luke/scenes_luke/village.tscn")


func _on_menu_pressed() -> void:
	GlobalVars.selected_chapter = PATH
	get_tree().change_scene_to_file("res://luke/scenes_luke/menu.tscn")
