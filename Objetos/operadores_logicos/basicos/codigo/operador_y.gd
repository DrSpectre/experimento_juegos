extends "res://codigo_generico/operadores_logicos/base_operador_logico.gd"

func _logica_interna(entrada):
	_actualizar()

func _actualizar():
	var nuevo_estado = true

	for hijo in _hijos:
		if not hijo.estado:
			nuevo_estado = false
			break
	
	if nuevo_estado != estado:
		estado = nuevo_estado
		actualizar_estado()
