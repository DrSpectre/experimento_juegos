extends Node2D

signal sensor_excitado(objeto)


onready var rayos = get_children() 
onready var pariente = get_owner()

var checar_objetivo = null

func _ready():
	checar_objetivo = get_tree().get_nodes_in_group("jugador")[0]

func _physics_process(delta):
	look_at(checar_objetivo.global_position)
	
	for rayo in rayos:
		if rayo.is_colliding():
			emit_signal("sensor_excitado", rayo.get_collider())
