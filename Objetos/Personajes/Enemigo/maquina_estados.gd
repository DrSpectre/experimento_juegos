extends "res://codigo_generico/IA/MaquinaEstados/maquina_estados.gd"
"""MAQUINA DE ESTADOS"""


const estados_jerarquicos: = ["paralizado"]

onready var quieto = $quieto
onready var investigar = $investigar
onready var perseguir = $perseguir
onready var atacar = $atacar
onready var patrullar = $patrullar
onready var paralizado = $paralizado
onready var control_exterior = $control_exterior

var marioneta = null

func _ready():
	marioneta = get_owner()

	estado_inicio = quieto

	mapa_estados = {
		"quieto": quieto,
		"investigar": investigar,
		"perseguir": perseguir,
		"atacar": atacar,
		"patrullar": patrullar,
		"paralizado": paralizado,
		"control_exterior": control_exterior
	}

func _cambiar_estado(estado_nuevo):
	if estado_nuevo in estados_jerarquicos:
		pila_estados.push_front(mapa_estados[estado_nuevo])

	._cambiar_estado(estado_nuevo)

func activar_sensores(data):
	estado_actual.manejar_sensores(data)
