extends "res://codigo_generico/operadores_logicos/base_operador_logico.gd"

func _logica_interna(entrada):
	_actualizar()

func _actualizar():
	var nuevo_estado = false

	for hijo in _hijos:
		if not hijo.estado:
			print(hijo.estado)
			nuevo_estado = true
			break
	
	estado = nuevo_estado
	actualizar_estado()
