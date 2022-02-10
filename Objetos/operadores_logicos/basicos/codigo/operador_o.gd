extends "res://codigo_generico/operadores_logicos/base_operador_logico.gd"

func _logica_interna(entrada):
	_actualizar()

func _actualizar():
	if negado:
		estado = not estado
	
	var nuevo_estado: bool = false

	for hijo in _hijos:
		if hijo.estado:
			nuevo_estado = true
			break
	
	if nuevo_estado != estado:
		estado = nuevo_estado
		
		if negado:
			estado = not estado
		
		actualizar_estado()
