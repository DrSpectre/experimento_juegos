extends "res://codigo_generico/operadores_logicos/base_operador_logico.gd"


export(NodePath) var conexion_fisica
export(bool) var trampa = false

var enlace = null
var activado: bool = false

func _ready():
	if not enlace:
		printerr("Error: Enlace no proporcionado en (" + name + ")")
		return
	
	enlace = get_node(conexion_fisica)
	
	if enlace.is_in_group("accionador"):
		enlace.connect("iniciar_proceso", self, "_logica_entrada")

	if _hijos.size() > 1:
		printerr("Demasiados nodos interconectados, usar un operador logico")
	
	elif _hijos.size() == 0:
		activado = true

func _logica_interna(entrada):
	if negado:
		estado = not estado
	
	activado = entrada\
	
	if negado:
		estado = not estado

func _logica_entrada():
	if negado:
		estado = not estado
	
	if trampa and activado:
		return
	
	if not activado:
		return
	
	estado = not estado
	
	if negado:
		estado = not estado
	
	actualizar_estado()

func _actualizar():
	pass
