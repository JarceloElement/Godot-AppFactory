extends Control

var current_dist_y = 0
var dist_x = 0
var current_dist_x = 0
var blok = 0

export var scene_ID = 1 # 
export var menu_active = bool(1)
export var message_title = "Dashboard"
export var scene_title = "Dashboard"
export var windows_title = "Dashboard"
var _title = ""

export var scn_back_btn = "no_exit"

var size_list = 100




func _ready(): 
	
#	print(OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS))
	
	add_to_group("click_awesome")
	add_to_group("open_close_menu")
	add_to_group("main")


	get_node("/root/FuncApp").scene_ID = scene_ID
	# get_node("/root/FuncApp").menu_tipo = 1 # categ por defecto en la escena
	get_node("/root/FuncApp").menu_hide = 1

	# print("menu_hide: ",get_node("/root/FuncApp").menu_hide)



	if menu_active == false: # eliminar menu si no esta active
		if has_node("Panel_menu"):
			get_node("Panel_menu").queue_free()
		



		
	OS.set_window_title(windows_title) # titulo de la ventana de la aplicación en PC

	if scene_title == "member_title" and get_node("/root/Global").TEMP_REGISTER_MEMBER_PARAM.has("name_boss"):
		scene_title = get_node("/root/Messages").get("member_title") % get_node("/root/Global").TEMP_REGISTER_MEMBER_PARAM["name_boss"]
	
	# -- MENSAJE AL TITULO DE LA VENTANA ---
	if get_node("/root/Messages").get(message_title) != null:
		scene_title = get_node("/root/Messages").get(message_title)
		
	elif message_title == "":
		scene_title = scene_title
		
	for i in get_tree().get_nodes_in_group("click_awesome"):
		i.click_awesome("title",[scene_title])





	set_process(1)










func _process(delta):
	
	var slider_control = get_node("/root/SliderControl")
	current_dist_y = slider_control.current_dist_y
	current_dist_x = slider_control.current_dist_x
	dist_x = slider_control.dist_x
	blok = slider_control.blok


	var pantalla = get_viewport_rect().size
	var X_p = get_viewport_rect().size.x

		# virtual keyboard
	if OS.has_virtual_keyboard() == true:
#		OS.show_virtual_keyboard("",false)
		size_list = OS.get_virtual_keyboard_height()
