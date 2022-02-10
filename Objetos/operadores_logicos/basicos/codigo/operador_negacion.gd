extends "res://codigo_generico/operadores_logicos/base_operador_logico.gd"

func _ready():
	if _hijos.size() > 1:
		printerr("Error logico, este operador no admite mas de una conexion")
	
	estado = not _hijos[0].estado

func _logica_interna(entrada):
	estado = not entrada
	
	actualizar_estado()

func _actualizar():
	actualizar_estado()
