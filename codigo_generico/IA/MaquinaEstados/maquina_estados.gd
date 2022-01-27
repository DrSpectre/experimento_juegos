extends Node


signal estado_cambiado(estado_actual)


export(NodePath) var estado_inicio
var mapa_estados = {}

var pila_estados = []
var estado_actual = null
var _activo = false setget activar

var objetos_almacenados = null

func _ready():
	if not estado_inicio:
		estado_inicio = get_child(0).get_path()

	for sub_nodo in get_children():
		conectar(sub_nodo, "finalizado", "_cambiar_estado")
		conectar(sub_nodo, "almacenar", "_almacenar_objeto")

	inicializar(estado_inicio)

func inicializar(estado):
	activar(true)
	pila_estados.push_front(get_node(estado))
	estado_actual = pila_estados[0]
	
	if objetos_almacenados:
		estado_actual.entrar(objetos_almacenados)
	else:
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

func sensores_activados(objeto):
	estado_actual.manejar_sensores(objeto)

func _physics_process(delta):
	estado_actual.actualizar(delta)
	
	if objetos_almacenados:
		estado_actual.manejar_sensores(objetos_almacenados)

func _cambiar_estado(estado):
	if not _activo:
		return

	estado_actual.salir()

	if estado == "anterior":
		pila_estados.pop_front()
	else:
		pila_estados[0] = mapa_estados[estado]

	estado_actual = pila_estados[0]
	emit_signal("estado_cambiado", estado_actual)

	if estado != "anterior":
		if objetos_almacenados:
			estado_actual.entrar(objetos_almacenados)
		else:
			estado_actual.entrar()

func _almacenar_objeto(data):
	objetos_almacenados = data

func conectar(nodo, senyal, funcion_delegada):
	var err = nodo.connect(senyal, self, funcion_delegada)

	if err:
		printerr("Error en maquina_estados.gd. Error: " + err)