#		print("get_virtual_keyboard_height: ",size_list)



	# ------- escala form al editar en Android -----------
	if OS.get_name() == "Android":
		var size_y_top = 0
		var size_y_down = 0

		if has_node("Down_container"):
			if get_node("Down_container/MarginContainer").is_visible():
				size_y_down += get_node("Down_container/MarginContainer").get_size().y

		if has_node("Top_menu"):
			if get_node("Top_menu/CanvasLayer").is_visible():
				size_y_top += get_node("Top_menu/CanvasLayer").get_size().y

		var virtual_keyboard_height = size_list+(size_y_top+200) # size_list se asigna en viewer


		if pantalla.y < pantalla.x: # Horizontal

			# if menu_active == true: # eliminar menu si no esta active
			# 	if has_node("Panel_menu"):
			# 		get_node("Panel_menu/MarginContainer").set_size(Vector2(X_p/2,pantalla.y))

			if OS.get_virtual_keyboard_height() == 0: # no editando
				size_list = pantalla.y-210
			if OS.get_virtual_keyboard_height() > 0: # editando
				size_list = pantalla.y-virtual_keyboard_height # se resta el numero solo para telefono

		#	print("size_list Horiz ",size_list)

			if has_node("Viewer"):
				get_node("Viewer").set_size(Vector2(X_p,size_list))
				get_node("Viewer").set_position(Vector2(0,120)) 

			get_node("/root/FuncApp").responsive_size = Vector2(X_p,size_list)
			get_node("/root/FuncApp").responsive_pos = Vector2(0,120)
			




		if pantalla.y > pantalla.x: # Vertical

			# if menu_active == true: # eliminar menu si no esta active
			# 	if has_node("Panel_menu"):
			# 		if X_p <= 600:
			# 			get_node("Panel_menu/MarginContainer").set_size(Vector2(X_p,pantalla.y))
			# 		if X_p > 600:
			# 			get_node("Panel_menu/MarginContainer").set_size(Vector2(X_p/2,pantalla.y))
		
			if OS.get_virtual_keyboard_height() == 0: # no editando
				size_list = pantalla.y-200
			if OS.get_virtual_keyboard_height() > 0: # editando
				size_list = pantalla.y-virtual_keyboard_height # se resta el numero solo para telefono

		#	print("size_list Vert:",size_list)
			if has_node("Viewer"):
				get_node("Viewer").set_size(Vector2(X_p,size_list))

			get_node("/root/FuncApp").responsive_size = Vector2(X_p,size_list)
			get_node("/root/FuncApp").responsive_pos = Vector2(0,120)


		if has_node("Panel_menu/MarginContainer"):
			get_node("/root/FuncApp").responsive_pos = Vector2(get_node("Panel_menu/MarginContainer").get_position()) 
	
	# ------- fin escala form al editar-----------
	
	# fin tamanyo Android




	# tamanyo menu segun pantalla en PC
	if OS.get_name() != "Android":
		var size_y_top = 0
		var size_y_down = 0

		if has_node("Down_container"):
			if get_node("Down_container/MarginContainer").is_visible():
				size_y_down += get_node("Down_container/MarginContainer").get_size().y

		if has_node("Top_menu"):
			if get_node("Top_menu/CanvasLayer").is_visible():
				size_y_top += get_node("Top_menu/CanvasLayer").get_size().y


		if pantalla.y > pantalla.x: # Vertical

			size_list = pantalla.y-120

			if menu_active == true: # eliminar menu si no esta active
				if has_node("Panel_menu"):
					if X_p <= 600:
						get_node("Panel_menu/MarginContainer").set_size(Vector2(X_p,pantalla.y))
					if X_p > 600:
						get_node("Panel_menu/MarginContainer").set_size(Vector2(X_p/2,pantalla.y))

			
			if has_node("Viewer"):
				get_node("Viewer").set_margin(0,0)
				get_node("Viewer").set_margin(2,0)
			
			if has_node("Scroll_container"):
				get_node("Scroll_container").set_margin(0,0)
				get_node("Scroll_container").set_margin(2,0)

			if has_node("Background_form"):
				get_node("Background_form").set_margin(0,0)
				get_node("Background_form").set_margin(2,0)

			if has_node("PopUp_contact"):
				get_node("PopUp_contact/MarginContainer").set_size(Vector2(get_node("Viewer").get_size()))
				get_node("PopUp_contact/MarginContainer").set_position(Vector2(get_node("Viewer").get_position())) 
			
			

		if pantalla.y < pantalla.x: # Horizontal

			size_list = pantalla.y-157

			if menu_active == true: # eliminar menu si no esta active
				if has_node("Panel_menu"):
					get_node("Panel_menu/MarginContainer").set_size(Vector2(X_p/2,pantalla.y))

			if has_node("Viewer"):
				get_node("Viewer").set_margin(0,X_p/8)
				get_node("Viewer").set_margin(2,-X_p/8)
			
			if has_node("Scroll_container"):
				get_node("Scroll_container").set_margin(0,X_p/8)
				get_node("Scroll_container").set_margin(2,-X_p/8)

			if has_node("Number_picker") and has_node("Viewer"):
				get_node("Number_picker").set_size(Vector2(get_node("Viewer").get_size()))
				get_node("Number_picker").set_position(Vector2(get_node("Viewer").get_position())) 

			if has_node("Background_form"):
				get_node("Background_form").set_margin(0,X_p/8)
				get_node("Background_form").set_margin(2,-X_p/8)

			if has_node("PopUp_contact"):
				get_node("PopUp_contact/MarginContainer").set_size(Vector2(get_node("Viewer").get_size()))
				get_node("PopUp_contact/MarginContainer").set_position(Vector2(get_node("Viewer").get_position())) 


		# dimension y pos para hacer responsive cualquier nodo
		get_node("/root/FuncApp").screen_size = Vector2(pantalla)
		if has_node("Viewer"):
			get_node("/root/FuncApp").responsive_size = Vector2(get_node("Viewer").get_size().x,size_list)
			get_node("/root/FuncApp").responsive_pos = Vector2(get_node("Viewer").get_position()) 
		elif has_node("Scroll_container"):
			get_node("/root/FuncApp").responsive_size = Vector2(get_node("Scroll_container").get_size().x,size_list)
			get_node("/root/FuncApp").responsive_pos = Vector2(get_node("Scroll_container").get_position()) 

	# fin tananyo PC






	# if menu_active == false: # eliminar menu si no esta active
	# 	# --- MENSAJE AWESOME ---
	# 	# oculta el boton de menu en top_bar
	# 	for ia in get_tree().get_nodes_in_group("click_awesome"):
	# 		ia.click_awesome("top_bar_volver","0")
	# 	# ----------------------------------------------








