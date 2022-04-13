extends Node

signal finalizado(siguiente_estado_maquina, parametros)


func entrar(memoria):
    pass

func actualizar(delta):
    pass

func salir():
    pass

func manejar_sensores(objeto):
    pass

func cambiar_estado(estado_nuevo = false):
    if estado_nuevo:
        emit_signal("finalizado", estado_nuevo)

    else:
        emit_signal("finalizado", "eliminar")

func verificar_capacidad_resolucion(objeto):
    pass

