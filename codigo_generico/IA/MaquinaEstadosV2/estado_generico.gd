extends Node

# Linea base de interfaz para maquinas de estado

signal finalizado(siguiente_estado_maquina, parametros)

func entrar(parametros):
	pass

func actualizar(delta):
	pass

func salir():
	pass

func manejar_sensores(objeto):
	pass

func almacenar(objeto):
	emit_signal("almacenar", objeto)

func _cambiar_estado_a(estado_nuevo):
    if estado_nuevo:
        emit_signal("finalizado", estado_nuevo)

