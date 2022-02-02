extends KinematicBody2D

signal sensor_activado(objeto)
signal actualizar_camino()
signal morir(muerto)

export var velocidad = 50.0

var movimiento: Vector2 = Vector2.ZERO #El : espara hacer el tipado duro y no dinamico


#Agregar objbettos al filtro para no ver a la hora de hacer el raycast 
onready var filtro = [$fisicas_balas, $Sensores/pseudo_vision, self]
onready var sensor_area = $Sensores/pseudo_vision
onready var rayo_frontal = $Sensores/vision_corta
onready var tempo = $tempo

# Para ataques y cosas similares
onready var brazo_inf = $brazo_inf
onready var brazo_sup = $brazo_sup

func _ready():
	set_process(false)
	set_physics_process(false)
	tempo.connect("timeout", self, "sonar_sensor")

func sonar_sensor():
	for objeto in sensor_area.get_overlapping_areas() + sensor_area.get_overlapping_bodies():
		activar_sensor(objeto)
	
	var vision_corta = rayo_frontal.get_collider()
	if vision_corta:
		emit_signal("sensor_activado", ["vision_corta", rayo_frontal.get_collider()])

func tempo_ritmo():
	sonar_sensor()

func moverse(direccion, sec_velocidad = false):
	if sec_velocidad:
		move_and_slide(direccion * sec_velocidad)
	
	else:
		move_and_slide(direccion * velocidad)

func obtener_nodo(nombre, numero_lista = 0):
	var arbol = get_tree()
 
	if arbol.has_group(nombre):
		return arbol.get_nodes_in_group(nombre)[numero_lista]

	return null

func _actualizar_sensores(objeto):
	print(objeto)
	pass

# Respuesta a señales exteriores o interiores
func _on_Area2D_body_entered(body):
	if "Bala" in body.name:
		emit_signal("morir", self)
		body.queue_free()
		queue_free()


# Area para sensores de vision, agregar por cada uno
# VIsion de largo alcance
func _on_pseudo_vision_area_entered(area):
	activar_sensor(area)

func _on_pseudo_vision_body_entered(body):
	activar_sensor(body)

func activar_sensor(objeto):
	if _verificar_objeto(objeto):
		emit_signal("sensor_activado", ["vision", objeto])

func _verificar_objeto(objeto):
	var espacio_exterior = get_world_2d().direct_space_state
	
	var res = espacio_exterior.intersect_ray(global_position, objeto.global_position,
											filtro, objeto.collision_layer, true, true)
	
	if res and res.collider == objeto:
		return true
	
	return false
	
func emitir_senyal_actuaizacion():
	emit_signal("actualizar_camino")
