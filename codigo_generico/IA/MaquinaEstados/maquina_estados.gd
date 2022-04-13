extends Node

signal estado_cambiado(estado_actual)


export(NodePath) var estado_inicio
var mapa_estados = {}

var pila_estados = []
var estado_actual = null
var _activo = false setget activar

func _ready():
	if not estado_inicio:
		estado_inicio = get_child(0).get_path()

	for sub_nodo in get_children():
		conectar(sub_nodo, "finalizado", "_cambiar_estado")

	inicializar(estado_inicio)

func inicializar(estado):
	activar(true)
	pila_estados.push_front(get_node(estado))
	estado_actual = pila_estados[0]
	
	estado_actual.entrar()

func activar(valor):
	_activo = valor

	set_physics_process(valor)
	set_process_input(valor)

	if not _activo:
		pila_estados = []
		estado_actual = null

func _unhandled_input(event):
	estado_actual.manejar_entrada(event)

func sensores_activados(data):
	estado_actual.manejar_sensores(data)

func _physics_process(delta):
	estado_actual.actualizar(delta)
	
func _cambiar_estado(estado):
	if not _activo:
		return

	var memoria = null

	if not pila_estados.size() > 1:
		memoria = estado_actual.salir()

	if estado == "anterior":
		estado_actual.salir()
		pila_estados.pop_front()

	else:
		pila_estados[0] = mapa_estados[estado]

	estado_actual = pila_estados[0]
	emit_signal("estado_cambiado", estado_actual)

	if estado != "anterior":
		estado_actual.entrar(memoria)
	
func conectar(nodo, senyal, funcion_delegada):
	var err = nodo.connect(senyal, self, funcion_delegada)

	if err:
		printerr("Error en maquina_estados.gd. Error: " + str(err))

