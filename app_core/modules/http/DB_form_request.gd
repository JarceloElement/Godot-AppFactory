extends HTTPRequest

# ---- DB ----
var dir_new = Directory.new()
var Home = ""
var path_media = ""
var path_image = ""
var path_data = ""
var path_res = ""
var path = ""
var field_name_list = []
#-------------

export var resultado = {}
export var array = ""
export var form_request_type = ""
export var request_button_param = []
var message = ""


func _ready():
	add_to_group("click_awesome")

	array = get_node("/root/FuncApp").array_form
	array = str(array).replace("[","").replace("]","").replace(" ","").replace(",","")

	# ATENCION  sin cargar el path antes no hace consulta | Debe precidir este codigo
	# --- PATH CONF ---
	Home = get_node("/root/FuncApp").Home
	path_media = str(Home) + get_node("/root/FuncApp").dir_name_media
	path_image = path_media + get_node("/root/FuncApp").dir_name_image
	path_data = path_media + get_node("/root/FuncApp").dir_name_data
	# print(ruta_data)
	
	#-------crear carpeta / DB--------
	if( !dir_new.dir_exists( Home ) ):
		dir_new.make_dir_recursive( Home )
		print( get_node("/root/FuncApp").dir_name_home + " | Folder created" )

	if( !dir_new.dir_exists( path_media ) ):
		dir_new.make_dir_recursive( path_media )
		print( get_node("/root/FuncApp").dir_name_media + " | Folder created" )

	if( !dir_new.dir_exists( path_image ) ):
		dir_new.make_dir_recursive( path_image )
		print( get_node("/root/FuncApp").dir_name_image + " | Folder created" )

	if( !dir_new.dir_exists( path_data ) ):
		dir_new.make_dir_recursive( path_data )
		print( get_node("/root/FuncApp").dir_name_data + " | Folder created" )




	# CREAR DB CON DATOS DEL FORM
	if form_request_type == "signup":

	#	print(get_node("/root/FuncApp").array_field_name)
		# print(get_node("/root/FuncApp").array_field_data)

		for field_name in get_node("/root/FuncApp").array_field_name:
			field_name_list.append(field_name) 

		# campos extras en DB
		field_name_list.append("user_avatar")
		field_name_list.append("date_reg")
		field_name_list.append("date_update")
		field_name_list.append("wallet")

		# datos extras
		get_node("/root/FuncApp").array_field_data.append("1") # avatar default
		get_node("/root/FuncApp").array_field_data.append(str(get_node("/root/FuncApp")._today_datetime())) # date_reg
		get_node("/root/FuncApp").array_field_data.append(str(get_node("/root/FuncApp")._today_datetime())) # date_update
		get_node("/root/FuncApp").array_field_data.append(str(5000)) # wallet

		# var session_path = get_node("/root/FuncApp").session_path[0] # variable estatica en func_app
		# var session_key = get_node("/root/FuncApp").session_path[1] # variable estatica en func_app
		var session_path = get_node("/root/FuncApp").ACTIVE_DB_PATH["path"] # se asigna en list del formulario
		var session_key = get_node("/root/FuncApp").ACTIVE_DB_PATH["table_name"] # se asigna en list del formulario

		# comprueba si el usuario existe
		if get_node("/root/DbQuery").add_user(session_key,session_path,get_node("/root/FuncApp").array_field_data)[2] == "TRUE":
			print(get_node("/root/DbQuery").create_configfile(session_key,session_path,field_name_list)) # crea la DB
			print(get_node("/root/DbQuery").add_user(session_key,session_path,get_node("/root/FuncApp").array_field_data)) # hace el registro

			# alerta nex user added
			var user_name = get_node("/root/Messages").get("New_user_add") % get_node("/root/FuncApp").array_field_data[0]
			var param = ["from DB_form",user_name,"user","","2d2d2d"]
			for i in get_tree().get_nodes_in_group("alert"):
				i.click_awesome("alert_show",param)
			get_node("/root/FuncApp").array_field_data = []

			var mensajes = get_tree().get_nodes_in_group("clear_form_field")
			for i in mensajes:
				i.clear_form_field() # va a los campos del formulario
				
			queue_free()


		else:
			# alerta user exist
			var user_name = get_node("/root/Messages").get("User_already_exist") % get_node("/root/FuncApp").array_field_data[0]
			# print("Hello %s, how you %s" % ["a", "b"])
			var param = ["from DB_form",user_name,"","","dc003e"]
			for i in get_tree().get_nodes_in_group("alert"):
				i.click_awesome("alert_show",param)
				
			get_node("/root/FuncApp").array_field_data = []
			get_node("/root/FuncApp").array_form = []

			queue_free()
	
	
	if form_request_type == "register":

	#	print(get_node("/root/FuncApp").array_field_name)
	#	print(get_node("/root/FuncApp").array_field_data)

		for field_name in get_node("/root/FuncApp").array_field_name:
			field_name_list.append(field_name) 

		# campos extras en DB
		field_name_list.append("date_reg")
		field_name_list.append("date_update")

		# datos extras
		get_node("/root/FuncApp").array_field_data.append(str(get_node("/root/FuncApp")._today_datetime())) # date_reg
		get_node("/root/FuncApp").array_field_data.append(str(get_node("/root/FuncApp")._today_datetime())) # date_update

		var conf_path = get_node("/root/FuncApp").ACTIVE_DB_PATH["path"] # lo asigna el DB_control
		var table_name = get_node("/root/FuncApp").ACTIVE_DB_PATH["table_name"] # lo asigna el DB_control
		var key_ = get_node("/root/FuncApp").array_field_data[1]
