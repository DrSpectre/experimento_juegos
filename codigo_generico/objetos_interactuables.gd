extends Node

signal iniciar_proceso()


export(String) var llave_interna = ""

func _ready():
	add_to_group("accionador")
	set_physics_process(false)
	set_process(false)

func interactuar(control_externo = false, llave = ""):
	print("inicio de proceso")
	if llave_interna and llave_interna == llave:
		emit_signal("iniciar_proceso")
		return
	
	emit_signal("iniciar_proceso")
