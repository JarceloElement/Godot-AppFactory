extends MarginContainer

var id = 1
var title = "Title"
export var field_name = "text"
export var type = "text"
export var field_options = Array(["A","B","C"])
export var icon = "user"
export var _visible = bool(1)
export var is_null = bool(1)
export var placeholder_text = "Text"
export var secret_character = ""
export var default_value = "null"
export var corner_radius_top = int(2)
export var corner_radius_bottom = int(2)
export var anti_aliasing = bool(1)
export var anti_aliasing_size = int(1)
export var line_color_normal = Color("005eff")
export var line_color_edit = Color("ec0064")
export var font_size = 24
export  (DynamicFontData) var font
	
var text_theme = Theme

onready var field_path = $LineEdit
var data_field = ""

var PopUp_options = preload("res://app_core/modules/popup/PopUp_options.tscn")






func _ready():
	add_to_group("click_awesome")
	add_to_group("clear_form_field")
	add_to_group("form_field")

	id = int(get_name())
	# print(id)
	connect("gui_input",self,"_field_edit")
	$LineEdit.connect("focus_exited",self,"_focus_exited")
	
	text_theme = get_node("/root/FuncApp").text_theme
	var title_font = DynamicFont.new()
	title_font.font_data = font #load("res://app_core/fonts_preload/DroidSans.ttf")
	title_font.size = font_size
	title_font.extra_spacing_top = 10
	text_theme.set("LineEdit/fonts/font",title_font)
	
	# FOCUS STYLE
	text_theme.get("LineEdit/styles/focus/StyleBoxFlat:1216").corner_radius_top_left = corner_radius_top
	text_theme.get("LineEdit/styles/focus/StyleBoxFlat:1216").corner_radius_top_right = corner_radius_top
	text_theme.get("LineEdit/styles/focus/StyleBoxFlat:1216").corner_radius_bottom_right = corner_radius_bottom
	text_theme.get("LineEdit/styles/focus/StyleBoxFlat:1216").corner_radius_bottom_left = corner_radius_bottom
	text_theme.get("LineEdit/styles/focus").anti_aliasing = anti_aliasing
	text_theme.get("LineEdit/styles/focus").anti_aliasing_size = anti_aliasing_size
	
	# NORMAL STYLE
	text_theme.get("LineEdit/styles/normal/StyleBoxFlat:1217").corner_radius_top_left = corner_radius_top
	text_theme.get("LineEdit/styles/normal/StyleBoxFlat:1217").corner_radius_top_right = corner_radius_top
	text_theme.get("LineEdit/styles/normal/StyleBoxFlat:1217").corner_radius_bottom_right = corner_radius_bottom
	text_theme.get("LineEdit/styles/normal/StyleBoxFlat:1217").corner_radius_bottom_left = corner_radius_bottom
	text_theme.get("LineEdit/styles/normal").anti_aliasing = anti_aliasing
	text_theme.get("LineEdit/styles/normal").anti_aliasing_size = anti_aliasing_size
	
	# READ ONLY STYLE
	text_theme.get("LineEdit/styles/read_only/StyleBoxFlat:1218").corner_radius_top_left = corner_radius_top
	text_theme.get("LineEdit/styles/read_only/StyleBoxFlat:1218").corner_radius_top_right = corner_radius_top
	text_theme.get("LineEdit/styles/read_only/StyleBoxFlat:1218").corner_radius_bottom_right = corner_radius_bottom
	text_theme.get("LineEdit/styles/read_only/StyleBoxFlat:1218").corner_radius_bottom_left = corner_radius_bottom
	text_theme.get("LineEdit/styles/read_only").anti_aliasing = anti_aliasing
	text_theme.get("LineEdit/styles/read_only").anti_aliasing_size = anti_aliasing_size

	# LINE CORNER
	$MarginContainer/color_bg.get("custom_styles/panel/StyleBox:1309").corner_radius_top_left = corner_radius_top
	$MarginContainer/color_bg.get("custom_styles/panel/StyleBox:1309").corner_radius_top_right = corner_radius_top
	$MarginContainer/color_bg.get("custom_styles/panel/StyleBox:1309").corner_radius_bottom_right = corner_radius_bottom+2
	$MarginContainer/color_bg.get("custom_styles/panel/StyleBox:1309").corner_radius_bottom_left = corner_radius_bottom+2
	
	# LINE COLOR