#		print("key_ ",key_)
		
		var DB = $"/root/DbQuery"
		var path = conf_path # lo asigna el DB_control
		var field = "*" # default: *
		var search = key_ # default * | busca solo el index, no recorre la linea
		var ID_ = "*" # alone no section no search | default *
		var where = [] # format: ["active,==,0"] | deafault []
		var id_field = "id" # default: ""
#		var query = DB.conf_query(table_name,path,field,search,ID_,where,id_field) # get_configFile("section","search","id",[where:"active,==,1"])
#		print("QUERY: ",DB.conf_query(table_name,path,field,search,ID_,where,id_field))
#		return
		
		# crea la DB si no existe
		var config = ConfigFile.new()
		if config.load(path) != OK:
			print(get_node("/root/DbQuery").create_configfile(table_name,conf_path,field_name_list)) # crea la DB
			
		# comprueba si el usuario NO existe
		if DB.conf_query(table_name,path,field,search,ID_,where,id_field)["EXIST"] == "FALSE":
			print(get_node("/root/DbQuery").save_configFile(conf_path,table_name,key_,get_node("/root/FuncApp").array_field_data)) # hace el registro


			# alerta
			var user_name = get_node("/root/Messages").get("New_user_add") % get_node("/root/FuncApp").array_field_data[0]
			var param = ["from DB_form",user_name,"user","","2d2d2d"]
			for i in get_tree().get_nodes_in_group("alert"):
				i.click_awesome("alert_show",param)
			get_node("/root/FuncApp").array_field_data = []

			var mensajes = get_tree().get_nodes_in_group("clear_form_field")
			for i in mensajes:
				i.clear_form_field() # va a los campos del formulario

		else:
			# alerta
			var user_name = get_node("/root/Messages").get("User_already_exist") % get_node("/root/FuncApp").array_field_data[1]
			# print("Hello %s, how you %s" % ["a", "b"])
			var param = ["from DB_form",user_name,"","","dc003e"]
			for i in get_tree().get_nodes_in_group("alert"):
				i.click_awesome("alert_show",param)

			get_node("/root/FuncApp").array_field_data = []
				
	# END CREAR DB CON DATOS DEL FORM
			
	
	
	if form_request_type == "register_boss":

	#	print(get_node("/root/FuncApp").array_field_name)
	#	print(get_node("/root/FuncApp").array_field_data)

		for field_name in get_node("/root/FuncApp").array_field_name:
			field_name_list.append(field_name) 

		# campos extras en DB
		field_name_list.append("lider_promotor_I")
		field_name_list.append("dni_lider_I")
		field_name_list.append("telefono_lider_I")
		field_name_list.append("lider_promotor_II")
		field_name_list.append("dni_lider_II")
		field_name_list.append("telefono_lider_II")
		field_name_list.append("estado")
		field_name_list.append("municipio")
		field_name_list.append("parroquia")


		field_name_list.append("date_reg")
		field_name_list.append("date_update")


		# datos extras
		var query_param_conf = {
			"section": "*",
			"search": "*",
			"id": "*",
			"where": [],
			"id_field": "id"
		}
		var DB_conf = $"/root/DbQuery"
		var path_conf = get_node("/root/FuncApp").leader_conf_path # "res://SocialApp/leader_conf.cfg"
		var Qconf = DB_conf.conf_query("CONF",path_conf,query_param_conf)

		# datos de config
		get_node("/root/FuncApp").post_request_dicc["lider_promotor_I"] = Qconf["result"][0]["value"]
		get_node("/root/FuncApp").post_request_dicc["dni_lider_I"] = Qconf["result"][1]["value"]
		get_node("/root/FuncApp").post_request_dicc["telefono_lider_I"] = Qconf["result"][2]["value"]
		get_node("/root/FuncApp").post_request_dicc["lider_promotor_II"] = Qconf["result"][3]["value"]
		get_node("/root/FuncApp").post_request_dicc["dni_lider_II"] = Qconf["result"][4]["value"]
		get_node("/root/FuncApp").post_request_dicc["telefono_lider_II"] = Qconf["result"][5]["value"]
		get_node("/root/FuncApp").post_request_dicc["estado"] = Qconf["result"][6]["value"]
		get_node("/root/FuncApp").post_request_dicc["municipio"] = Qconf["result"][7]["value"]
		get_node("/root/FuncApp").post_request_dicc["parroquia"] = Qconf["result"][8]["value"]


		get_node("/root/FuncApp").post_request_dicc["date_reg"] = (str(get_node("/root/FuncApp")._today_datetime())) # date_reg
		get_node("/root/FuncApp").post_request_dicc["date_update"] = (str(get_node("/root/FuncApp")._today_datetime())) # date_update

		var conf_path = get_node("/root/FuncApp").ACTIVE_DB_PATH["path"]
		var table_name = get_node("/root/FuncApp").ACTIVE_DB_PATH["table_name"]
		var key_ = get_node("/root/FuncApp").post_request_dicc["dni"]

		get_node("/root/FuncApp").post_request_dicc["parentesco"] = "Jefe de familia"
		get_node("/root/FuncApp").post_request_dicc["representante"] = "Jefe de familia"

		var query_param = {
			"section": "*",
			"search": key_,
			"id": "*",
			"where": [],
			"id_field": "id"
		}
		var DB = $"/root/DbQuery"
		var path = conf_path
		
		# crea la DB si no existe
		var config = ConfigFile.new()
		if config.load(path) != OK:
			print(get_node("/root/DbQuery").create_configfile(table_name,conf_path,field_name_list)) # crea la DB
		
