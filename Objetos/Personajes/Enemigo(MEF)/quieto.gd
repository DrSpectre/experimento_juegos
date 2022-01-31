extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"


var objetos_perdidos = null

var pila_planes = []

var instrucciones = {
	"nombre": "atacar",
	"condicion": "jugador",
	"salidas": {
		"sensor": {
			"vision_corta": {"exito": ["jugador"], "fallo": ["puerta", "obstaculo"]},
		}  
	},
	"fallo": ["plan", "buscar"],
	"exito": ["estado", "atacar"],
}


func entrar(data = false):
	if data[0] == "data":
		objetos_perdidos = [data[1], data[2]]

func actualizar(delta):
	print(delta)
