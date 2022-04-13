extends "res://codigo_generico/IA/MaquinaEstadosV2/estado_excepcional_base.gd"


export(float) var tiempo = 5.0

var tempo: float = 0.0
var marioneta = null

func _ready():
	marioneta = get_owner()

func entrar(memoria = false):
	print("EN ::PARALIZADO:: V2")
	marioneta.detener_movimiento()
	tempo = 0.0

func actualizar(delta):
	tempo += delta

	if tempo > tiempo:
		cambiar_estado()

func salir():
	marioneta.reanudar_movimiento()
	return null

func verificar_capacidad_resolucion(objeto):
	return objeto[1].is_in_group("bala") and objeto[0] == "cuerpo" 

