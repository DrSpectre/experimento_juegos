extends "res://codigo_generico/operadores_logicos/base_operador_logico.gd"


signal iniciar_proceso()

func _ready():
	if _hijos.size() > 1:
		printerr("Salida logica conn mas de una entrada, reducir entradas")

func _logica_interna(entrada):
	if negado:
		estado = not estado
	
	estado = entrada
	
	if negado:
		estado = not estado
	
	if estado:
		emit_signal("iniciar_proceso")
	
	actualizar_estado()

func _actualizar():
	pass
