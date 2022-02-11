extends "res://codigo_generico/controlador_objetos_interactuables.gd"


func _on_indicador_interaccion_area_entered(area):
	if not recogible:
		return
	
	var objetivo = area.get_owner()
	var estado_espacio = get_world_2d().direct_space_state

	var res = estado_espacio.intersect_ray(global_position, objetivo.global_position, [self, area], objetivo.collision_layer, true, true)
	
	if res.collider == objetivo:
		_en_interaccion_recogible(area)
