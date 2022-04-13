extends "res://codigo_generico/IA/MaquinaEstadosV2/estado_generico.gd"
"""::PERSEGUIR::"""


export(NodePath) var estado_ataque
export(float) var distancia_para_ataque: float = 15.0

export(NodePath) var estado_prepersecusion
export(float) var umbral_tiempo_no_vision: float = 5.0
export(float) var umbral_distancia_maxima: float = 150.0


var memoria = null
var marioneta = null

var tempo_no_vision: float = 0.0

func _ready():
	estado_ataque = get_node(estado_ataque)
	estado_prepersecusion = get_node(estado_prepersecusion)

	marioneta = get_owner()

func entrar(entrada):
	marioneta.ir_a(entrada)
	memoria = entrada

	print("::PERSEGUIRv2::")

func actualizar(delta):
	var distancia = marioneta.distancia_a()

	if not marioneta.verificar_vision(memoria) or distancia < umbral_distancia_maxima:
		tempo_no_vision += delta

		if tempo_no_vision > umbral_tiempo_no_vision:
			_cambiar_estado_a(estado_prepersecusion)

	else:
		tempo_no_vision = 0.0

	if distancia <= distancia_para_ataque:
		_cambiar_estado_a(estado_ataque)

func salir():
	tempo_no_vision = 0.0

	marioneta.detener_movimiento()

	return memoria