#		print("CONSULTA: ",table_name,path,query_param)
		
		# comprueba si el usuario NO existe
		if DB.conf_query(table_name,path,query_param)["EXIST"] == "FALSE":
			print(get_node("/root/DbQuery").save_configFile(path,table_name,key_,get_node("/root/FuncApp").post_request_dicc)) # hace el registro

			# alerta
			var user_name = get_node("/root/Messages").get("New_user_add") % get_node("/root/FuncApp").post_request_dicc["nombres_apellidos"]
			var msg_param = ["from DB_form",user_name,"user","","2d2d2d"]
			for i in get_tree().get_nodes_in_group("alert"):
				i.click_awesome("alert_show",msg_param)
			get_node("/root/FuncApp").post_request_dicc = {}

			var mensajes = get_tree().get_nodes_in_group("clear_form_field")
			for i in mensajes:
				i.clear_form_field() # va a los campos del formulario

		else:
			# alerta
			var user_name = get_node("/root/Messages").get("User_already_exist") % get_node("/root/FuncApp").post_request_dicc["nombres_apellidos"]
			# print("Hello %s, how you %s" % ["a", "b"])
			var msg_param = ["from DB_form",user_name,"","","dc003e"]
			for i in get_tree().get_nodes_in_group("alert"):
				i.click_awesome("alert_show",msg_param)

			get_node("/root/FuncApp").post_request_dicc = {}
				
	# END CREAR DB CON DATOS DEL FORM
	
	






	if form_request_type == "register_member":

	#	print(get_node("/root/FuncApp").array_field_name)
	#	print(get_node("/root/FuncApp").array_field_data)

		for field_name in get_node("/root/FuncApp").array_field_name:
			field_name_list.append(field_name) 

		# campos extras en DB
		field_name_list.append("lider_promotor_I")
		field_name_list.append("dni_lider_I")
		field_name_list.append("telefono_lider_I")
		field_name_list.append("lider_promotor_II")
		field_name_list.append("dni_lider_II")
		field_name_list.append("telefono_lider_II")
		field_name_list.append("estado")
		field_name_list.append("municipio")
		field_name_list.append("parroquia")

		field_name_list.append("date_reg")
		field_name_list.append("date_update")

		# datos extras
		var query_param_conf = {
			"section": "*",
			"search": "*",
			"id": "*",
			"where": [],
			"id_field": "id"
		}
		var DB_conf = $"/root/DbQuery"
		var path_conf = get_node("/root/FuncApp").leader_conf_path # "res://SocialApp/leader_conf.cfg"
		var Qconf = DB_conf.conf_query("CONF",path_conf,query_param_conf)

		# datos de config
		get_node("/root/FuncApp").post_request_dicc["lider_promotor_I"] = Qconf["result"][0]["value"]
		get_node("/root/FuncApp").post_request_dicc["dni_lider_I"] = Qconf["result"][1]["value"]
		get_node("/root/FuncApp").post_request_dicc["telefono_lider_I"] = Qconf["result"][2]["value"]
		get_node("/root/FuncApp").post_request_dicc["lider_promotor_II"] = Qconf["result"][3]["value"]
		get_node("/root/FuncApp").post_request_dicc["dni_lider_II"] = Qconf["result"][4]["value"]
		get_node("/root/FuncApp").post_request_dicc["telefono_lider_II"] = Qconf["result"][5]["value"]
		get_node("/root/FuncApp").post_request_dicc["estado"] = Qconf["result"][6]["value"]
		get_node("/root/FuncApp").post_request_dicc["municipio"] = Qconf["result"][7]["value"]
		get_node("/root/FuncApp").post_request_dicc["parroquia"] = Qconf["result"][8]["value"]
		
		get_node("/root/FuncApp").post_request_dicc["date_reg"] = (str(get_node("/root/FuncApp")._today_datetime())) # date_reg
		get_node("/root/FuncApp").post_request_dicc["date_update"] = (str(get_node("/root/FuncApp")._today_datetime())) # date_update

		var conf_path = get_node("/root/FuncApp").ACTIVE_DB_PATH["path"] # lo asigna el DB_control
		var table_name = get_node("/root/FuncApp").ACTIVE_DB_PATH["table_name"] # lo asigna el DB_control
		var key_ = get_node("/root/FuncApp").post_request_dicc["dni"]

		# agrega al campo representante | dni del jefe de familia
		var boss_dni = get_node("/root/Global").TEMP_REGISTER_MEMBER_PARAM["dni_boss"]
		var carga_total = int($"/root/DbQuery".conf_query(table_name,conf_path,{"section": "*","search":boss_dni,"id":"*","where": [],"id_field": "id"})["result"][0]["carga_total"])
		get_node("/root/FuncApp").post_request_dicc["representante"] = boss_dni

		var query_param = {
			"section": "*",
			"search": key_,
			"id": "*",
			"where": [],
			"id_field": "id"
		}
		var DB = $"/root/DbQuery"
		var path = conf_path
		
		
		# crea la DB si no existe
		var config = ConfigFile.new()
		if config.load(path) != OK:
			print(get_node("/root/DbQuery").create_configfile(table_name,conf_path,field_name_list)) # crea la DB
			
		# comprueba si el usuario NO existe
		if DB.conf_query(table_name,path,query_param)["EXIST"] == "FALSE":
			print(get_node("/root/DbQuery").save_configFile(path,table_name,key_,get_node("/root/FuncApp").post_request_dicc)) # hace el registro

			# actualiza el total de la carga del jefe
			get_node("/root/DbQuery").update_configFile(path,table_name,boss_dni,{"id_field":"id","carga_total":str(int(carga_total)+1 )})

			# alerta
			var user_name = get_node("/root/Messages").get("New_user_add") % get_node("/root/FuncApp").post_request_dicc["nombres_apellidos"]
			var param = ["from DB_form",user_name,"user","","2d2d2d"]
			for i in get_tree().get_nodes_in_group("alert"):
				i.click_awesome("alert_show",param)
			get_node("/root/FuncApp").post_request_dicc = {}

			var mensajes = get_tree().get_nodes_in_group("clear_form_field")
			for i in mensajes:
				i.clear_form_field() # va a los campos del formulario



		else:
			# alerta
			var user_name = get_node("/root/Messages").get("User_already_exist") % get_node("/root/FuncApp").post_request_dicc["nombres_apellidos"]
			# print("Hello %s, how you %s" % ["a", "b"])
			var param = ["from DB_form",user_name,"","","dc003e"]
			for i in get_tree().get_nodes_in_group("alert"):
				i.click_awesome("alert_show",param)
			get_node("/root/FuncApp").post_request_dicc = {}
				
	# END CREAR DB CON DATOS DEL FORM



