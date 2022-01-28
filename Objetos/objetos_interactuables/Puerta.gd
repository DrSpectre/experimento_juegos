extends RigidBody2D


onready var sistema_control = $controlador
export(float) var velocidad = 1.5

export(bool) var abierta = false
export(Array, NodePath) var controladores_exteriores


func _ready():
	if not abierta:
		rotation_degrees = 0
	
	else:
		rotation_degrees = 90

	set_physics_process(false)
	
	sistema_control.connect("iniciar_proceso", self, "interaccion")
	
	# Universal Node Locator
	for unl in controladores_exteriores:
		get_node(unl).connect("iniciar_proceso", self, "interaccion")

func _physics_process(delta):
	if abierta:
		if rotation_degrees >= 90:
			abierta = true
			set_physics_process(false)

		else:
			rotation_degrees = rotation_degrees + velocidad

	else:
		if rotation_degrees <= 0:
			abierta = false
			set_physics_process(false)

		else:
			rotation_degrees = rotation_degrees - velocidad

func interaccion():
	set_physics_process(true)
	abierta = not abierta