#	text_theme.get("PanelContainer/styles/panel").bg_color = line_color
	$MarginContainer/color_bg.modulate = line_color_normal
	$LineEdit.placeholder_text = placeholder_text
	$LineEdit.set_theme(text_theme)
	
	$Title/title.set_text(title)
	if int(_visible) == 0:
		hide()
		pass
#	print(is_null)
	
	if type != "password":
		$HBoxContainer/Button_icon.hide()
		
	if secret_character != "":
		$LineEdit.secret = true
		$LineEdit.secret_character = secret_character
#	print($MarginContainer/color_bg.get("custom_styles/panel/StyleBox:1309"))
	pass


func _focus_exited():
	$LineEdit.mouse_filter = 2
	mouse_filter = 1
	
	$MarginContainer/color_bg.modulate = line_color_normal
	




func _field_edit( ev ):
	if ev is InputEventMouseButton:
		if ev.pressed:
			get_node("/root/SliderControl").slider_pos_global = 1
			get_node("/root/FuncApp").active_field = id
		#	print("Click")
		
		if !ev.pressed:
			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("set_process","from_campo_form")

			if get_node("/root/SliderControl").slider_pos_global > -3 and get_node("/root/SliderControl").slider_pos_global < 3:
#				print("Click: ",title)
				mouse_filter = 2
				$LineEdit.mouse_filter = 0
				$LineEdit.grab_focus()
				
				if get_node("/root/FuncApp").active_field == id:
					
					
					if int(_visible) == 1:
						$MarginContainer/color_bg.modulate = line_color_edit
#						print(id,get_node("/root/FuncApp").active_field)
						
						if field_options.size() != 0 and type == "option":
							$LineEdit.virtual_keyboard_enabled = false
							OS.hide_virtual_keyboard()

							
							var ping = PopUp_options.instance()
							ping.id_field = id
							ping.title_field = title
							ping.options = field_options
							get_node("../../../../").add_child(ping)
							
#					elif int(_visible) == 0:
##						click_awesome("focus_next",[id,"field_hide_next"])
#						if id == get_node("/root/FuncApp").active_field: # busca el campo siguiente
#							get_node("/root/FuncApp").active_field += 1 # activa siguiente campo
#							_field_edit_from_message()
#						print(id,get_node("/root/FuncApp").active_field)
						
#						print("set_option ID: ",id)
				
				else:
					$MarginContainer/color_bg.modulate = line_color_normal
		


func _form_send(button_param): # RECOGE LOS TIPOS DE DATOS | del boton de enviar

	data_field = str(field_path.get_text())
	
	# CREA LA LISTA CON LOS DATOS DEL FORM
	
	# SI TIENE DATOS EL CAMPO
	if (data_field != "" or int(is_null) == 1) and get_node("/root/FuncApp").next_field_form == int(get_name()): 
		if int(get_name()) < get_node("/root/FuncApp").Total_list_field:
			get_node("/root/FuncApp").array_form.append(name+"="+data_field.replace(" ","+").replace("\n","+")+"&")
			get_node("/root/FuncApp").array_field_name.append(field_name)
			get_node("/root/FuncApp").array_field_data.append(data_field)
			get_node("/root/FuncApp").FORM_DATA[field_name] = data_field
			if data_field == "":
				data_field = default_value
			get_node("/root/FuncApp").post_request_dicc[field_name] = data_field


		if int(get_name()) >= get_node("/root/FuncApp").Total_list_field:
			get_node("/root/FuncApp").array_form.append(name+"="+data_field.replace(" ","+").replace("\n","+"))
			get_node("/root/FuncApp").array_field_name.append(field_name)
			get_node("/root/FuncApp").array_field_data.append(data_field)
			get_node("/root/FuncApp").FORM_DATA[field_name] = data_field
			if data_field == "":
				data_field = default_value
			get_node("/root/FuncApp").post_request_dicc[field_name] = data_field

		get_node("/root/FuncApp").next_field_form += 1

	#	print("form= ",get_node("/root/FuncApp").array_form," -- ",get_owner().get_name())

	# SI NO TIENE DATOS EL CAMPO
	elif (data_field == "" or int(is_null) == 0) and get_node("/root/FuncApp").is_empty_field == 0 and get_node("/root/FuncApp").next_field_form == int(get_name()):
	#	print(get_node("/root/FuncApp").is_empty_field)

		get_node("/root/FuncApp").is_empty_field = 1
		get_node("/root/FuncApp").next_field_form = 1
		get_node("/root/FuncApp").array_form = []
		get_node("/root/FuncApp").array_field_name = []
		get_node("/root/FuncApp").array_field_data = []
		get_node("/root/FuncApp").post_request_dicc = {}
		get_node("/root/FuncApp").FORM_DATA = {}
	
		var param = ["form_add_alert_empty_field",str(get_node("/root/Messages").get("_empty_form_field"))+'"'+placeholder_text+'"',"warning","ff9500","2d2d2d"]
		var mensajes = get_tree().get_nodes_in_group("alert")
		for i in mensajes:
			i.click_awesome("alert_show",param)
		
		$MarginContainer/color_bg.modulate = line_color_edit

	# print("SIZE-ARRAY-FORM: ",get_node("/root/FuncApp").Total_list_field," | ",get_node("/root/FuncApp").array_form.size())
	
	# SI ESTA COMPLETO EL FORMULARIO
	if get_node("/root/FuncApp").Total_list_field == get_node("/root/FuncApp").array_form.size(): 
		# print("array_field_name: ",get_node("/root/FuncApp").array_field_name)
		var form_request_type = get_parent().form_request_type # tipo de request se coloca en list
		var param = [button_param,form_request_type]
		for i in get_tree().get_nodes_in_group("alert"):
			i.click_awesome("alert_add_request_instance",param)
			# print("ALERT_ADD_REQUEST_INSTANCE: ",param)

		get_node("/root/FuncApp").next_field_form = 1

		# print("SIZE-ARRAY-FORM: ",get_node("/root/FuncApp").Total_list_field," | ",get_node("/root/FuncApp").array_form.size())


