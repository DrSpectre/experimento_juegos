extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"
"""CONTROL EXTERIOR"""
"""
		Estado diseñado para ser controlado por otro elmento inteligente
"""


var marioneta = null

func _ready():
	marioneta = get_owner()

func entrar(parametros):
	marioneta.set_physics_process(false)
	print("::CONTROL-EXTERIOR::")

func actualizar(delta):
	pass

func salir():
	marioneta.set_physics_process(true)

