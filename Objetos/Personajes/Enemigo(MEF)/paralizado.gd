extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"


export(float) var tiempo_paralisis = 15.0

var _tiempo_restante = 0 

func entrar(data = false):
	_tiempo_restante = tiempo_paralisis

func actuaizar(delta):
	_tiempo_restante -= delta
	
	if _tiempo_restante < 0.0:
		emit_signal("finalizado", "anterior")
