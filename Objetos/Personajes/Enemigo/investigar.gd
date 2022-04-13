extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"
"""INVESTGIAR"""


export(float) var umbral_distancia_maxima = 450.0
export(float) var umbral_vision = 1.5
export(float) var tiempo_investigacion = 5.0

var memoria = null
var tempo_vision: float = 0.0
var tempo_investigacion: float = 0.0
var se_ha_visto: bool = false
var ultima_posicion: Vector2 = Vector2.ZERO

var marioneta = null

func _ready():
	marioneta = get_owner()

func entrar(parametros):
	if parametros:
		memoria = parametros

	marioneta.ir_a(memoria)

	tempo_investigacion = tiempo_investigacion

	print("::INVESTIGAR::")

func actualizar(delta):
	var distancia = marioneta.global_position.distance_to(memoria.global_position)

	if marioneta.verificar_vision(memoria) and distancia < umbral_distancia_maxima:
		tempo_vision += delta

	else:
		tempo_investigacion -= delta

	if tempo_vision > umbral_vision:
		print("CAMBIANDO A perseguir")
		emit_signal("finalizado", "perseguir")
	
	if tempo_investigacion < 0:
		emit_signal("finalizado", "quieto")


func salir():
	marioneta.detener_movimiento()

	tempo_vision = 0.0
	tempo_investigacion = 0.0
	
	return memoria

func manejar_sensores(data):
	if data[1].is_in_group("bala") and data[0] == "cuerpo":
		emit_signal("finalizado", "paralizado")
