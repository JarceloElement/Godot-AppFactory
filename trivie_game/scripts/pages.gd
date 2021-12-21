
extends Control

var current_dist_y = 0
var dist_x = 0
var current_dist_x = 0
var blok = 0

export var scene_ID = 1 # 
export var menu_active = 1
export var message_title = "Dashboard"
export var scene_title = "Dashboard"
export var windows_title = "Dashboard"
export var speed_menu = 10
var _title = ""

export var scn_back_btn = "no_exit"

var search = 0
var anima = -500
var speed = 80
var active = 0
var move = 0

var menu_pos = 0
var count_movement = 0





func _ready(): 

	add_to_group("main_reporte")
	add_to_group("click_awesome")
	add_to_group("open_close_menu")
	add_to_group("main")


	get_node("/root/FuncApp").scene_ID = scene_ID
#	get_node("/root/FuncApp").menu_tipo = 1 # categ por defecto en la escena
	get_node("/root/FuncApp").menu_hide = 1


	if has_node("Panel_menu"):
		get_node("Panel_menu/MarginContainer").hide()

	if menu_active != 1: # eliminar menu si no esta active
		if has_node("Panel_menu"):
			get_node("Panel_menu").queue_free()
		



		
	OS.set_window_title(windows_title) # titulo de la ventana de la aplicación en PC


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
	var size_list = get_node("/root/FuncApp").size_list
