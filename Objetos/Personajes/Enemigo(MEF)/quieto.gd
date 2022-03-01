extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"


var objetos_perdidos = null

var pila_planes:Array = []

var actualizacion_de_planes = false
var evaluar_situacion = false

var instrucciones = [
	{
	"nombre": "atacar",
	"estado": "ir_a",
	"condicion": "jugador",
	"salidas": {
		"sensor": {
			"vision_corta": {"exito": ["jugador"], "fallo": ["obstaculo"]},
			"vision": {"exito": [], "fallo": []},
			},
		"objetivo": null,
		"tipo": "movil",
		},
	"exito": ["estado", "atacar"],
	},
	
	{
	"nombre": "interactuar_con",
	"estado": "ir_a",
	"condicion": "interactuable",
	"salidas": {
		"sensor": {
			"vision_corta": {"exito": ["interactable"], "fallo": ["jugador", "obstaculo"]},
			"vision": {"exito": [], "fallo": []},
			},
		"objetivo": null,
		"tipo": "estatico",
		},
	"exito": ["estado", "interactuar"],
	}
]


func entrar(data = false):
	if not data:
		return
	
	if data[0] == "data":
		objetos_perdidos = [data[1], data[2]]

func actualizar(delta):
	if not objetos_perdidos:
		return
	
	if actualizacion_de_planes:
		var instruccion = actualizar_planes()
		if not instruccion:
			return
			
		actualizacion_de_planes = false
		pila_planes.push_front(instruccion)
		emit_signal("finalizado", instruccion["estado"])
		return
	
	var resolucion = actualizar_planes()
	
	if not resolucion:
		return
	
	print(resolucion)
	
	if resolucion["estado"]:
		emit_signal("finalizado", resolucion["estado"])

func salir():
	print(pila_planes)
	return pila_planes[0]["salidas"]

func manejar_sensores(data):
	objetos_perdidos = data
	actualizacion_de_planes = true
	return
	
	if "jugador" in data[1].get_groups():
		objetos_perdidos = data
		# instrucciones["salidas"]["objetivo"] = data[1]
		
		actualizacion_de_planes = true

func actualizar_planes():
	if not objetos_perdidos:
		return null
	
	var res = objetos_perdidos[1].get_groups()
	
	for instruccion in instrucciones:
		if instruccion["condicion"]  in res:
			var resolucion = instruccion.duplicate()
			resolucion["objetivo"] = res[1]
			return resolucion
	


var plan_base = {
	# Este se puede obviar para estabecer otro metodo de busqueda de este tipo de planes
	"nombre": "atacar",
	"condicion": "jugador",
	"salidas": {
		"sensor": {
			"vision_corta": {"exito": ["jugador"], "fallo": ["obstaculo"]},
			"vision": {"exito": ["jugador"], "fallo": ["obstaculo"]},
		},
		"objetivo": null,
		"tipo": "estatico",
	},
	"exito": ["estado", "atacar"],
}
