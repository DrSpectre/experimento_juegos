extends Node

# Linea base de interfaz para maquinas de estado

signal finalizado(siguiente_estado_maquina, lo_hizo, parametros)
signal almacenar(objeto)

func entrar(parametros = false):
	pass

func actualizar(delta):
	pass

func salir():
	pass

func manejar_sensores(objeto):
	pass

func almacenar(objeto):
	emit_signal("almacenar", objeto)
	
func manejar_entrada(_event):
	pass
