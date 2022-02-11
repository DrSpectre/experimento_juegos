extends "res://codigo_generico/operadores_logicos/base_operador_logico.gd"

signal iniciar_proceso()

export(bool) var trampa = false

var activado: bool = false

func _ready():
	var hijos = get_children()
	
	for hijo in hijos:
		if hijo.is_in_group("accionador"):
			hijo.connect("iniciar_proceso", self, "_logica_entrada")
		
		elif hijo.is_in_group("mostrar_estatus"):
			hijo.conectar(self, "iniciar_proceso")
	
	if _hijos.size() > 1:
		printerr("Demasiados nodos interconectados, usar un operador logico")
	
	elif not _hijos:
		activado = true

func _logica_interna(entrada):
	if negado:
		estado = not estado
	
	if entrada == false:
		if estado and activado:
			estado = false
			activado = false
			actualizar_estado()
		return
	
	activado = entrada
	
	if negado:
		estado = not estado
	
	emit_signal("iniciar_proceso", estado)

func _logica_entrada():
	if negado:
		estado = not estado
	
	if trampa and activado:
		return
	
	if _hijos and not _hijos[0].estado:
		return
	
	estado = not estado
	
	if negado:
		estado = not estado
	
	actualizar_estado()

func actualizar_estado():
	.actualizar_estado()
	emit_signal("iniciar_proceso", estado)
