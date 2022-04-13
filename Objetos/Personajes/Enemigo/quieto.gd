extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"
"""QUIETO"""


var memoria = null

var tiempo: float = 1.5
var tempo: float = 0.0

func entrar(datos = false):
	print("::QUIETO::")
	tempo = 0.0

func actualizar(delta):
	tempo += delta

	if tempo > tiempo:
		emit_signal("finalizado", "patrullar")

func salir():
	return memoria

func manejar_sensores(data):
	if data[1].is_in_group("jugador"):
		memoria = data
		emit_signal("finalizado", "investigar")

	elif data[1].is_in_group("bala") and data[0] == "cuerpo":
		emit_signal("finalizado", "paralizado")

func manejar_entrada(data = false):
	pass

