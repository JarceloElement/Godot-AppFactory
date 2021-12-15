extends Node



var TEMP_REGISTER_MEMBER_PARAM = {}


func _ready():
	
#	activeScene = get_tree().current_scene
#	activeScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)

#	Home = str(Home) + dir_name_home # ruta a carpeta de DB local
#	path = (Home+"/") # ruta a DB en ruta local
#	path = "res://db/regiones.sql"


#	print(Home)

	# --- INSTANCE TYPE ----
#	if scene_ID == 1:
#		ITEM_TYPE = message # tipo de campo para listar
	# if scene_ID == 2:
	# 	ITEM_TYPE = product # tipo de campo para listar



	# add request notificaciones
#	var ping = reporte_general.instance()
#	add_child(ping)
	#-------------------------------------------
	pass
	
	# set_process(1)
func _process(delta):
#	print(slider_pos_global)

	pass

	

#
#func setScene(scenename):
##	print("scenename-",scenename)
#	if (activeScene.get_name() == "splash"):
#		#clean up the active scene
#		activeScene.queue_free()
#	else:
#		get_tree().get_root().call_deferred("remove_child",activeScene)
#
#	var newScene = null
#	newScene = ResourceLoader.load("res://" + scenename )
#	activeScene = newScene.instance()
#	get_tree().get_root().call_deferred("add_child",activeScene)
#


#
#func setScene(set_scene_path, scenename):
#	var preload_scn = "res://app_core/templates/form/signin.tscn"
#
#	if !array_scn_loaded.has(scenename):
#		array_scn_loaded.append(scenename)
#
##	print("Global-activeScene: ",activeScene.get_name()," | ",array_scn_loaded)
##	print(get_tree().get_root().get_children()[0].get_name())
#
#	if (activeScene.get_name() == "splash"):
#		#clean up the active scene
#		activeScene.queue_free()
#	else:
#		get_tree().get_root().call_deferred("remove_child",activeScene)
#
#
#
##	var loader = ResourceLoader.load_interactive(preload_scn)
##	var resource
##	while not resource:
##		var err = loader.poll()
##		if err == ERR_FILE_EOF:
##			resource = loader.get_resource()
##			break
##
##		yield(get_tree(), "idle_frame")
##
##	print("Done.")
#
#
#
#
#	var newScene = null
#	newScene =  ResourceLoader.load_interactive("res://app_core/templates/form/signin.tscn")
##	newScene = call_deferred("resource_loader/load","res://app_core/templates/form/signin.tscn") #ResourceLoader.load("res://app_core/templates/form/signin.tscn")
#
#
#	print(newScene)
#
#	# newScene = ResourceLoader.load("res://" + scenename )
##	activeScene = newScene.instance()
##	get_tree().get_root().call_deferred("add_child",activeScene)
#
#