#	print("size_list: ",size_list)

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


		if pantalla.y < pantalla.x: # Horizontal

			if menu_active == 1:
				if has_node("Panel_menu"):
					get_node("Panel_menu/MarginContainer").set_size(Vector2(X_p/2,pantalla.y-(size_y_top+size_y_down+80)))

			if size_list == 100: # no editando
				size_list = pantalla.y-157
			if size_list != 100: # editando
				size_list = size_list+100 # pantalla.y-360 # se resta el numero solo para telefono

		#	print("size_list Horiz ",size_list)

			if has_node("Viewer"):
				get_node("Viewer").set_size(Vector2(X_p,size_list))
				get_node("Viewer").set_position(Vector2(0,120)) 

			get_node("/root/FuncApp").responsive_size = Vector2(X_p,size_list)
			get_node("/root/FuncApp").responsive_pos = Vector2(0,120)
			

			if has_node("Number_picker") and has_node("Viewer"):
				get_node("Number_picker").set_size(Vector2(get_node("Viewer").get_size()))
				get_node("Number_picker").set_position(Vector2(get_node("Viewer").get_position())) 

			if has_node("Background_form"):
				get_node("Background_form").set_margin(0,0)
				get_node("Background_form").set_margin(2,0)

			if has_node("PopUp_contact"):
				get_node("PopUp_contact/MarginContainer").set_size(Vector2(get_node("Panel_menu/MarginContainer").get_size()))
				get_node("PopUp_contact/MarginContainer").set_position(Vector2(get_node("Panel_menu/MarginContainer").get_position())) 




		if pantalla.y > pantalla.x: # Vertical

			if menu_active == 1:
				if has_node("Panel_menu"):
					if X_p <= 600:
						get_node("Panel_menu/MarginContainer").set_size(Vector2(X_p,pantalla.y-(size_y_top+size_y_down+80)))
					if X_p > 600:
						get_node("Panel_menu/MarginContainer").set_size(Vector2(X_p/2,pantalla.y-(size_y_top+size_y_down+80)))
		
			if size_list == 100: # no editando
				size_list = pantalla.y-120
			if size_list != 100: # editando
				size_list = size_list # pantalla.y-500 # se resta el numero solo para telefono
				pass

		#	print("size_list Vert:",size_list)
			if has_node("Viewer"):
				get_node("Viewer").set_size(Vector2(X_p,size_list))

				
			#	get_node("Viewer").set_position(Vector2(0,120)) 
			get_node("/root/FuncApp").responsive_size = Vector2(X_p,size_list)
			get_node("/root/FuncApp").responsive_pos = Vector2(0,120)

			if has_node("Number_picker")  and has_node("Viewer"):
				get_node("Number_picker").set_size(Vector2(get_node("Viewer").get_size()))
				get_node("Number_picker").set_position(Vector2(get_node("Viewer").get_position())) 

			if has_node("Background_form"):
					get_node("Background_form").set_margin(0,0)
					get_node("Background_form").set_margin(2,0)

			if has_node("PopUp_contact"):
				get_node("PopUp_contact/MarginContainer").set_size(Vector2(get_node("Viewer").get_size()))
				get_node("PopUp_contact/MarginContainer").set_position(Vector2(get_node("Viewer").get_position())) 



		if has_node("Preview") and has_node("Viewer"):
			get_node("Preview").set_size(Vector2(get_node("Viewer").get_size().x,get_node("Preview").get_size().y))
			get_node("Preview").set_position(Vector2(get_node("Viewer").get_position().x,get_node("Preview").get_position().y)) 

		if has_node("PopUp_list"):
			get_node("PopUp_list/MarginContainer").set_size(Vector2(get_node("Panel_menu/MarginContainer").get_size().x,get_node("Panel_menu/MarginContainer").get_size().y-get_node("Panel_menu/MarginContainer/VBoxContainer/Menu_conf").get_size().y))
			get_node("PopUp_list/MarginContainer").set_position(Vector2(get_node("Panel_menu/MarginContainer").get_position())) 

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

			if menu_active == 1:
				if has_node("Panel_menu"):
					if X_p <= 600:
						get_node("Panel_menu/MarginContainer").set_size(Vector2(X_p,pantalla.y-(size_y_top+size_y_down+80)))
					if X_p > 600:
						get_node("Panel_menu/MarginContainer").set_size(Vector2(X_p/2,pantalla.y-(size_y_top+size_y_down+80)))

			
			if has_node("Viewer"):
				get_node("Viewer").set_margin(0,0)
				get_node("Viewer").set_margin(2,0)
			
			if has_node("Scroll_container"):
				get_node("Scroll_container").set_margin(0,0)
				get_node("Scroll_container").set_margin(2,0)


			if has_node("Number_picker") and has_node("Viewer"):
				get_node("Number_picker").set_size(Vector2(get_node("Viewer").get_size()))
				get_node("Number_picker").set_position(Vector2(get_node("Viewer").get_position())) 
				

			if has_node("Background_form"):
				get_node("Background_form").set_margin(0,0)
				get_node("Background_form").set_margin(2,0)


			if has_node("PopUp_contact"):
				get_node("PopUp_contact/MarginContainer").set_size(Vector2(get_node("Viewer").get_size()))
				get_node("PopUp_contact/MarginContainer").set_position(Vector2(get_node("Viewer").get_position())) 


		if pantalla.y < pantalla.x: # Horizontal

			size_list = pantalla.y-157

			if menu_active == 1:
				if has_node("Panel_menu"):
					get_node("Panel_menu/MarginContainer").set_size(Vector2(X_p/2,pantalla.y-(size_y_top+size_y_down+80)))

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
				
			
				
		if has_node("Preview") and has_node("Viewer"):
			get_node("Preview").set_size(Vector2(get_node("Viewer").get_size().x,get_node("Preview").get_size().y))
			get_node("Preview").set_position(Vector2(get_node("Viewer").get_position().x,get_node("Preview").get_position().y)) 

