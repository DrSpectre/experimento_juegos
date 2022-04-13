extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"
"""ATACAR"""


export(float) var cadencia = 1
export(float) var umbral_maxima_distancia_golpe = 45.0

var memoria = null

var marioneta = null
var brazos = null

var golpe_dado: bool = false
var tempo_golpe: float = 0.0
var cadencia_golpes: float = 0.0

func _ready():
	marioneta = get_owner()
	cadencia_golpes = 1 / cadencia

func entrar(parametros):
	memoria = parametros
	print("::ATACAR::")

func actualizar(delta):
	var distancia = marioneta.distancia_a(memoria)

	if not golpe_dado:
		if distancia < umbral_maxima_distancia_golpe:
			marioneta.golpear_a(memoria)
			golpe_dado = true
	else:
		tempo_golpe += delta

		if tempo_golpe > cadencia_golpes:
			tempo_golpe = 0.0
			golpe_dado = false

		if distancia > umbral_maxima_distancia_golpe:
			emit_signal("finalizado", "perseguir")

func salir():
	golpe_dado = false
	tempo_golpe = 0.0
	return memoria

func manejar_sensores(data):
	if data[1].is_in_group("bala") and data[0] == "cuerpo":
		emit_signal("finalizado", "paralizado")

