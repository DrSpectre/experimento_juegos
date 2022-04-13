extends "res://codigo_generico/IA/MaquinaEstadosV2/estado_generico.gd"
"""::PATRULLAR::"""


# Generador de numeros aleatorios
var gna = RandomNumberGenerator.new()


export(NodePath) var estado_jugador_encotnrado
export(NodePath) var estado_patrullaje_finalizado

export(float) var umbral = 15.0

var marioneta = null
var puntos_interes: = []

var objetivo_actual = null
var memoria = null

func _ready():
	estado_patrullaje_finalizado = get_node(estado_patrullaje_finalizado)
	estado_jugador_encotnrado = get_node(estado_jugador_encotnrado)

	gna.randomize()

	marioneta = get_owner()

	puntos_interes = marioneta.obtener_nodos("puntos_de_patrulla")

func entrar(parametros = false):
	print("::PATRULLAR::")
	establecer_punto_patrullaje()

	memoria = parametros

func actualizar(delta):
	if marioneta.distancia_a() < umbral:
		establecer_punto_patrullaje()


func salir():
	marioneta.detener_movimiento()
	return memoria

func manejar_sensores(data):
	if data.is_in_group("jugador"):
		_cambiar_estado_a(estado_jugador_encotnrado)

func establecer_punto_patrullaje():
	if gna.randi_range(0, 2) == 1:
		_cambiar_estado_a(estado_patrullaje_finalizado)
		return null

	var nuevo_objetivo = obtener_punto_patrullaje()

	if nuevo_objetivo != objetivo_actual:
		objetivo_actual = nuevo_objetivo

	else:
		objetivo_actual = obtener_punto_patrullaje()

	marioneta.ir_a(objetivo_actual.global_position)

func obtener_punto_patrullaje():
	return puntos_interes[gna.randi_range(0, len(puntos_interes) - 1)]