#		if has_node("PopUp_list"):
#			get_node("PopUp_list/MarginContainer").set_size(Vector2(get_node("Panel_menu/MarginContainer").get_size().x,get_node("Panel_menu/MarginContainer").get_size().y-get_node("Panel_menu/MarginContainer/VBoxContainer/Menu_conf").get_size().y))
#			get_node("PopUp_list/MarginContainer").set_position(Vector2(get_node("Panel_menu/MarginContainer").get_position())) 



		# dimension y pos para hacer responsive cualquier nodo
		get_node("/root/FuncApp").screen_size = Vector2(pantalla)
		if has_node("Viewer"):
			get_node("/root/FuncApp").responsive_size = Vector2(get_node("Viewer").get_size().x,size_list)
			get_node("/root/FuncApp").responsive_pos = Vector2(get_node("Viewer").get_position()) 
		elif has_node("Scroll_container"):
			get_node("/root/FuncApp").responsive_size = Vector2(get_node("Scroll_container").get_size().x,size_list)
			get_node("/root/FuncApp").responsive_pos = Vector2(get_node("Scroll_container").get_position()) 

	# fin tananyo PC






	# animar menu al cerrar y abrir
	if menu_active == 1:
		count_movement = get_node("/root/SliderControl").count_movement

		# ----- margen izq maximo para deslizar menu slider-------
		if current_dist_x < -1 and dist_x < 100 and get_node("/root/FuncApp").anime_menu == 0: # abre
			move = 1

			
		# desliza menu manual
		if count_movement > 0 and count_movement <= pantalla.x and move == 1 and get_node("/root/FuncApp").preview_active == 0: # abrir
			# print(get_node("/root/FuncApp").anime_menu)

			if has_node("Panel_menu"):
				if get_node("Panel_menu/MarginContainer").get_position().x < 0: 
					anima = int((-get_node("Panel_menu/MarginContainer").get_position().x)/speed_menu)+1  
					menu_pos = count_movement

					if has_node("Top_menu"):
						if pantalla.y > pantalla.x: # Vertical
							if X_p <= 600:
								get_node("Panel_menu/MarginContainer").set_position(Vector2(count_movement-pantalla.x,80+get_node("Top_menu/CanvasLayer").get_size().y)) 
							if X_p > 600:
								get_node("Panel_menu/MarginContainer").set_position(Vector2(count_movement-pantalla.x/2,80+get_node("Top_menu/CanvasLayer").get_size().y)) 
						
						if pantalla.y < pantalla.x: # Horizontal
							get_node("Panel_menu/MarginContainer").set_position(Vector2(count_movement-pantalla.x/2,80+get_node("Top_menu/CanvasLayer").get_size().y)) 
					
						# limite de menu abierto
						if get_node("Panel_menu/MarginContainer").get_position().x > 0: 
							get_node("Panel_menu/MarginContainer").set_position(Vector2(0,80+get_node("Top_menu/CanvasLayer").get_size().y)) 


					else:
						if pantalla.y > pantalla.x: # Vertical sin top_menu
							if X_p <= 600:
								get_node("Panel_menu/MarginContainer").set_position(Vector2(count_movement-pantalla.x,80)) 
							if X_p > 600:
								get_node("Panel_menu/MarginContainer").set_position(Vector2(count_movement-pantalla.x/2,80)) 
						
						if pantalla.y < pantalla.x: # Horizontal
							get_node("Panel_menu/MarginContainer").set_position(Vector2(count_movement-pantalla.x/2,80)) 

						# limite de menu abierto
						if get_node("Panel_menu/MarginContainer").get_position().x > 0: 
							get_node("Panel_menu/MarginContainer").set_position(Vector2(0,80)) 

					# get_node("Panel_menu/MarginContainer").show()


		if get_node("/root/SliderControl").relative_input == "x" and count_movement < 0 and get_node("/root/FuncApp").anime_menu == 1: # cerrar manual
			anima = (count_movement)
			menu_pos = count_movement
			
			if has_node("Top_menu"):
				get_node("Panel_menu/MarginContainer").set_position(Vector2(anima,80+get_node("Top_menu/CanvasLayer").get_size().y)) 
			
			else:
				get_node("Panel_menu/MarginContainer").set_position(Vector2(anima,80)) 

		# fin desliza menu manual






		

		# ------ ABRE Y CIERRA MENU IZQUIERDO------
		if get_node("/root/FuncApp").anime_menu == 0 and count_movement == 0: # anima cerrar menu con btn
			move = 0
			
			if anima > -600:
				if has_node("Panel_menu"):
					speed = int((-get_node("Panel_menu/MarginContainer").get_position().x)) # mov_fundido 
				anima += -int(speed+20) # aqui retoma la posicion al soltar el slider manual

			if has_node("Panel_menu"):
				if has_node("Top_menu"):
					get_node("Panel_menu/MarginContainer").set_position(Vector2(anima,80+get_node("Top_menu/CanvasLayer").get_size().y)) 
				
				else:
					get_node("Panel_menu/MarginContainer").set_position(Vector2(anima,80)) 

					

		if get_node("/root/FuncApp").anime_menu == 1 and count_movement == 0: # anima abrir menu con btn
			if has_node("Panel_menu"):
				if get_node("Panel_menu/MarginContainer").get_position().x < 0: 
					speed = int((-get_node("Panel_menu/MarginContainer").get_position().x)/speed_menu)+1 # mov_fundido 
					anima += int(speed)

			if has_node("Top_menu"):
				if has_node("Panel_menu"):
					get_node("Panel_menu/MarginContainer").set_position(Vector2(anima,80+get_node("Top_menu/CanvasLayer").get_size().y)) 
					
					if get_node("Panel_menu/MarginContainer").get_position().x > 0: 
						get_node("Panel_menu/MarginContainer").set_position(Vector2(0,80+get_node("Top_menu/CanvasLayer").get_size().y)) 
				
			else:
				if has_node("Panel_menu"):
					get_node("Panel_menu/MarginContainer").set_position(Vector2(anima,80)) 
					
					if get_node("Panel_menu/MarginContainer").get_position().x > 0: 
						get_node("Panel_menu/MarginContainer").set_position(Vector2(0,80)) 