# 	# USER DELETE
# 	if form_request_type == "user_delete":

# 		var user_id
# 		for user in get_node("/root/FuncApp").SESSION:
# 			user_id = user["user_id"]

# 		table_name = "signup" # la DB lleva el mismo nombre del form_request_type en el formulario
# 		path = (ruta_data+"/"+table_name+".db") # esto crea la DB en la ruta como texto plano en blanco sin registros
# 		if sql.open(path) != sql.SQLITE_OK:
# 			print("ERR SQL campo report: ", sql.get_errormsg());
# 		else:
# 			sql.open(path)
# 			pass

# 		sql.fetch_array("DELETE FROM "+table_name+" WHERE user_id='"+str(user_id)+"';")

# 		var param_msg = ["user_delete",get_node("/root/Messages").user_deleted,"icon_off"]
# 		for i in get_tree().get_nodes_in_group("alert"):
# 			i.show()
# 			i.click_awesome("alert_show",param_msg)

# 		for i in get_tree().get_nodes_in_group("click_awesome"):
# 			i.click_awesome("signout","http_user_delete")

# 	#	print("DELETE FROM "+table_name+" WHERE user_id='"+str(user_id)+"';")


	
# 	if get_node("/root/FuncApp").Total_list_field == get_node("/root/FuncApp").array_form.size(): # si esta completo el formulario

