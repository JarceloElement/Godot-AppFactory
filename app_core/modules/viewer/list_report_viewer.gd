
extends VBoxContainer

export var form_type = "form"
export var form_request_type = "signup"
export var form_db_name = "db_name.cfg" # 
export var form_table_name = "form" # 
export var field_instance_name = "line_edit_panel" # tambien la asigna el DB_control en el mensaje _add_result_request_list
# for registration form
export var DB_name = "register.cfg" # 
export var DB_table = "REGISTER" # 
#export var DB_where = []
export var view_mode = 1
export var max_list = int(5) # cantidad por pagina
export var set_init = bool(1)
var table_name = "USERS_FORM" # la asigna el DB_control en el mensaje _add_result_request_list
var Path_DB_form = "from_DB_control" # la asigna el DB_control en el mensaje _add_result_request_list


# listas de reportes
var total_item_displayed = 0
var N_list = 0
var displayed = 0
var displayed_in_dashboard = 0
var total_displayed = 0
var temp_total_show = 0
var time = 0
var total_report = 0
var Table_name = ""





var ping_post = ""
var scrollContainer
var temp_pos_scroll = 0
var set_temp_scroll = 0

var message_sent = 0

var menu_tipe = 1

var to_list = 0
var id_item = 0



# fields
var field_name = []
var field_icon = []
var field_title = []
var field_placeholder = []
var field_default_value = []
var field_type = []
var field_secret_character = []
var field_options = []
var field_max_text = []
var field_visible = []
var is_null = []


# category list
var DNI = []


# result query
var query = {}




func _ready():
	add_to_group("add_item_form")
	add_to_group("add_item_reportes")
	add_to_group("click_awesome")


	set_process(1)
	set_process_input(true)

	scrollContainer = get_owner().get_node("ScrollContainer")

	get_node("/root/FuncApp").Total_list_field = get_child_count()

	get_node("/root/FuncApp").field_instance_name = field_instance_name
	# get_node("/root/FuncApp").Path_DB_query = Path_DB_query

	# if root_path == "res://":
	# 	get_node("/root/FuncApp").ACTIVE_DB_PATH["path"] = get_node("/root/FuncApp").path_res+DB_name
	# if root_path == "user://":
	get_node("/root/FuncApp").ACTIVE_DB_PATH["path"] = get_node("/root/FuncApp").path_user+DB_name
	get_node("/root/FuncApp").ACTIVE_DB_PATH["form_path"] = get_node("/root/FuncApp").path_user+form_db_name
		
	get_node("/root/FuncApp").ACTIVE_DB_PATH["table_name"] = DB_table



	# ------------------------------



	if set_init == true:
		_add_result_request_list()
		pass


func _add_result_request_list(): # lo envia el DB_control al terminar la carga


	to_list = 1
	print(" ...Adding list... ")
	
	# request online
	if get_node("/root/FuncApp").Request_status == 1:
		total_report = get_node("/root/FuncApp").HTTP_Request_result["items_id"]
		# field_for_search
		get_node("/root/FuncApp").field_for_search = get_node("/root/FuncApp").HTTP_Request_result["field_for_search"]
		print("Total-report-HTTP: ",total_report.size()," From HTTP ")

	else:
		
		
		
		
	# ======================================

		# LOGIN FORM
		if form_type == "form":
			# "id" # default: ""
			var query_param = {
				"section": "*",
				"search": "*",
				"id": "*",
				"where": [],
				"id_field": "id"
			}
			var DB = $"/root/DbQuery"
			var path = get_node("/root/FuncApp").ACTIVE_DB_PATH["form_path"]
			query = DB.conf_query(form_table_name,path,query_param) # get_configFile("section","search","id",[where:"active,==,1"])
			if query == null:
				return
			for line in query["result"]:
				# print(line["title"])
				field_name.append(line["field_name"])
				field_icon.append(line["icon"])
				field_title.append(line["title"])
				field_placeholder.append(line["placeholder"])
				field_default_value.append(line["default_value"])
				field_type.append(line["type"])
				field_secret_character.append(line["secret_character"])
				field_options.append(line["options"])
				field_max_text.append(line["max_text"])
				field_visible.append(line["visible"])
				is_null.append(line["null"])
			