#			print("menu_pos: ",get_node("/root/FuncApp").anime_menu)
		# fin animar menu al cerrar y abrir



			

		# mensaje de estado del menu abierto | cerrado
		if pantalla.y > pantalla.x: # Vertical
			# open
			if count_movement == 0 and menu_pos+100 > pantalla.x/2 and menu_pos != 0 and X_p <= 600:
				menu_pos = 0
				active = 1
				get_node("/root/FuncApp").anime_menu = 1
				get_node("/root/FuncApp").menu_hide = 0
				for i2 in get_tree().get_nodes_in_group("click_awesome"):
					i2.click_awesome("change_toggle","open")

			if count_movement == 0 and menu_pos+200 > pantalla.x/2 and menu_pos != 0 and X_p > 600:
				menu_pos = 0
				active = 1
				get_node("/root/FuncApp").anime_menu = 1
				get_node("/root/FuncApp").menu_hide = 0
				for i3 in get_tree().get_nodes_in_group("click_awesome"):
					i3.click_awesome("change_toggle","open")

			# close
			if count_movement == 0 and -menu_pos+100 > pantalla.x/2 and menu_pos != 0 and X_p <= 600:
				menu_pos = 0
				active = 0
				get_node("/root/FuncApp").anime_menu = 0
				get_node("/root/FuncApp").menu_hide = 1
				for i4 in get_tree().get_nodes_in_group("click_awesome"):
					i4.click_awesome("change_toggle","close")
				# print(active)
			
			if count_movement == 0 and -menu_pos+200 > pantalla.x/2 and menu_pos != 0 and X_p > 600:
				menu_pos = 0
				active = 0
				get_node("/root/FuncApp").anime_menu = 0
				get_node("/root/FuncApp").menu_hide = 1
				for i5 in get_tree().get_nodes_in_group("click_awesome"):
					i5.click_awesome("change_toggle","close")
				# print(active)




		if pantalla.y < pantalla.x: # Horizontal
			# open
			if count_movement == 0 and menu_pos+100 > pantalla.x/4 and menu_pos != 0 and X_p <= 600:
				menu_pos = 0
				active = 1
				get_node("/root/FuncApp").anime_menu = 1
				get_node("/root/FuncApp").menu_hide = 0
				for i6 in get_tree().get_nodes_in_group("click_awesome"):
					i6.click_awesome("change_toggle","open")

			if count_movement == 0 and menu_pos+200 > pantalla.x/4 and menu_pos != 0 and X_p > 600:
				menu_pos = 0
				active = 1
				get_node("/root/FuncApp").anime_menu = 1
				get_node("/root/FuncApp").menu_hide = 0
				for i7 in get_tree().get_nodes_in_group("click_awesome"):
					i7.click_awesome("change_toggle","open")


			# close
			if count_movement == 0 and -menu_pos+100 > pantalla.x/4 and menu_pos != 0 and X_p <= 600:
				menu_pos = 0
				active = 0
				get_node("/root/FuncApp").anime_menu = 0
				get_node("/root/FuncApp").menu_hide = 1
				for i8 in get_tree().get_nodes_in_group("click_awesome"):
					i8.click_awesome("change_toggle","close")
				# print(active)
			
			if count_movement == 0 and -menu_pos+200 > pantalla.x/4 and menu_pos != 0 and X_p > 600:
				menu_pos = 0
				active = 0
				get_node("/root/FuncApp").anime_menu = 0
				get_node("/root/FuncApp").menu_hide = 1
				for i9 in get_tree().get_nodes_in_group("click_awesome"):
					i9.click_awesome("change_toggle","close")
				# print(active)

		# print(current_dist_x," Pxx ",dist_x)
		


	else:

		if menu_active == 0:
			# --- MENSAJE AWESOME ---
			# oculta el boton de menu en top_bar
			for ia in get_tree().get_nodes_in_group("click_awesome"):
				ia.click_awesome("top_bar_volver","0")
			# ----------------------------------------------
	
	


	# hide menu al cerrar | la DB solo carga cuando menu esta hide
	if has_node("Panel_menu"):

		# ----- margen izq maximo para deslizar menu slider-------
		# if current_dist_x < -1 and dist_x < 100:
		if get_node("Panel_menu/MarginContainer").get_position().x <= -400: 
			get_node("Panel_menu/MarginContainer").hide()
			get_node("/root/FuncApp").menu_hide = 1
		else:
			get_node("Panel_menu/MarginContainer").show()
			get_node("/root/FuncApp").menu_hide = 0



	# print(get_node("Panel_menu/MarginContainer").is_visible(),get_node("Panel_menu/MarginContainer").get_position().x) 




