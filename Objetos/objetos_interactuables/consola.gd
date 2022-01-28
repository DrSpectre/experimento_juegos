extends Node2D


export(Array, NodePath) var controladores_externos

export(Color) var color_activado = Color.green
export(Color) var color_inactivado = Color.red

export(bool) var activado = false

onready var luz = $luz_led

func _ready():
	actualizar_luz()
	for unl in controladores_externos:
		get_node(unl).connect("iniciar_proceso", self, "_activar_consola")
	
	set_physics_process(false)
	set_process(false)

func _activar_consola():
	activado = !activado
	actualizar_luz()

func actualizar_luz():
	if activado:
		luz.color = color_activado
	
	else:
		luz.color = color_inactivado
	
	luz.update()
	luz.energy = 0.5
