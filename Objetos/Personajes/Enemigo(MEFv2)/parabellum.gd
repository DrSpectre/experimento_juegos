extends Node
"""Aqui se construira la logica del parabellum en su primera version"""
"""Aqui inicia la magia maguidfa"""


const nodo = 17
const vector2 = 5
const texto = 4

onready var gestor_estados = $maquina_estados

var estados_excepcionales: = []

var estado_excepcional = null

func _ready():
	var hijos = get_children()
	
	for hijo in hijos:
		if hijo.is_in_group("estado_excepcional"):
			estados_excepcionales.append(hijo)
			conectar(hijo, "finalizado", "_cambiar_estado")

func activar_sensores(objeto):
	for estado in estados_excepcionales:
		if estado.verificar_capacidad_resolucion(objeto):
			estado_excepcional = estado
			estado_excepcional.entrar(objeto)
			break

	gestor_estados.sensores_activados(objeto)

func _physics_process(delta):
	if estado_excepcional:
		estado_excepcional.actualizar(delta)

	else:
		gestor_estados.actualizar(delta)

func _cambiar_estado(estado):
	if typeof(estado) == texto and estado == "eliminar":
		estado_excepcional.salir()
		estado_excepcional = null

	elif typeof(estado) == nodo:
		estado_excepcional.salir()
		estado_excepcional = estado
		estado_excepcional.entrar()

func conectar(nodo, senyal, funcion_delegada):
	var err = nodo.connect(senyal, self, funcion_delegada)

	if err:
		printerr("Error en <" + self.name +  "> Error: " + str(err))

