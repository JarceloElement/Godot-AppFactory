extends MarginContainer


var popup_form_active = 0
var scroll_pos_y = 0.0
var scroll_pulso = 1
var pos_scroll_y = 0
var mov_refresh = 0




func _ready():

	set_process(1)
	set_process_input(true)

	add_to_group("Form")
	add_to_group("focus_scroll")
	add_to_group("Form_viewer")
	add_to_group("click_awesome")
	get_node("ScrollContainer").add_to_group("ScrollContainer_lista")
	get_node("ScrollContainer").add_to_group("scroll_form")

#	set_theme(get_node("/root/FuncApp").tema_awesome)
#	set_theme(get_node("/root/FuncApp").theme_city_tools)


	scroll_pos_y = get_node("ScrollContainer").get_position().y 



#--------slider arriba y abajo---------
func _input(event):

	if event is InputEventScreenDrag: 

		# ----- mover scroll container al tope y final----
		if get_node("/root/SliderControl").relative_input == "y":
			
			# lista atras
			if get_node("/root/FuncApp").scroll_top_end == 0 or get_node("/root/FuncApp").scroll_top_end == 100:
				if get_node("ScrollContainer").get_position().y < 60 and get_node("/root/SliderControl").rel_y > 0: 
					pos_scroll_y += get_node("/root/SliderControl").rel_y
					mov_refresh = 1

				if get_node("ScrollContainer").get_position().y > 0 and get_node("/root/SliderControl").rel_y < 0: 
					pos_scroll_y += get_node("/root/SliderControl").rel_y
					mov_refresh = 1


			# lista adelante
			if get_node("/root/FuncApp").scroll_top_end == 100 and pos_scroll_y <= 0:
				if get_node("ScrollContainer").get_position().y > -60 and get_node("/root/SliderControl").rel_y < 0: 
					pos_scroll_y += get_node("/root/SliderControl").rel_y
					mov_refresh = 2

				if get_node("ScrollContainer").get_position().y < 0 and get_node("/root/SliderControl").rel_y > 0: 
					pos_scroll_y += get_node("/root/SliderControl").rel_y
					mov_refresh = 2

			# mover lista
			get_node("ScrollContainer").set_position(Vector2(get_node("ScrollContainer").get_position().x,pos_scroll_y/20)) 

			# print(get_node("/root/FuncApp").scroll_top_end,pos_scroll_y)



			if get_node("/root/SliderControl").rel_y > 0 and get_node("ScrollContainer").get_v_scroll()==0 and (get_node("/root/FuncApp").scroll_top_end == 0 or get_node("/root/FuncApp").scroll_top_end == 100):
				# ocultar icono refresh
				for i in get_tree().get_nodes_in_group("click_awesome"):
					i.click_awesome("pos_scroll_y_top","show")

			if get_node("/root/FuncApp").scroll_top_end == 1:
				# ocultar icono refresh
				for i in get_tree().get_nodes_in_group("click_awesome"):
					i.click_awesome("pos_scroll_y_top","hide")


			if get_node("ScrollContainer").get_position().y > 0 and pos_scroll_y < 150: 
				# ocultar icono refresh
				for i in get_tree().get_nodes_in_group("click_awesome"):
					i.click_awesome("pos_scroll_y_top","show")


			# print(get_node("/root/FuncApp").scroll_top_end," | ",pos_scroll_y)
			# print(get_node("ScrollContainer").get_position().y) 
				

			# lista atras
			if mov_refresh == 1:
				# anima el boton de refresh
				for i in get_tree().get_nodes_in_group("click_awesome"):
					i.click_awesome("pos_scroll_y_top",str(pos_scroll_y))


			# lista adelante
			if mov_refresh == 2:
				# anima el boton de refresh
				for i in get_tree().get_nodes_in_group("click_awesome"):
					i.click_awesome("pos_scroll_y_down",str(pos_scroll_y))


	if event is InputEventScreenTouch: 

		if !event.pressed:
			# ACTIVAR PAGINACION
			if get_node("ScrollContainer").get_position().y >= 10 and get_node("/root/FuncApp").preview_active == 0: 
				get_node("ScrollContainer/List").page_back ()
				scroll_pulso = 0
				
			if get_node("ScrollContainer").get_position().y <= -10 and get_node("/root/FuncApp").preview_active == 0: 
				get_node("ScrollContainer/List").page_forward()
				scroll_pulso = 0

			# ----- VOLVER scroll container al sitio----
			# BAJAR
			if get_node("/root/FuncApp").scroll_top_end == 0 and get_node("/root/SliderControl").y_posi == 0:
				get_node("ScrollContainer").set_position(Vector2(get_node("ScrollContainer").get_position().x,scroll_pos_y)) 
				scroll_pulso = 1
			# SUBE
			if get_node("/root/FuncApp").scroll_top_end == 100 and get_node("/root/SliderControl").y_posi == 0:
				get_node("ScrollContainer").set_position(Vector2(get_node("ScrollContainer").get_position().x,scroll_pos_y)) 
				scroll_pulso = 1
			# ------------------------------------------
	
			pos_scroll_y = 0
			get_node("ScrollContainer").set_position(Vector2(get_node("ScrollContainer").get_position().x,pos_scroll_y/20)) 

			# ocultar icono
			if pos_scroll_y == 0:
				# anima el boton de refresh
				for i in get_tree().get_nodes_in_group("click_awesome"):
					i.click_awesome("pos_scroll_y_all",str(pos_scroll_y))
	# print(mov_refresh," | ",get_owner().get_node("Form_viewer").get_size().y)








