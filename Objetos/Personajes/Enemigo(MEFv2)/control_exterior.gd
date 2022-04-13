extends "res://codigo_generico/IA/MaquinaEstadosV2/estado_excepcional_base.gd"


export(float) var umbral: float = 15.0
var marioneta = null

var cerebrum_exterior = null

var memoria_objetivo = null
var memoria_cord_objetivo = null

var coord_captura: Vector2 = Vector2()

func _ready():
	marioneta = get_owner()

func entrar(parametros = false):
    if parametros:
        cerebrum_exterior = parametros[1]
        cerebrum_exterior.activar()

    memoria_objetivo = marioneta.objetivo_actual
    memoria_cord_objetivo = marioneta.objetivo_cord

    coord_captura = marioneta.global_position

    marioneta.detener_movimiento(limpiar = true)

func actualizar(delta):
    if cerebrum_exterior.esta_activo():
        cerebrum_exterior.actualizar()

    else:
        marioneta.ir_a(coord_captura)

        if marioneta.distancia_a() < umbral:
            cambiar_estado()

func salir():
    marioneta.objetivo_actual = memoria_objetivo
    marioneta.objetivo_cord = memoria_cord_objetivo

    marioneta.ir_a(objetivo_cord)

    marioneta.reanudar_movimiento()

func manejar_sensores(data):
    cerebrum_exterior.manejar_sensores(data)

func verificar_capacidad_resolucion(data):
	return data[0] == "cuerpo" and data[1].is_in_group("controlador_exterior")