func click_awesome(id_message,param):
	if id_message == "form_send" and get_node("/root/FuncApp").next_field_form == int(get_name()): # lo envia el boton de enviar
		get_node("/root/FuncApp").is_empty_field = 0
		_form_send(param)
		# print("field_form: form_send ",get_node("/root/FuncApp").next_field_form,get_name())

	if id_message == "show_password" and type == "password":
		if $LineEdit.secret == false:
			$LineEdit.secret = true
			$LineEdit.secret_character = secret_character
			$HBoxContainer/Button_icon/icon.set("custom_colors/font_color",get_node("/root/FuncApp").color_show_pass_icon_inact)
			
		elif $LineEdit.secret == true:
			$LineEdit.secret = false
			$LineEdit.secret_character = secret_character
			$HBoxContainer/Button_icon/icon.set("custom_colors/font_color",get_node("/root/FuncApp").color_show_pass_icon_act)
	
	
	if id_message == "focus_next": # busca el campo siguiente

		if id == param[0] and int(_visible) == 1: # campo activo
			$LineEdit.set_text(param[1]) # asigna la primera opcion al campo activo
			for msg in get_tree().get_nodes_in_group("click_awesome"):
				msg.click_awesome("option_popup_queufree","")
				
		if id == param[0]+1: # busca el campo siguiente
			get_node("/root/FuncApp").active_field = param[0]+1 # activa siguiente campo
			_field_edit_from_message()




	if id_message == "option_popup_add_data":
		
		if id == param[0]: # campo activo
			$LineEdit.set_text(param[1]) # asigna la primera opcion al campo activo
			
		
		if id == param[0]+1: # busca el campo siguiente
			get_node("/root/FuncApp").active_field = param[0]+1 # activa siguiente campo
#			_field_edit_from_message() # cambia los colores del campo
			

	if id_message == "add_popup_login":
		clear_form_field()






func set_option(param):
	if param[0] == id:
		$LineEdit.set_text(param[1])

			
func clear_form_field():
	field_path.set_text("")


func _field_edit_from_message():
		mouse_filter = 2
		$LineEdit.mouse_filter = 0
		$LineEdit.grab_focus()
		
		if get_node("/root/FuncApp").active_field == id:
			if int(_visible) == 1:
				$MarginContainer/color_bg.modulate = line_color_edit
				
				if field_options.size() != 0 and type == "option":
					$LineEdit.virtual_keyboard_enabled = false
					OS.hide_virtual_keyboard()
					
					var ping = PopUp_options.instance()
					ping.id_field = id
					ping.title_field = title
					ping.options = field_options
					get_node("../../../../").add_child(ping)
			
			elif int(_visible) == 0: # pasa al siguiente campo si el activo esta oculto
				for msg in get_tree().get_nodes_in_group("click_awesome"):
					msg.click_awesome("focus_next",[id,""])
		
		else:
			$MarginContainer/color_bg.modulate = line_color_normal