# 		# USER EDIT
# 		if form_request_type == "user_edit":

# 			table_name = "signup" # la DB lleva el mismo nombre del form_request_type en el formulario
# 			path = (ruta_data+"/"+table_name+".db") # esto crea la DB en la ruta como texto plano en blanco sin registros
# 			if sql.open(path) != sql.SQLITE_OK:
# 				print("ERR SQL campo report: ", sql.get_errormsg());
# 			else:
# 				sql.open(path)
# 				pass

# 			for columna in get_node("/root/FuncApp").array_field_name:
# 				field_name_list.append(columna) 

# 			# campos extras en DB
# 			field_name_list.append("user_avatar")
# 			field_name_list.append("date_update")
# 			field_name_list.append("wallet")

# 			# datos de campos extras
# 			get_node("/root/FuncApp").array_field_data.append("1") # avatar default
# 			get_node("/root/FuncApp").array_field_data.append(str(get_node("/root/FuncApp")._hoy_datetime())) # date_update
# 			get_node("/root/FuncApp").array_field_data.append(str(100)) # wallet

# 			var user_id
# 			for user in get_node("/root/FuncApp").SESSION:
# 				user_id = user["user_id"]

# 			var data = get_node("/root/FuncApp").array_field_data
# 		#	print(field_name_list,"-",data)
			
