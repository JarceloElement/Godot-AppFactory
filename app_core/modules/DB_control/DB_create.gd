extends MarginContainer


export var DB_name = "form_signup.cfg"
export var csv_to_DB = Array([bool(1),"res://DB/form_signup.csv"])
export var table_name = "SIGNUP_FORM"
export var field_index = 0
export var Show_ProgressBar = bool(1)
export var impor_priority = 1


# ---- DB ----
var dir_new = Directory.new()
#var Home = ""
var path_media = ""
var path_image = ""
var path_data = ""
var path_res = ""
var path_user = ""
var export_DB_to_user = ""
#var Path_DB_name = "users"
var path_DB_home = ""
#-------------




var progress_bar
var cond_bool = 1




func _ready():
	
	add_to_group("DB_control")

	if impor_priority == 0:
		queue_free()
		
	progress_bar = get_node("ProgressBar")
	if Show_ProgressBar == false:
		hide()

	# --- PATH CONF ---
#	Home = get_node("/root/FuncApp").Home
	path_media = get_node("/root/FuncApp").path_media
	path_image = get_node("/root/FuncApp").path_image
	path_data = get_node("/root/FuncApp").path_data
	path_user = get_node("/root/FuncApp").path_user
	path_res = get_node("/root/FuncApp").path_res

	set_process(true)



func _process(delta):
#	$Label.set_text("_process() "+str(get_node("/root/FuncApp").menu_hide)+str(cond_bool) )
	$Label.set_text("_process: TXT "+str(dir_new.file_exists("res://DB/leader_conf.txt") ))

#	if dir_new.file_exists(csv_to_DB[1]) == true:
	if get_node("/root/FuncApp").menu_hide == 1 and cond_bool == 1: # si el menu esta cerrado
		$Label.set_text("_process()-menu_hide "+str(get_node("/root/FuncApp").menu_hide)+str(cond_bool) )
		cond_bool = 0
		set_process(false)
		_ini()



func _ini(): # viene de process_delta
		
	if get_node("/root/FuncApp").DB_control_priority == impor_priority:
	
		path_DB_home = (path_user+DB_name) # esto crea la DB en la ruta como texto plano en blanco sin registros
		get_node("/root/FuncApp").ACTIVE_DB_PATH["path"] = path_DB_home

		if csv_to_DB[0] == true: # si esta activa la importacionde DB

#			print(path_DB_home)

			if !dir_new.file_exists(path_DB_home):
				$Label.set_text(" NO exist in: "+path_DB_home)
				if !dir_new.file_exists(csv_to_DB[1]):
					print("Error: NO exist: ",csv_to_DB[1])
					$Label.set_text("Error: NO exist: "+str(csv_to_DB[1]))
					return
				var DB_create = get_node("/root/DbQuery").save_csv_to_configfile(table_name,csv_to_DB[1],path_DB_home,",",field_index)
				print(DB_create)
				$Label.set_text("Created cfg: "+str(DB_create))
			else:
				print("DB ",DB_name," exist in: ",path_DB_home)
				$Label.set_text(DB_name+" exist in: "+path_DB_home)

		# copiar DB a la ruta local del dispositivo para luego leerla
		if csv_to_DB[0] == false: # copia la DB del proyct_data_folder a la ruta local del sistema
			if !dir_new.file_exists(path_DB_home): # si no existe en disco local del dispositivo
				
				path_res = path_res+DB_name # ("res://DB/"+DB_name) # ruta DB en proyecto
				if dir_new.file_exists(path_res):
					dir_new.copy(path_res,path_DB_home) # copiar al disco local del dispositivo
					print("DB copied from: ",path_res," to: ",path_DB_home)
				else:
					print("ERROR COPY DB: No exists ",path_res)
			else:
				print("DB COPY: ",DB_name," exist in: ",path_DB_home)





		for i in get_tree().get_nodes_in_group("add_item_form"):
			i._add_result_request_list()

		for i in get_tree().get_nodes_in_group("trivie_control"):
			i._DB_loaded_and_ini()

		get_node("/root/FuncApp").DB_control_priority += 1 # incrementa para activar el siguiente DB_control si lo hay

		queue_free()



func quit():
	queue_free()
	pass

