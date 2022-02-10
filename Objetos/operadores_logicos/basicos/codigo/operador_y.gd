extends "res://codigo_generico/operadores_logicos/base_operador_logico.gd"

func _logica_interna(entrada):
	_actualizar()

func _actualizar():
	if negado:
		estado = not estado

	var nuevo_estado = true

	for hijo in _hijos:
		if not hijo.estado:
			nuevo_estado = false
			break
	
	if nuevo_estado != estado:
		estado = nuevo_estado

		if negado:
			estado = not estado

		actualizar_estado()
