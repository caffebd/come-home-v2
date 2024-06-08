extends Control


@onready var text_boxes = [$Label0,$Label1,$Label2,$Label3,$Label4]

var text_index: int = 0

var freeze: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Label1.modulate.a = 0.0
	$Label2.modulate.a = 0.0
	$Label3.modulate.a = 0.0
	$Label4.modulate.a = 0.0
	$MouseAnim.play("mouse_pulse")



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use") and not freeze:
		text_index += 1
		if text_index == text_boxes.size()-1:
			pass
			#GlobalScene.start_bg_music()
		if text_index < text_boxes.size():
			freeze = true
			var box_out = text_boxes[text_index-1]
			var box_in = text_boxes[text_index]
			var tween = create_tween()
			tween.tween_property(box_out, "modulate:a", 0.0, 2.0)
			tween.tween_property(box_in, "modulate:a", 1.0, 2.0)
			await tween.finished
			freeze = false
		else:
			freeze = true
			var tween = create_tween()
			tween.tween_property($Cover, "modulate:a", 1.0, 2.0)
			await tween.finished
			get_tree().change_scene_to_file("res://luke/scenes_luke/menu.tscn")


func _on_skip_btn_pressed() -> void:
	freeze = true
	GlobalScene.start_bg_music()
	var tween = create_tween()
	tween.tween_property($Cover, "modulate:a", 1.0, 2.0)
	await tween.finished
	get_tree().change_scene_to_file("res://luke/scenes_luke/menu.tscn")
