extends "res://codigo_generico/IA/MaquinaEstadosV2/estado_generico.gd"
"""::INVESTIGAR::"""


export(NodePath) var estado_objetivo_encontrado
export(String) var objetivo = "jugador"
export(Array, NodePath) var estados_objetivo_no_encontrado

export(float) var umbral_distancia_maxima = 450.0
export(float) var umbral_vision = 1.50
export(float) var tiempo_investigacion = 5.0

var memoria = null
var tempo_vision: = 0.0
var tempo_investigacion: = 0.0
var se_ha_visto: = false
var ultima_posicion: Vector2 = Vector2.ZERO

var marioneta = null

var gna = RandomNumberGenerator.new()

func _ready():
	gna.randomize()
	marioneta.get_owner()
	
	estado_objetivo_encontrado = get_node(estado_objetivo_encontrado)

	var estados_cache: Array = []

	for nodo in estados_objetivo_no_encontrado:
		estados_cache.append(get_node(nodo))

	estados_objetivo_no_encontrado = estados_cache

func entrar(parametros):
	if parametros:
		memoria = parametros

	marioneta.ir_a(memoria)

	tempo_investigacion = tiempo_investigacion

	print("::INVESTIGARv2::")

func actualizar(delta):
	var distancia = marioneta.distancia_a()

	if marioneta.verificar_vision(memoria) and distancia < umbral_distancia_maxima:
		tempo_vision += delta

	else:
		tempo_investigacion -= delta

	if tempo_vision > umbral_vision:
		print("CAMBIANDO A PERSEGUIR")
		_cambiar_estado_a(estado_objetivo_encontrado)

	if tempo_investigacion < 0:
		cambiar_a_estado_fallido()


func salir():
	marioneta.detener_movimiento()

	tempo_vision = 0.0
	tempo_investigacion = 0.0

	return null

func cambiar_a_estado_fallido():
	_cambiar_estado_a(estados_objetivo_no_encontrado[gna.randi_range(0, len(estados_objetivo_no_encontrado) -1)])