# 			sql.query("UPDATE "+table_name+" SET "+str(field_name_list[0])+"='"+str(data[0])+"'"+", "+str(field_name_list[1])+"='"+str(data[1])+"'"+", "+str(field_name_list[2])+"='"+str(data[2])+"'"+", "+str(field_name_list[3])+"='"+str(data[3])+"'"+", "+str(field_name_list[4])+"='"+str(data[4])+"'"+", "+str(field_name_list[5])+"='"+str(data[5])+"'"+", "+str(field_name_list[6])+"='"+str(data[6])+"'"+", "+str(field_name_list[7])+"='"+str(data[7])+"' WHERE user_id='"+str(user_id)+"';");
# 			sql.close()
# 			print("User Updated")

# 			var param_msg = ["request_form",get_node("/root/FuncApp").array_field_data[0]+get_node("/root/Messages").send_form_DB_user_update,"icon_off"]
# 			var mensajes = get_tree().get_nodes_in_group("alert")
# 			for i in mensajes:
# 				i.click_awesome("alert_show",param_msg)

# 			# var mensajes = get_tree().get_nodes_in_group("limpiar_campos")
# 			# for i in mensajes:
# 			# 	i.limpiar_campos() # va a los campos del formulario

# 			get_node("/root/FuncApp").array_field_name = []
# 			get_node("/root/FuncApp").array_field_data = []

# 			get_parent().queue_free()



	# USER LOGIN
	if form_request_type == "signin":

		# lista de usuarios existentes
		var session_path = get_node("/root/FuncApp").session_path[0]
		var session_key = get_node("/root/FuncApp").session_path[1]
		var users_array = []
		# print("session_path",session_path)

		var DB = $"/root/DbQuery"
		var path = session_path
		var field = "*" # default: *
		var search = get_node("/root/FuncApp").array_field_data[0] # default * | busca solo el index, no recorre la linea
		var ID_ = "*" # alone no section no search | default *
		var where = [] # format: ["active,==,0"] | deafault []
		var id_field = "id" # ID de los nombre de los campos (*)

		var query = DB.conf_query(session_key,path,field,search,ID_,where,id_field)
#		print("query:",query)

		# si no hay resultados
		if query != null:
			if query["result"] == null:
				var param_msg = ["request_form_user_no_exist",get_node("/root/Messages").send_form_DB_user_no_exist,"warning","111111","111111"]
				for i in get_tree().get_nodes_in_group("alert"):
					i.click_awesome("alert_show",param_msg)

				print("User_NO_exist: ",get_node("/root/FuncApp").array_field_data[0])

				get_node("/root/FuncApp").array_field_name = []
				get_node("/root/FuncApp").array_field_data = []

				return
				queue_free()


			# usuario existe
			var user_name = query["result"]["user_name"]
	#			print("user_name: ",user_name)
			if get_node("/root/FuncApp").array_field_data[0] == user_name:
				# carga la clave del usuario
				var user_password = query["result"]["user_pass"]

				# clave incorrecta | compara las claves
				if user_password != get_node("/root/FuncApp").array_field_data[1]:
	#				print("SESSION: ",user_password)
					var param_msg = ["request_form_wrong_password",get_node("/root/Messages").signin_wrong_password,"warning","111111","111111"]
					for i in get_tree().get_nodes_in_group("alert"):
						i.click_awesome("alert_show",param_msg)

					get_node("/root/FuncApp").array_field_name = []
					get_node("/root/FuncApp").array_field_data = []

					queue_free()


				# clave correcta | iniciar session
				else:
					# carga la sesion
					get_node("/root/FuncApp").SESSION = query["result"]
	#					print(get_node("/root/FuncApp").SESSION)
					
					var user_gender = get_node("/root/FuncApp").SESSION["user_gender"]
	#				print("SESSION CORRECT: ",user_name)
					# saludo por genero
					var param_msg = []
					if user_gender == "Femenino":
						param_msg = ["request_form_signin",get_node("/root/Messages").signin_finish_female+" "+user_name,"user","111111","111111"]
					if user_gender == "Masculino":
						param_msg = ["request_form_signin",get_node("/root/Messages").signin_finish_male+" "+user_name,"user","111111","111111"]

					for i in get_tree().get_nodes_in_group("alert"):
						i.click_awesome("alert_hide",param_msg)

					for i in get_tree().get_nodes_in_group("click_awesome"):
						i.click_awesome("add_popup_login",param_msg)

					get_node("/root/FuncApp").array_field_name = []
					get_node("/root/FuncApp").array_field_data = []

					queue_free()








		

