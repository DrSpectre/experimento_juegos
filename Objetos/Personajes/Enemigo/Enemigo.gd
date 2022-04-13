extends KinematicBody2D


var movimiento: Vector2 = Vector2.ZERO #El : espara hacer el tipado duro y no dinamico

const nodo2d = 17
const vector2 = 5

var objetivo = null
var objetivo_cord: Vector2 = Vector2()
var navegacion = null
var camino: Array = []

onready var filtro = [self, $sensores/pseudo_vision, $espacio_balas]

export var velocidad = 50.0
export(float) var umbral = 5.0

onready var cerebro = $maquina_estados
onready var interactuador = $brazos/izquierdo

func _ready():
	navegacion = obtener_nodo("atlas_navegacion")

	if not navegacion:
		printerr("ERROR: Atlas de navegacion no encontrado")

	set_process(false)
	set_physics_process(false)
	
func _physics_process(delta):
	navegar()

func ir_a(objetivo_a):
	if typeof(objetivo_a) == nodo2d:
		objetivo = objetivo_a
		objetivo_cord = objetivo_a.global_position

	elif typeof(objetivo_a) == vector2:
		objetivo_cord = objetivo_a

	actualizar_ruta()

	set_physics_process(true)

func detener_movimiento():
	set_physics_process(false)
	objetivo = null

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
	if objetivo_cord and navegacion:
		camino = navegacion.get_simple_path(global_position, objetivo_cord , false)

func moverse():
	move_and_slide(movimiento)

# Area designada para los tipos de itneraccion con otros elemntos
func golpear_a(objetivo):
	var direccion = null

	if typeof(objetivo) == nodo2d:
		direccion = objetivo.global_position

	elif typeof(objetivo) == vector2:
		direccion = objetivo

	look_at(direccion)

	print("<<IMPLEMENTAR ACCION DE GOLPEAR>>")

# Respuesta a señales exteriores o interiores
func _on_Area2D_body_entered(body):
	if "Bala" in body.name:
		body.queue_free()
		cerebro.activar_sensores(["cuerpo", body])

func _en_pseudo_vision_excitado(body):
	if verificar_vision(body):
		cerebro.activar_sensores(["vision", body])

func verificar_vision(objeto):
	var espacio_ctx = get_world_2d().direct_space_state

	var res = espacio_ctx.intersect_ray(global_position, objeto.global_position,
										filtro, objeto.collision_layer, true, true)

	if res and res.collider == objeto:
		return true

	return false

# https://www.youtube.com/watch?v=bX7DSpqi5qU

func actualizar_dif():
	if objetivo:
		objetivo_cord = objetivo.global_position
		actualizar_ruta()

func distancia_a(objeto = false):
	if typeof(objeto) == nodo2d:
		return global_position.distance_to(objeto.global_position)

	elif typeof(objeto) == vector2:
		return global_position.distance_to(objeto)

	elif not objeto and objetivo:
		return distancia_a(objetivo)

	elif not objeto and not objetivo and camino[-1]:
		return distancia_a(camino[-1])


# Utilidades para demas lugares o recursos necesarios
func obtener_nodos(nombre):
	var arbol = get_tree()
 
	if arbol.has_group(nombre):
		return arbol.get_nodes_in_group(nombre)

	return null

func obtener_nodo(nombre, numero_lista = 0):
	var arbol = get_tree()

	if arbol.has_group(nombre):
		return arbol.get_nodes_in_group(nombre)[numero_lista]

	return null

