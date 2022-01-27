extends KinematicBody2D

var movimiento: Vector2 = Vector2.ZERO #El : espara hacer el tipado duro y no dinamico

var objetivo = null
var navegacion = null

var persecusion = false 

var camino: Array = []
export var velocidad = 50.0
export(float) var umbral = 5.0

var temporizador = 0.0
export(float) var tiempo_persecusion = 5.0

onready var sensores = $sensores
onready var tempo = $temporizador

func _ready():
	# objetivo = obtener_nodo("jugador")
	navegacion = obtener_nodo("atlas_navegacion")
	
	sensores.connect("sensor_excitado", self, "_actualizar_sensores")
	
	tempo.connect("timeout", self, "actualizar_ruta")
	
	if objetivo:
		if not camino:
			actualizar_ruta()

func _physics_process(delta):
	if objetivo and objetivo.global_position.distance_to(global_position) < umbral:
		actualizar_ruta()
	
	navegar()
	
	if not objetivo and persecusion:
		temporizador = temporizador - delta
	
	if temporizador <= 0.0:
		persecusion = false

func navegar():
	if camino.size() > 0:
		movimiento = global_position.direction_to(camino[0]) * velocidad
		look_at(camino[0])
	
		if global_position == camino[-1]:
			movimiento = Vector2.ZERO
			camino.pop_front()
		
		if global_position.distance_to(camino[0]) <= umbral:
			camino.remove(0)
	
	else:
		movimiento = Vector2.ZERO
	
	moverse()

func actualizar_ruta():
	if objetivo and navegacion:
		camino = navegacion.get_simple_path(global_position, objetivo.global_position, false)
		
		temporizador = tiempo_persecusion
		persecusion = true

func moverse():
	move_and_slide(movimiento)

func obtener_nodo(nombre, numero_lista = 0):
	var arbol = get_tree()

	if arbol.has_group(nombre):
		return arbol.get_nodes_in_group(nombre)[numero_lista]

	return null

func _actualizar_sensores(objeto):
	if objeto.is_in_group("jugador"):
		objetivo = objeto
	
	else:
		objetivo = null

# Respuesta a señales exteriores o interiores
func _on_Area2D_body_entered(body):
	if "Bala" in body.name:
		body.queue_free()
		queue_free()


# https://www.youtube.com/watch?v=bX7DSpqi5qU