# 		if request_button_param == "http":
# 		#	print(form_request_type,array)
		
# 			request(str(get_node("/root/FuncApp").URL_POST)+"action="+str(form_request_type)+"&"+str(array))
			
# 			connect("request_completed", self, "_on_HTTPRequest_request_completed")
		
# 			var param_msg = ["request_form",get_node("/root/Messages").get(form_request_type),"icon_off"]
# 			var mensajes = get_tree().get_nodes_in_group("alert")
# 			for i in mensajes:
# 				i.click_awesome("alert_show",param_msg)

	

# 	else: # si no esta completo el formulario
# 		get_node("/root/FuncApp").array_form = []

# 		get_parent().queue_free()







# func _on_HTTPRequest_request_completed( result, response_code, headers, body ):

# 	if(result == HTTPRequest.RESULT_SUCCESS):
# 	#	print("response_code ",response_code)
		
# 		if response_code == 200:

# 			resultado.parse_json( body.get_string_from_ascii() )
# 		#	print (resultado)

# 			get_node("/root/FuncApp").array_form_request_response = resultado

# 			get_node("/root/FuncApp").array_form = []

			

# 			var request_message = ""
# 			if resultado.has("user_name"):
# 				request_message = resultado["user_name"]
# 			else:
# 				request_message = resultado["ERROR"]
				
# 			if form_request_type == "signin" and resultado.has("user_name"):
# 				message = get_node("/root/Messages").signin_finish+" "+request_message
				
# 				var mensajes = get_tree().get_nodes_in_group("limpiar_campos")
# 				for i in mensajes:
# 					i.limpiar_campos() # va a los campos del formulario
					

# 			if form_request_type == "signin" and !resultado.has("user_name"):
# 				message = get_node("/root/Messages").get(request_message)

# 			if form_request_type == "signup":
# 				message = get_node("/root/Messages").signup_finish

# 			if form_request_type == "signout":
# 				message = get_node("/root/Messages").signout_finish
				
# 			if form_request_type == "post_form":
# 				message = get_node("/root/Messages").send_form_complete

# 			var param_msg = ["request_form",message,"icon_off"]
# #			var param_msg = ["request_form",message,resultado['field_wrong'],"icon_off"]
# 			var mensajes = get_tree().get_nodes_in_group("alert")
# 			for i in mensajes:
# 				i.click_awesome("alert_show",param_msg)

# 			# print("form_request_response_code ",response_code)
			

# 		else:
# 			print("err_code ",response_code)
# 			# --- MENSAJE AWESOME ---
# 			var param_msg = ["request_form",
# 			get_node("/root/Messages").send_form_request_no200+str(response_code),"icon_off"]

# 			var mensajes = get_tree().get_nodes_in_group("alert")
# 			for i in mensajes:
# 				i.click_awesome("alert_show",param_msg)






# 	if(result == HTTPRequest.RESULT_CANT_CONNECT):
# 		print("err_code ",response_code)
# 		# --- MENSAJE AWESOME ---

# 		var param_msg = ["request_form",
# 			get_node("/root/Messages").send_form_cant_connet_icon+str(response_code),"warning"]

# 		var mensajes = get_tree().get_nodes_in_group("alert")
# 		for i in mensajes:
# 			i.click_awesome("alert_show",param_msg)


# 	get_parent().queue_free()



func click_awesome(id_message,message_text):

	if id_message == "quit_request":

		for i in get_tree().get_nodes_in_group("limpiar_campos"):
			i.limpiar_campos() # va a los campos del formulario

		# var param_msg = ["request_form","","icon_off"]
		# for i in get_tree().get_nodes_in_group("alert"):
		# 	i.click_awesome("alert_show",param_msg)



		get_parent().queue_free()




	# print(id_message," ",message_text)
