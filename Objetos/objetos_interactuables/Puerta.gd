extends RigidBody2D

enum tipos_puerta {
	tipo_rotativa,
	tipo_traslacion
}

onready var sistema_control = $controlador
export(float) var velocidad = -1.5

export(bool) var abierta = false
export(tipos_puerta) var tipo_de_puerta = tipos_puerta.tipo_traslacion
export(float) var tope = 30.0

export(Array, NodePath) var controladores_exteriores

var mem_data = null

func _ready():
	if tipo_de_puerta == tipos_puerta.tipo_rotativa:
		mem_data = rotation_degrees
	
	elif tipo_de_puerta == tipos_puerta.tipo_traslacion:
		mem_data = position
	
	if abierta:
		if tipo_de_puerta == tipos_puerta.tipo_rotativa:
			rotation_degrees = rotation_degrees + tope
	
		elif tipo_de_puerta == tipos_puerta.tipo_traslacion:
			position.x = position.x + tope

	set_physics_process(false)
	
	sistema_control.connect("iniciar_proceso", self, "interaccion")
	
	# Universal Node Locator
	for unl in controladores_exteriores:
		get_node(unl).connect("iniciar_proceso", self, "interaccion")

func _physics_process(delta):
	if abierta and tipo_de_puerta == tipos_puerta.tipo_rotativa:
		# if rotation_degrees >= mem_data + tope:
		if abs(rotation_degrees - mem_data) >= tope:
			abierta = true
			set_physics_process(false)
			
		else:
			rotation_degrees = rotation_degrees + velocidad
			
	elif abierta and tipo_de_puerta == tipos_puerta.tipo_traslacion:
		if abs(position.x - mem_data.x) >= tope:
			abierta = true
			set_physics_process(false)
			
		else:
			position.x = position.x + velocidad

	elif not abierta and tipo_de_puerta == tipos_puerta.tipo_rotativa:
		if abs(rotation_degrees - mem_data) <= 0:
			abierta = false
			set_physics_process(false)
		
		else:
			rotation_degrees = rotation_degrees - velocidad
		
	elif not abierta and tipo_de_puerta == tipos_puerta.tipo_traslacion:
		if abs(position.x - mem_data.x) <= 0:
			abierta = false
			set_physics_process(false)
		
		else:
			position.x = position.x - velocidad

"""
	else:
		if rotation_degrees <= 0:
			abierta = false
			set_physics_process(false)

		else:
			rotation_degrees = rotation_degrees - velocidad
"""
func interaccion():
	set_physics_process(true)
	abierta = not abierta
