extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"


var movimiento: Vector2 = Vector2.ZERO 

var objetivo = null
var navegacion = null
var camino: = [Vector2(0, 0)]

export(float) var umbral = 2.5

var marioneta = null

var hilo = null

var data_salida = []

var instrucciones = {}

func _ready():
	navegacion = obtener_nodo("atlas_navegacion")

	marioneta = get_owner()	
	marioneta.connect("actualizar_camino", self, "actualizar_ruta")

func entrar(parametros = false):
	print(parametros)
	instrucciones = parametros
	
	objetivo = parametros["objetivo"]
	
	actualizar_ruta()

func actualizar(delta):
	navegar()

func salir():
	return data_salida

func manejar_sensores(data):
	if not data:
		return 
	
	print(data)
	var etiquetas_sensado = data[1].get_groups()
	print(instrucciones["sensor"])
	if data[0] in instrucciones["sensor"]:
		for etiqueta in instrucciones["sensor"][data[0]]["exito"]:
			if etiquetas_sensado and etiqueta in etiquetas_sensado:
				data_salida = ["data", "exito", data[1]]
				print("-*****-*->>>")
				emit_signal("finalizado", "quieto")
		
		for etiqueta in instrucciones["sensor"][data[0]]["fallo"]:
			if etiquetas_sensado and etiqueta in etiquetas_sensado:
				data_salida = ["data", "fallo", data[1]]
				print("---------->>>")
				emit_signal("finalizado", "quieto")

func almacenar(objeto):
	emit_signal("almacenar", objeto)

func navegar():
	if camino.size() > 0:	
		if marioneta.global_position.distance_to(camino[-1]) <= umbral:
			movimiento = Vector2.ZERO
			camino.pop_front()
		
		elif marioneta.global_position.distance_to(camino[0]) <= umbral:
			camino.remove(0)
		
		else:
			movimiento = marioneta.global_position.direction_to(camino[0])
			marioneta.look_at(camino[0])
	
	else:
		movimiento = Vector2.ZERO

	marioneta.moverse(movimiento)

func actualizar_ruta():
	if objetivo and camino and navegacion:
		if objetivo.global_position.distance_to(camino[-1]) > umbral:
			camino = navegacion.get_simple_path(marioneta.global_position, objetivo.global_position, false)


# posiblemente a implementar como ojeto comun dentro de Estados(la case superior)
func obtener_nodo(nombre, numero_lista = 0):
	var arbol = get_tree()
 
	if arbol.has_group(nombre):
		return arbol.get_nodes_in_group(nombre)[numero_lista]

	return null