func _process(delta):
	
# 	if has_node("ScrollContainer/List/Label"):
# #			$ScrollContainer/List/Label.set_text(get_node("/root/FuncApp").path_data)
# 		$ScrollContainer/List/Label.set_text("get_virtual_keyboard_height: "+str(OS.get_virtual_keyboard_height()))

	#---- POSICION DEL SCROLL ------
	if get_node("ScrollContainer").get_v_scroll() == 0 and get_node("/root/FuncApp").scroll_top_end != 0: # top
		get_node("/root/FuncApp").scroll_top_end = 0

		var _go_top_button = get_tree().get_nodes_in_group("_go_top_button")
		for i in _go_top_button:
			if i.button_enabled == 1:

				for e in get_tree().get_nodes_in_group("click_awesome"):
					e.click_awesome("btn","gotop_disable")
		
	
	if get_node("ScrollContainer").get_v_scroll() > 0 and get_node("/root/FuncApp").scroll_top_end != 1: # no top, no fin
		if get_node("ScrollContainer").get_size().y < get_node("ScrollContainer/List").get_end().y:
			get_node("/root/FuncApp").scroll_top_end = 1

			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("btn","gotop_enable")
		
		
	# fin
	if get_node("ScrollContainer").get_size().y >= get_node("ScrollContainer/List").get_end().y and get_node("/root/FuncApp").scroll_top_end != 100:
		get_node("/root/FuncApp").scroll_top_end = 100
		# pos_scroll_y = 0
	#---------------------------------------------------------------------------



func focus_scroll(): # lo envia el slider al arrastrar
	
	if get_node("/root/SliderControl").relative_input != "x" and get_node("/root/FuncApp").popup_list == 0 and get_node("/root/FuncApp").menu_hide == 1 and get_node("/root/FuncApp").preview_active == 0:
		get_node("ScrollContainer").grab_click_focus()
		# print(get_node("ScrollContainer").has_focus(),"grab_click_focus()-viewer.gd")
		pass
	

func click_awesome(id_message,message_text):
	if id_message == "btn" and message_text == "gotop":
		# get_node("ScrollContainer").set_v_scroll(0)
		pass


func _on_Area2D_area_enter( area ):
	get_node("/root/FuncApp").visible = int(area.get_parent().get_name()) # tipo de campo que se oculta
#	print("Area: ",area.get_parent().get_name())

