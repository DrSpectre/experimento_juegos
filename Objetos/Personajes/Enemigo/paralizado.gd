extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"
"""PARALIZADO"""


export(float) var tiempo_paralizis = 5.0

var tempo_paralizis:float = 0.0

var marioneta = null

func _ready():
	marioneta = get_owner()

func entrar(parametros):
	marioneta.set_physics_process(false)
	print("::PARALIZADO::")

func actualizar(delta):
	tempo_paralizis += delta

	if tempo_paralizis > tiempo_paralizis:
		emit_signal("finalizado", "anterior")

func salir():
	marioneta.set_physics_process(true)
	tempo_paralizis = 0.0
