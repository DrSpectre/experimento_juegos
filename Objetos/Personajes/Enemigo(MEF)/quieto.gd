extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"


var objetos_perdidos = null

var pila_planes = []

var actualizacion_de_planes = false
var evaluar_situacion = false

var instrucciones = {
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
}

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

func entrar(data = false):
	if not data:
		return
	
	if data[0] == "data":
		objetos_perdidos = [data[1], data[2]]

func actualizar(delta):
	if not objetos_perdidos:
		return
	
	if actualizacion_de_planes:
		actualizacion_de_planes = false
		emit_signal("finalizado", instrucciones["estado"])
		return
	
	var resolucion = instrucciones[objetos_perdidos[0]]
	
	if resolucion[0] == "estado":
		emit_signal("finalizado", resolucion[1])

func salir():
	return instrucciones["salidas"]

func manejar_sensores(data):
	if "jugador" in data[1].get_groups():
		objetos_perdidos = data
		instrucciones["salidas"]["objetivo"] = data[1]
		
		actualizacion_de_planes = true
