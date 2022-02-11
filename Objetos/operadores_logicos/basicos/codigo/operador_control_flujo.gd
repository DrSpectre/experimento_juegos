extends "res://codigo_generico/operadores_logicos/base_operador_logico.gd"


export(NodePath) var enlace = null

func _ready():
	if not enlace:
		printerr("Error: Enlace exerior no definido en (" + name + ")")
		return
	
	var enlace_externo = get_node(enlace)

	if enlace_externo.is_in_group(tipo_base):
		enlace_externo.connect("cambio_estado", self, "_logica_interna")
	

func _logica_interna(entrada):
	if negado:
		estado = not estado
	
	estado = entrada
	
	if negado:
		estado = not estado
	
	actualizar_estado()

func _actualizar():
	pass
