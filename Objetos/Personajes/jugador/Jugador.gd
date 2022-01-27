extends KinematicBody2D

export(float) var velocidad_movimiento = 500
const velocidad_bala = 2000

var bala = preload("res://Objetos/Personajes/jugador/Bala.tscn")

var objbetos_interactuables = null

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
		_interactuar(objbetos_interactuables)

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
	if objeto.is_in_group("interactuar"):
		objeto.iniciar_interaccion()
	# if objeto and objeto.is_in_group("interactuable"):
	# 	objeto.interaccion()

func _on_Area2D_body_entered(body):
	if "Enemigo" in body.name:
		asesinar()


# para cambbiar de nivel soo es necesario la linea
# get_tree().change_scene("res://scene_b.tscn") // la ubicacion de res://[ruta y nombre de la escenna].tscn


func _on_interaccion_objetos_area_entered(area):
	objbetos_interactuables = area.get_owner()