#			print(field_title)
			
			total_report = DB.get_configFile_DB_total(form_table_name,path)
			get_node("/root/FuncApp").Total_list_field = total_report
			# print("total_report FORM:",total_report)
	
			pass






	if total_report == 0:
		# --- NO RESULT SEARCH ---
		var param_msg = [get_node("/root/Messages").no_result_search_icon,
		get_node("/root/Messages").no_result_search]
		var mensajes = get_tree().get_nodes_in_group("click_awesome")
		for i in mensajes:
			i.click_awesome("message_request_form",param_msg)
		# ----------------------------------------------

	get_node("/root/FuncApp").total_report = total_report
	get_node("/root/FuncApp").resul_report = total_report

	# print("SQL_TABLE_NAME: ",SQL_TABLE_NAME)
	# print("Hello %s, how you %s" % ["a", "b"])

	# ----------------------------------------------








func _process(delta):

	# ----------- MUEVE EL SCROLL AL EDITAR | grab focus -----------
	var VS = get_parent().get_v_scroll()
	var VS2 = get_parent().get_end().y
#	print(VS,"--",VS2)
	

	if VS > VS/2:
		get_node("/root/FuncApp").scroll_top = 0
		
	if VS == 0:
		get_node("/root/FuncApp").scroll_top = 1

	# ---- guarda pos del scroll ----
	# if set_temp_scroll == 0:
	# 	get_node("/root/FuncApp").temp_pos_scroll = VS # guarda la pos del scroll para ubicarlo al volver del preview de estados


	# coloca en cero cuando boton volver del movil  en reporte.gd los coloca en negativo
	if get_node("/root/FuncApp").temp_total_show < 0:
		get_node("/root/FuncApp").temp_total_show = 0
	if get_node("/root/FuncApp").temp_total_show < 0:
		get_node("/root/FuncApp").temp_total_show = 0
	if N_list < 0:
		N_list = 0
	if total_item_displayed < 0:
		total_item_displayed = 0
	#---------------------------




	# ------------- crea la lista en el scroll -----------------
	if to_list > 0 and to_list < 5: # espera un tiempo antes de agregar los items para cerrar el menu
		to_list += 1
	
	
	# si el menu esta cerrado
	if get_node("/root/FuncApp").menu_hide == 1 and to_list >= 5: # to_list: envia _add_result_request_list 
		if total_displayed < total_report and displayed != max_list:
			crear_boton()
		else:
			to_list = 0

		for ms in get_tree().get_nodes_in_group("click_awesome"):
			ms.click_awesome("product_set_opacity","1")

		for ms2 in get_tree().get_nodes_in_group("set_count_idicator"):
			if view_mode == 1:
				ms2.set_text(str(N_list)+"/"+str(total_report))
			if view_mode == 2:
				ms2.set_text(str(total_item_displayed)+"/"+str(total_report))




func crear_boton():

	if view_mode == 1:

		N_list += 1
		# asigna pos al scroll donde estaba al salir al preview
		if displayed < N_list:
			scrollContainer.set_v_scroll(get_node("/root/FuncApp").temp_pos_scroll)
		
		displayed += 1
		total_displayed += 1
		displayed_in_dashboard +=1

		# detiene el scroll temporal
		if N_list >= total_report or N_list >= max_list:
			set_temp_scroll = 0


	if view_mode == 2:

		N_list += 1
		# asigna pos al scroll donde estaba al salir al preview
		if displayed < N_list:
			scrollContainer.set_v_scroll(get_node("/root/FuncApp").temp_pos_scroll)
		
		displayed += 1
		total_displayed += 1
		displayed_in_dashboard += 1

		# detiene el scroll temporal
		if N_list >= total_report or N_list >= max_list:
			set_temp_scroll = 0

#	print("total_report: ",total_report)
	if total_report > 0:
		var ping
		if field_instance_name != "":
			ping = get_node("/root/FuncApp").get(get_node("/root/FuncApp").field_instance_name).instance()
		else:
			ping = Label.new()
			ping.autowrap = true
			ping.align = Label.ALIGN_CENTER
			ping.add_to_group("form_fields")
			
		# FORM
		if form_type == "form":
			if field_instance_name != "":
				ping.set_name(str(N_list))
				ping._visible = int(field_visible[N_list-1])
				ping.is_null = int(is_null[N_list-1])
				ping.field_name = field_name[N_list-1]
				ping.icon = field_icon[N_list-1]
				ping.title = field_title[N_list-1]
				ping.type = field_type[N_list-1]
				ping.placeholder_text = field_placeholder[N_list-1]
				ping.default_value = field_default_value[N_list-1]
				ping.secret_character = field_secret_character[N_list-1]
				ping.field_options = field_options[N_list-1].split(";",true)
				# print("N_list: ",N_list)
				# print("ADD_items: -",field_title[N_list-1],"-")
			elif field_instance_name == "":
				ping.set_name(str(N_list))
				ping.set_text(str(query["result"][N_list-1]))


		add_child(ping)


	# ----------------------------------------




