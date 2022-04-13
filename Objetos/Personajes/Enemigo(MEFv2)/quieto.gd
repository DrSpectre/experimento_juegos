extends "res://codigo_generico/IA/MaquinaEstadosV2/estado_generico.gd"
"""::QUIETO::"""


export(NodePath) var investigar_estado
export(NodePath) var patrullar_estado

var memoria = null

export(float) var tiempo = 1.5
var tempo: float = 0.0

func _ready():
	investigar_estado = get_node(investigar_estado)
	patrullar_estado = get_node(patrullar_estado)

func entrar(parametros):
	print("::QUIETO:: <" + name + ">")
	tempo = 0.0

func actualizar(delta):
	tempo += delta

	if tempo > tiempo:
		print("CAMBIANDO EN V2")
		_cambiar_estado_a(patrullar_estado)

func salir():
	return memoria

func manejar_sensores(objeto):
	if objeto.is_in_group("jugador"):
		memoria = objeto
		_cambiar_estado_a(investigar_estado)