# ------  volver atras con boton del movil
	get_tree().set_auto_accept_quit(0)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST or what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		# print("menu_hide: ",get_node("/root/FuncApp").menu_hide)
		if get_node("/root/FuncApp").popup_list == 0 and get_node("/root/FuncApp").number_pick_is_visible == 0 and get_node("/root/FuncApp").popup_active == 0 and get_node("/root/FuncApp").menu_hide == 1 and get_node("/root/FuncApp").preview_active == 0 and get_node("/root/FuncApp").popup_login == 0: # menu oculto
			if scn_back_btn != "exit":
				get_node("/root/FuncApp").DB_control_priority = 1
				if get_node("/root/Loading").array_scn_loaded.size() > 1:
				
					var last_scn = get_node("/root/Loading").array_scn_loaded.back()
					# print("WM_QUIT_REQUEST - last_scn: ",last_scn)
					Loading.goto_scene(last_scn,"in")
					
				# print(get_node("/root/Loading").array_scn_loaded.size())
				elif get_node("/root/Loading").array_scn_loaded.size() == 1:
					# quit_confirm
					get_tree().quit()
					
				get_node("/root/FuncApp").Request_status = 0
				get_node("/root/FuncApp").mov_slider = 0

			if scn_back_btn == "exit":
				get_tree().quit()



		if get_node("/root/FuncApp").menu_hide == 0 and get_node("/root/FuncApp").popup_list == 0: # menu visible
			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("btn_menu","")

#		if get_node("/root/FuncApp").preview_active == 1 and get_node("/root/FuncApp").PopUp_contact_var == 0:
#			for i in get_tree().get_nodes_in_group("click_awesome"):
#				i.click_awesome("product","hide")
#
#		if get_node("/root/FuncApp").popup_tools_city == 1 and get_node("/root/FuncApp").PopUp_contact_var == 0:
#			for i in get_tree().get_nodes_in_group("click_awesome"):
#				i.click_awesome("tools_hide","from_page")
#
#		if get_node("/root/FuncApp").PopUp_contact_var == 1:
#			for i in get_tree().get_nodes_in_group("click_awesome"):
#				i.click_awesome("popup_contact_close","from_page")

		if get_node("/root/FuncApp").popup_list == 1:
			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("popup_list_queue_free_from_page","from_page")
				i.click_awesome("popup_options_queue_free_from_page","")

		if get_node("/root/FuncApp").popup_login == 1:
			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("popup_login_close","from_page")

		if get_node("/root/FuncApp").popup_active == 1:
			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("popup_close","from_page")

		if get_node("/root/FuncApp").popup_login == 1: # editando form | sale de edicion
			for i in get_tree().get_nodes_in_group("campos_form"):
				i.click_awesome("edit_off_WM_QUIT_REQUEST","field_form")

		if get_node("/root/FuncApp").number_pick_is_visible == 1:
			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("number_pick_aceptar","from_page")

# -----------------------------------------









	

func _cerrar_edicion():
	if has_node("Form_post"):
		get_node("Form_post/ScrollContainer").set_v_scroll(0)

	pass









func request_form():
#	print("ZZZ")
	
	for i in get_tree().get_nodes_in_group("_enviar_registros"):
		i._enviar_registros() # va a los campos del formulario

	# --- MENSAJE AWESOME ---
	for i in get_tree().get_nodes_in_group("click_awesome"):
		i.click_awesome("hide_message","")
	# ----------------------------------------------
	
	# agrega el http de registro del formulario
	var ping = get_node("/root/FuncApp").HTTPRequest_form.instance()
	add_child(ping)
	






func aviso_campo_vacio(): # lo envia campo_form si no esta completo el form
#	get_node("Viewer").show()
	get_node("/root/FuncApp").array_form = [] # limpia el array para ue no vuelva agregar los datos en el form
	





