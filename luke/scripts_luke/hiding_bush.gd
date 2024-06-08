extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.animal_trigger.connect(_bush_active)
	GlobalSignals.hiding.connect(_bush_stop)
	$BushLight.visible = false


func _bush_active():
	%LightAnim.play("light_pulse")
	$BushLight.visible = true
	#$areaSphere.visible = true
	#$SphereAnim.play("pulse")

func _bush_stop():
	%LightAnim.stop()
	$BushLight.visible = false
	#$SphereAnim.stop()
	#$areaSphere.visible = false