# ----- PAGINACION ----
# lo envia el scroll_viewer en top & end
func pag_adelante():

	if (get_node("/root/FuncApp").popup_form_active == 0 or get_owner().popup_form_active == 1):

		if view_mode == 1:
			if N_list < total_report:
				for i in get_tree().get_nodes_in_group("form_fields"):
					i.queue_free()
					get_parent().set_v_scroll(0)
					
					displayed = 0
					to_list = 1
					displayed_in_dashboard = 0

					var mensajes = get_tree().get_nodes_in_group("click_awesome")
					for ms3 in mensajes:
						ms3.click_awesome("product_set_opacity","0")

		if view_mode == 2:
			print(N_list,total_report)
		
			if total_item_displayed < total_report:
			
				for i in get_tree().get_nodes_in_group("form_fields"):
					i.queue_free()
				get_parent().set_v_scroll(0)

				displayed = 0
				to_list = 1
				displayed_in_dashboard = 0
				get_node("/root/FuncApp").next_product = get_node("/root/FuncApp").temp_total_show+1

				var mensajes = get_tree().get_nodes_in_group("click_awesome")
				for i in mensajes:
					i.click_awesome("product_set_opacity","0")
					i.click_awesome("set_back_message",get_node("/root/FuncApp").active_message_param)
				



func pag_atras():

	if (get_node("/root/FuncApp").popup_form_active == 0 or get_owner().popup_form_active == 1):

		# lista atras
		if total_displayed > max_list:
			for i in get_tree().get_nodes_in_group("form_fields"):
				i.queue_free()
			get_parent().set_v_scroll(0)

			total_displayed = total_displayed-(max_list+displayed) # resta los item mostrados
			total_item_displayed = total_displayed-(max_list+displayed) # resta los item mostrados

			displayed = 0
			to_list = 1
			N_list = total_displayed
			# cantidad en la paginacion antes de preview
			displayed_in_dashboard = 0

			# almacena en que paginacion esta el reporte
			get_node("/root/FuncApp").temp_total_show = total_displayed


			var mensajes = get_tree().get_nodes_in_group("click_awesome")
			for i in mensajes:
				i.click_awesome("product_set_opacity","0")
# -----FIN  PAGINACION ----

		# print(N_list,"-",total_report.size(),"-",total_item_displayed,"-",displayed)






func _on_Button_pressed(): # ir al top
	# || MENSAJE || 
	var mensajes_0 = get_tree().get_nodes_in_group("ScrollContainer_lista")
	for i in mensajes_0:
		i.set_v_scroll(0)


func click_awesome(id_message,param):
	
	
	# add DB_control from category
	if id_message == "add_DB_control_from_category" or id_message == "add_HTTP_control_from_category":
		var mensajes_0 = get_tree().get_nodes_in_group("campos_form")
		for i in mensajes_0:
			i.eliminar_campo_form() # va a los campos_form o reportes para eliminarlos
			pass
			
		Table_name = param[2]
		displayed_in_dashboard = 0
		get_node("/root/FuncApp").temp_total_show = 0
		total_item_displayed = 0
		total_displayed = 0
		displayed = 0
		N_list = 0
		get_node("/root/FuncApp").next_product = 1
		get_node("/root/FuncApp").DB_control_priority = 1
		

		if id_message == "add_DB_control_from_category":
			ping_post = get_node("/root/FuncApp").DB_control.instance()
		if id_message == "add_HTTP_control_from_category":
			ping_post = get_node("/root/FuncApp").HTTP_control.instance()

		get_node("/root/FuncApp").INSTANCE = param[0]

		ping_post.field_instance_name = param[0]
		ping_post.DB_name = param[1]
		ping_post.Table_name = param[2]
		ping_post.Id_Ref = param[3]
		ping_post.ORDER_BY = param[4]
		ping_post.SQL_param = param[5]
		ping_post.parent_category = param[6]
		add_child(ping_post)
		
		# print("list: ",id_message,"--",param)


	
	if id_message == "product_show":
		total_item_displayed += 1
		# print(id_message,total_item_displayed)

	if id_message == "view_mode":
		view_mode = int(get_node("/root/FuncApp").view_mode)
	#	print("XXXXXX ",id_message,param)

	if id_message == "set_process":
		set_process(1)

	if id_message == "set_process_off":
	#	set_process(0)
		pass
