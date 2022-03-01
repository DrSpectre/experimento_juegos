# Esta es la base de la funcionalidad de los operadores ogicos. Funcionnara como elementos especiales de interfaz 
# para conectarse con otros operadores logicos o sistemas de interaccion
extends Node

signal cambio_estado(estado)

const tipo_base = "operador_logico"
const tipo_esp = "Alguien_no_escribe"

var contador_interno = 0
var estado:bool = false

# Indicador para realizar una operacion en cascada una vez inicia el juego
export(bool) var cascada = false
export(bool) var negado = false

var _hijos:Array = []

func _ready():
	if negado:
		cascada = true
	
	var hijos =  get_children()
	
	for hijo in hijos:
		if hijo.is_in_group(tipo_base):
			_hijos.append(hijo)
	
	if not tipo_base in get_groups():
		add_to_group(tipo_base, true)
	
	for hijo in _hijos:
		if hijo.is_in_group("operador_logico"):
			hijo.connect("cambio_estado", self, "_logica_interna")
	
	set_physics_process(false)
	set_process(cascada)

func _process(delta):
	_actualizar()
	set_process(false)

func _logica_interna(entrada):
	pass
	
func _actualizar():
	pass

func actualizar_estado():
		emit_signal("cambio_estado", estado)
