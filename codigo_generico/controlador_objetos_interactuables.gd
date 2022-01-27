extends Node2D

signal iniciar_proceso()


export(String) var llave = ""

func _ready():
	set_process(false)
	set_physics_process(false)

func iniciar_interaccion(llaves_proveidas = [""]):
	if _verificar_llaves(llaves_proveidas):
		emit_signal("iniciar_proceso")
		return true
	
	else:
		return false

func _verificar_llaves(llaves):
	if llave in llaves:
		return true
	
	return false
