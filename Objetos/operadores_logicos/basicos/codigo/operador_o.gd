extends "res://codigo_generico/operadores_logicos/base_operador_logico.gd"

func _logica_interna(entrada):
	_actualizar()

func _actualizar():
	var nuevo_estado: bool = false

	for hijo in _hijos:
		if hijo.estado:
			nuevo_estado = true
			break
	
	if not (nuevo_estado == estado):
		estado = nuevo_estado
		actualizar_estado()
