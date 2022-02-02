extends "res://codigo_generico/IA/MaquinaEstados/estado.gd"


export(float) var velocidad_golpe = 75.0
export(float) var cadencia_golpes = 0.5
var tempo = 1.0

var ataque = preload("res://Objetos/Personajes/Enemigo(MEF)/recursos/ataque_cuerpo_cuerpo.tscn")

var marioneta = null
var objetivo = null
var sigue_visible = true
var atacar_con_brazo_sup = true

func _ready():
	marioneta = get_owner()
	
	tempo = cadencia_golpes

func entrar(data = false):
	tempo = cadencia_golpes
	objetivo = data["objetivo"]
	print(data)

func actualizar(delta):
	marioneta.look_at(objetivo.global_position)
	
	tempo -= delta
	
	if tempo <= 0.0:
		tempo = cadencia_golpes
		golpear()

func golpear():
	if not sigue_visible:
		print("Fuera de alcance")
		emit_signal("finalizado", "ir_a")
		return
	
	var instancia = ataque.instance()
	
	if atacar_con_brazo_sup:
		instancia.position = marioneta.brazo_sup.get_global_position()
		atacar_con_brazo_sup = false
	
	else:
		instancia.position = marioneta.brazo_inf.get_global_position()
		atacar_con_brazo_sup = true
	
	instancia.rotation_degrees = marioneta.rotation_degrees
	
	instancia.apply_impulse(Vector2(), Vector2(velocidad_golpe, 0).rotated(marioneta.rotation))
	
	get_tree().get_root().call_deferred("add_child", instancia)
	
	sigue_visible = false

func manejar_sensores(data):
	if not data:
		return 
	
	if data[0] == "vision_corta" and data[1] == objetivo:
		sigue_visible = true

	print(data)
	print(sigue_visible)
