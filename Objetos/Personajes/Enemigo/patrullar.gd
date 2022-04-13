extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"
"""PATRULLAR"""


export(float) var umbral = 15.0

onready var marioneta = null
onready var puntos_interes: = []

var objetivo_actual = null
var gna = RandomNumberGenerator.new()

var memoria = null

func _ready():
	gna.randomize()

	marioneta = get_owner()

	puntos_interes = marioneta.obtener_nodos("puntos_de_patrulla")

func entrar(parametros):
	actualizar_camino()

	print("::PATRULLAR::")

func actualizar(delta):
	var distancia = marioneta.distancia_a()

	if distancia < umbral:
		actualizar_camino()

func actualizar_camino():
	var accion = gna.randi_range(0, 2)
	
	if accion == 1:
		emit_signal("finalizado", "quieto")
		return null

	var nuevo_objetivo = puntos_interes[gna.randi_range(0, len(puntos_interes) - 1)]

	if nuevo_objetivo != objetivo_actual: 
		objetivo_actual = nuevo_objetivo

	else:
		objetivo_actual = puntos_interes[gna.randi_range(0, len(puntos_interes) - 1)]

	marioneta.ir_a(objetivo_actual.global_position)

func salir():
	marioneta.detener_movimiento()
	return memoria

func manejar_sensores(data):
	if data[1].is_in_group("jugador"):
		memoria = data
		emit_signal("finalizado", "investigar")

	elif data[1].is_in_group("bala") and data[0] == "cuerpo":
		emit_signal("finalizado", "paralizado")
