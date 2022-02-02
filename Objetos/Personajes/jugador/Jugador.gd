extends KinematicBody2D

export(float) var velocidad_movimiento = 500
const velocidad_bala = 2000

var bala = preload("res://Objetos/Personajes/jugador/Bala.tscn")
onready var rayo_de_interaccion = $Verificacion_interaccion

var objetos_interactuables = null

func _ready():
	pass 

func _physics_process(delta):
	var direccion_movimiento = Vector2()
	
	direccion_movimiento.x = Input.get_action_strength("derecha") - Input.get_action_strength("izquierda")
	direccion_movimiento.y = Input.get_action_strength("abajo") - Input.get_action_strength("arriba")
		
	direccion_movimiento.normalized()
	direccion_movimiento = move_and_slide(direccion_movimiento * velocidad_movimiento)
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("disparar"):
		disparar()
	
	if Input.is_action_just_pressed("interaccion"):
		_interactuar(objetos_interactuables)

func disparar():
	look_at(get_global_mouse_position())
	
	var instancia = bala.instance()
	
	instancia.position = get_global_position()
	instancia.rotation_degrees = rotation_degrees
	
	instancia.apply_impulse(Vector2(), Vector2(velocidad_bala, 0).rotated(rotation))
	
	get_tree().get_root().call_deferred("add_child", instancia)

func asesinar():
	# get_tree().reload_current_scene()
	pass 

func _interactuar(objeto):
	if objeto and objeto.is_in_group("interactuar"):
		objeto.iniciar_interaccion()


func _on_Area2D_body_entered(body):
	print(body.get_groups())

# para cambbiar de nivel soo es necesario la linea
# get_tree().change_scene("res://scene_b.tscn") // la ubicacion de res://[ruta y nombre de la escenna].tscn


func _on_interaccion_objetos_area_entered(area):
	var estado_espacio = get_world_2d().direct_space_state
	
	# intersect_ray(from: Vector3, to: Vector3, exclude: Array = [  ], collision_mask: int = 0x7FFFFFFF, collide_with_bodies: bool = true, collide_with_areas: bool = false)
	var res = estado_espacio.intersect_ray(global_position, area.global_position, [self], area.collision_layer, true, true)
	
	if res.collider == area:
		objetos_interactuables = area.get_owner()

func _on_interaccion_objetos_area_exited(area):
	var raiz = area.get_owner()
	
	if objetos_interactuables == raiz:
		objetos_interactuables = null
