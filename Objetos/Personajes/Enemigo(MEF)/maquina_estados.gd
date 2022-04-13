extends "res://codigo_generico/IA/MaquinaEstados/maquina_estados.gd"


onready var quieto = $quieto
onready var buscar = $buscar
onready var ir_a = $ir_a
onready var interactuar = $interactuar
onready var atacar = $atacar
onready var paralizado = $paralizado

onready var marioneta = null

func _ready():
	marioneta = get_owner()
	marioneta.connect("sensor_activado", self, "_actualizar_sensores")
	
	estado_inicio = quieto
	
	mapa_estados = {
		"quieto": quieto,
		# "buscar": buscar,
		"ir_a": ir_a,
		"interactuar": interactuar,
		"atacar": atacar,
		"paralizado": paralizado,
	}


func _cambiar_estado(estado_nuevo):
	if not _activo:
		return
	
	# Este es para poder crear jerarquias de estados o usar estados de un solo momento
	if estado_nuevo in ["paralizado"]: # PAralizado es un metodo superior para evitar el personaje continue moviendose
		pila_estados.push_front(mapa_estados[estado_nuevo])
	
	._cambiar_estado(estado_nuevo)

func _actualizar_sensores(entrada):
	sensores_activados(entrada)

