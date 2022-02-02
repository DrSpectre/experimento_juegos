extends RigidBody2D


func _ready():
	$temporizador.connect("timeout", self, "_on_Timer_timeout")
	
	set_process(false)
	set_physics_process(false)

func _on_Timer_timeout():
	queue_free()