# ------  volver atras con boton del movil
	get_tree().set_auto_accept_quit(0)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		print("menu_hide: ",get_node("/root/FuncApp").menu_hide)

		if get_node("/root/FuncApp").popup_list == 0 and get_node("/root/FuncApp").number_pick_is_visible == 0 and get_node("/root/FuncApp").popup_tools_city == 0 and get_node("/root/FuncApp").popup_active == 0 and get_node("/root/FuncApp").menu_hide == 1 and get_node("/root/FuncApp").preview_active == 0 and get_node("/root/FuncApp").popup_login == 0: # menu oculto
			
			if scn_back_btn != "exit":
				get_node("/root/FuncApp").DB_control_priority = 1
				if get_node("/root/Loading").array_scn_loaded.size() > 1:
					var last_scn = get_node("/root/Loading").array_scn_loaded.back()
					Loading.goto_scene(last_scn,"in")
					
				# print(get_node("/root/Loading").array_scn_loaded.size())
				elif get_node("/root/Loading").array_scn_loaded.size() == 1:
					# quit_confirm
					get_tree().quit()
					
				get_node("/root/FuncApp").Request_status = 0
				get_node("/root/FuncApp").mov_slider = 0

			if scn_back_btn == "exit":
				get_tree().quit()

		elif get_node("/root/FuncApp").menu_hide == 0 and get_node("/root/FuncApp").popup_list == 0: # menu visible
			open_menu()
			pass
		

		if get_node("/root/FuncApp").preview_active == 1 and get_node("/root/FuncApp").PopUp_contact_var == 0:
			var mensajes = get_tree().get_nodes_in_group("click_awesome")
			for i in mensajes:
				i.click_awesome("product","hide")
		
		if get_node("/root/FuncApp").popup_tools_city == 1 and get_node("/root/FuncApp").PopUp_contact_var == 0:
			var mensajes = get_tree().get_nodes_in_group("click_awesome")
			for i in mensajes:
				i.click_awesome("tools_hide","from_page")
				
				
		if get_node("/root/FuncApp").PopUp_contact_var == 1:
			var mensajes = get_tree().get_nodes_in_group("click_awesome")
			for i in mensajes:
				i.click_awesome("popup_contact_close","from_page")

		if get_node("/root/FuncApp").popup_list == 1:
			var mensajes = get_tree().get_nodes_in_group("click_awesome")
			for i in mensajes:
				i.click_awesome("popup_list_queue_free_from_page","from_page")
				i.click_awesome("popup_options_queue_free_from_page","")

		if get_node("/root/FuncApp").popup_login == 1:
			var mensajes = get_tree().get_nodes_in_group("click_awesome")
			for i in mensajes:
				i.click_awesome("popup_login_close","from_page")

		if get_node("/root/FuncApp").popup_active == 1:
			var mensajes = get_tree().get_nodes_in_group("click_awesome")
			for i in mensajes:
				i.click_awesome("popup_close","from_page")

		if get_node("/root/FuncApp").popup_login == 1: # editando form | sale de edicion
			for i in get_tree().get_nodes_in_group("campos_form"):
				i.click_awesome("edit_off_WM_QUIT_REQUEST","field_form")

		if get_node("/root/FuncApp").number_pick_is_visible == 1:
			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("number_pick_aceptar","from_page")