func click_awesome(id_mensaje,param):

	if id_mensaje == "exit":
		get_tree().quit()



	if id_mensaje == "_enviar_registros":
		request_form()

		#----||| HACER BOTON CON ICONO AWESOME O LABEL |||-------	
		for i in get_tree().get_nodes_in_group("click_awesome"):
			i.click_awesome("number_pick","_cerrar_edicion")


	if id_mensaje == "add_preview":
		var ping = get_node("/root/FuncApp").get("product_preview").instance()
		ping.set_name(str(param))
		add_child(ping)

	if id_mensaje == "_search_btn_menu_open":
		get_node("Top_bar/CanvasLayer").hide()
		
		if !has_node("Top_search_bar"):
			var ping = get_node("/root/FuncApp").get("Top_search_bar").instance()
			add_child(ping)
		else:
			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("_close_search","")
				get_node("Top_bar/CanvasLayer").show()
		
	if id_mensaje == "_search_btn_menu_close":
		get_node("Top_bar/CanvasLayer").show()


	if id_mensaje == "add_popup_contact":
		var ping = get_node("/root/FuncApp").get("PopUp_contact").instance()
		add_child(ping)
		



	if id_mensaje == "add_popup_list": # el type de popup se pasa en el param de cada boton | configurar type de botones en: PopUp_list_item_add > ready

		if has_node("PopUp_list") and get_node("PopUp_list").type != param: # quit all diferent
			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("popup_list_queue_free_from_page",param)
			get_node("/root/FuncApp").popup_list = 0

			yield(get_tree(), "idle_frame") # espera un frame antes de agregar el nuevo popup
			yield(get_tree(), "idle_frame") # espera un frame antes de agregar el nuevo popup

			var ping = get_node("/root/FuncApp").get("PopUp_list").instance() # add new
			ping.type = param
			add_child(ping)


		elif has_node("PopUp_list") and get_node("PopUp_list").type == param: # quit if exist
			get_node("PopUp_list").type = param.queue_free()
			get_node("/root/FuncApp").popup_list = 0

		# add if not exist
		else:
			var ping = get_node("/root/FuncApp").get("PopUp_list").instance()
			ping.type = param
			add_child(ping)
	

	if id_mensaje == "add_popup_login":
		var ping = get_node("/root/FuncApp").get("PopUp_login").instance() # add new
		ping.title = param[1]
		add_child(ping)
		
		
		
		
		
	if id_mensaje == "add_signin": # el type de popup se pasa en el param de cada boton | configurar type de botones en: PopUp_list_item_add > ready
			var ping = get_node("/root/FuncApp").get("PopUp_signin").instance() # add new
			# ping.type = param
			add_child(ping)
			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("add_popup","hide")
				
	if id_mensaje == "add_signup": # el type de popup se pasa en el param de cada boton | configurar type de botones en: PopUp_list_item_add > ready
		var ping = get_node("/root/FuncApp").get("PopUp_signup").instance() # add new
		# ping.type = param
		add_child(ping)
		for i in get_tree().get_nodes_in_group("click_awesome"):
			i.click_awesome("add_popup","hide")
			
	if id_mensaje == "add_pass_forget": # el type de popup se pasa en el param de cada boton | configurar type de botones en: PopUp_list_item_add > ready
		var ping = get_node("/root/FuncApp").get("PopUp_pass_recovery").instance() # add new
		# ping.type = param
		add_child(ping)
		for i in get_tree().get_nodes_in_group("click_awesome"):
			i.click_awesome("add_popup","hide")

	if id_mensaje == "user_edit":
		var ping = get_node("/root/FuncApp").get("PopUp_user_edit").instance() # add new
		add_child(ping)

		for i in get_tree().get_nodes_in_group("click_awesome"):
			i.click_awesome("add_popup","hide")
			
	if id_mensaje == "add_user_delete":
		var ping = get_node("/root/FuncApp").get("PopUp_contact").instance() # add new
		ping.title = "delete_user"
		ping.title_btn_L = "_accept"
		ping.message_btn_L = "user_delete"
		ping.only_accept = 1
		add_child(ping)




	if id_mensaje == "signout":
		get_node("/root/FuncApp").SESSION = []
		

		
#	print(id_mensaje,param)

