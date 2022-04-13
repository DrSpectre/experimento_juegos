extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"
"""PERSEGUIR"""


export(float) var umbral = 20.0
export(float) var umbral_no_vision = 20.0
export(float) var umbral_max_distancia = 500.0

var memoria = null

var marioneta = null

var tempo_no_vision: float = 0.0

func entrar(parametros):
	marioneta = get_owner()

	marioneta.ir_a(parametros)
	memoria = parametros

	print("::PERSEGUIR::")

func actualizar(delta):
	var distancia = marioneta.distancia_a()

	if not marioneta.verificar_vision(memoria) or distancia > umbral_max_distancia:
		tempo_no_vision += delta

		if tempo_no_vision > umbral_no_vision:
			emit_signal("finalizado", "investigar")

	else:
		tempo_no_vision = 0.0

	if distancia <= umbral:
		emit_signal("finalizado", "atacar")


func salir():
	tempo_no_vision = 0.0

	marioneta.detener_movimiento()

	return memoria

func manejar_sensores(data):
	if data[1].is_in_group("bala") and data[0] == "cuerpo":
		emit_signal("finalizado", "paralizado")

