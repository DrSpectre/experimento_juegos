extends Node2D

signal iniciar_proceso()


export(bool) var recogible = false
export(String) var llave = ""

func _ready():
	set_process(false)
	set_physics_process(false)

func _en_interaccion_recogible(area):
	if recogible:
		emit_signal("iniciar_proceso")

func iniciar_interaccion(llaves_proveidas = [""]):
	if recogible:
		return
	
	if _verificar_llaves(llaves_proveidas):
		emit_signal("iniciar_proceso")
		return true
	
	else:
		return false

func _verificar_llaves(llaves):
	if llave in llaves:
		return true
	
	return false


