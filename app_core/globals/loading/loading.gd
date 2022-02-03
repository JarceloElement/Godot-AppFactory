extends Node

var loader
var wait_frames
var time_max = 10 # msec
var current_scene
var progress = 0

var progressbar
var array_scn_loaded = []

func _ready():
	var root = get_tree().get_root()
	current_scene = get_tree().current_scene
#	$".".show()
#	print(current_scene)
	set_process(0)


func goto_scene(path,trans): # game requests to switch to this scene
#	$".".show()
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
		print("Error loading scn path: ",path)
		return
		
	var last_scn = array_scn_loaded.back()
	if last_scn != path: # si la scn solicitada no esta de ultima en la lista la agrega
		array_scn_loaded.append(path)
		
	if last_scn != null and last_scn == path: # si la scn solicitada esta de ultima
		array_scn_loaded.remove(array_scn_loaded.size()-1) # la remueve del la lista
		last_scn = array_scn_loaded.back() # actualiza la ultima scn
#		print("LAST-SCN: ",last_scn)
		
		loader = ResourceLoader.load_interactive(last_scn)
		if loader == null: # check for errors
			print("Error loading last_scn scn path: ",last_scn)
			return
		
	wait_frames = 0 # tiempo que durara la animacion antes de empezar a cargar el recurso | como para ver la transicion
	set_process(true)
	# print("last_scn: ",last_scn)
#	print("array_scn_loaded: ",get_node("/root/Loading").array_scn_loaded)


func _process(time):
#	$Sprite.rotate(0.07)
	if loader == null:
		# no need to process anymore
		set_process(false)
		return

#	yield(get_tree().create_timer(1.0), "timeout")

	if wait_frames > 0: # wait for frames to let the "loading" animation to show up
		wait_frames -= 1
		return

	var t = OS.get_ticks_msec()

	while OS.get_ticks_msec() < t + time_max: # use "time_max" to control how much time we block this thread
		# poll your loader
		var err = loader.poll()
		if err == ERR_FILE_EOF: # load finished
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
#			print("resource: ",resource)
			break
			
		elif err == OK:
			update_progress()
			
		else: # error during loading
			loader = null
			break



func update_progress():
	progress = (float(loader.get_stage()) / loader.get_stage_count())*100
#	print("progress ",int(progress))
	$Sprite.rotate(0.5)
	
	for bar in get_tree().get_nodes_in_group("loading_bar"):
		bar.loading_bar_set_stage(progress)

	# call this on a paused animation. use "true" as the second parameter to force the animation to update
#	get_node("animation").seek(progress * len, true)

func set_new_scene(scene_resource):
	get_tree().root.remove_child(current_scene)
#	current_scene.queue_free() # no queda en bufer
	
	set_process(0)
	
#	print("-----add new scene-----")
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)
	$".".hide()
	get_tree().current_scene = current_scene
	
	

	
