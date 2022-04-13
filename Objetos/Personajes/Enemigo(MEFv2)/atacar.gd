extends "res://codigo_generico/IA/MaquinaEstadosV2/estado_generico.gd"
"""::ATACAR::"""


export(NodePath) var estado_preataque
export(float) var umbral_maxima_distancia_ataque = 15.0

export(float) var cadencia = 1.0

var memoria = null
var marioneta = null

var tempo_ataque: float = 0.0
var cadencia_ataque: float = 0.0

func _ready():
	estado_preataque = get_node(estado_preataque)

	marioneta = get_owner()

	cadencia_ataque = 1 / cadencia
	tempo_ataque = cadencia_ataque

func entrar(data):
	memoria = data
	print("::ATACARv2::")

func actualizar(delta):
	var distancia = marioneta.distancia_a(memoria)

	if tempo_ataque < 0.0 and distancia < umbral_maxima_distancia_ataque:
		marioneta.atacar_a(memoria)
		tempo_ataque = cadencia_ataque

	else:
		tempo_ataque -= delta

		if distancia > umbral_maxima_distancia_ataque:
			_cambiar_estado_a(estado_preataque)

func salir():
	tempo_ataque = cadencia_ataque
	return memoria