# -----------------------------------------




func open_menu(): # con boton, abre y cierra slider

	# print("open_menu(): menu_hide: ",get_node("/root/FuncApp").menu_hide)
	if has_node("Panel_menu"):

		if get_node("/root/FuncApp").menu_hide == 0:
			get_node("/root/FuncApp").anime_menu = 0
			active = 1
			get_node("/root/FuncApp").menu_hide = 1

			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("change_toggle","open")

			get_node("Panel_menu/MarginContainer").show()
		#	print("search: ",search)
			
		elif get_node("/root/FuncApp").menu_hide == 1:
			get_node("/root/FuncApp").anime_menu = 1
			active = 0
			get_node("/root/FuncApp").menu_hide = 0

			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("change_toggle","close")

			# get_node("Panel_menu/MarginContainer").hide()
	#		print("search: ",search)








	

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
	


	"""
	elif get_node("boton_abajo/VBoxContainer/HBoxContainer_inicio/MarginContainer4/Button").get_text() == "Continuar":
		get_node("Form").show()
		get_node("fondo blanco/VBoxContainer").hide()
		get_node("boton_abajo/VBoxContainer/HBoxContainer_inicio/MarginContainer4/Button").set_text("Registrar")
		# limpiar campos
		get_node("/root/FuncApp").array_form = []

		var mensajes = get_tree().get_nodes_in_group("limpiar_campos")
		for i in mensajes:
			i.limpiar_campos() # va a los campos del formulario
	"""



func aviso_campo_vacio(): # lo envia campo_form si no esta completo el form
#	get_node("Viewer").show()
	get_node("/root/FuncApp").array_form = [] # limpia el array para ue no vuelva agregar los datos en el form
	





func click_awesome(id_mensaje,param):

	if id_mensaje == "exit":
		get_tree().quit()

	if id_mensaje == "btn_menu":
		open_menu()
		pass

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

