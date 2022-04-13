extends Node2D


var lista_enemigos: = []
var lista_pendientes: = []

export var tiempo_enfreamiento = 0.25
var tempo = 0.25
var actualizar = true

func _ready():
	lista_enemigos = obtener_nodos("enemigo")
	
	for onl in lista_enemigos:
		onl.connect("morir", self, "eliminar_muertos")

func _process(delta):
	if lista_pendientes.size() > 0 and actualizar:
		lista_pendientes[0].actualizar_dif()
		lista_pendientes.remove(0)
	
	if lista_pendientes.size() == 0:
		actualizar = false
		lista_pendientes = lista_enemigos.duplicate()
	
	if not actualizar:
		tempo -= delta
		if tempo < 0:
			actualizar = true
			tempo = tiempo_enfreamiento

func obtener_nodos(nombre):
	var arbol = get_tree()
 
	if arbol.has_group(nombre):
		return arbol.get_nodes_in_group(nombre)

	return []

func eliminar_muertos(muerto):
	var del = lista_enemigos.find(muerto) + 1
	if del:
		lista_enemigos.remove(del - 1)

	del = lista_pendientes.find(muerto) + 1
	if del:
		lista_pendientes.remove(del - 1)

	# lista_pendientes = lista_enemigos.duplicate()
