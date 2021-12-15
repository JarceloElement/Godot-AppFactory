tool
extends MarginContainer

export var font_color = Color("d2d2d2") setget _set_font_color


func _set_font_color(n_color):
	font_color = n_color
	if is_inside_tree():
		get_node("VBoxContainer/Label_dinamic").Title_color = font_color
		
func _ready():
	add_to_group("alert")
	add_to_group("click_awesome")
	
	hide()
	get_node("VBoxContainer/Label_dinamic").set_text("Alert msg")


func click_awesome(id_message,param):
	# (Format) param = [] (string from, [string, icon,icon_color,font_color])
#	print("ALERT: ",id_message)
	if id_message == "alert_hide":
		hide()
	if id_message == "alert_show":
		show()
		
		if param.size() >= 2:
			if param[1] != "":
				get_node("VBoxContainer/Label_dinamic").set_text(str(param[1]))
		if param.size() > 2:
			if param[2] != "":
				get_node("VBoxContainer/icon/FontAwesome")._set_icon(param[2])
		if param.size() > 3:
			if param[3] != "":
				get_node("VBoxContainer/icon/FontAwesome").set("custom_colors/font_color",param[3])
		if param.size() > 4:
			if param[4] != "":
				get_node("VBoxContainer/Label_dinamic").set("custom_colors/font_color",param[4])
		
	
	
	if id_message == "alert_add_request_instance":
		show()

		# print("ALERT_ADD_REQUEST_INSTANCE: ",param)

		var instance = get_node("/root/FuncApp").HTTPRequest_form.instance()
		instance.request_button_param = param[0] # asigna param del boton que envia la solicitud
		instance.form_request_type = param[1] # asigna al form_request el tipo de solicitud: signin, signup, etc
		get_node("VBoxContainer").add_child(instance)


	


func _on_Alert_gui_input(event):
	if event is InputEventMouseButton: 
		if event.pressed:
			get_node("/root/SliderControl").slider_pos_global = 1
		if !event.pressed:
			if get_node("/root/SliderControl").slider_pos_global > -5 and get_node("/root/SliderControl").slider_pos_global < 5:
				hide()
#			print("alert input")
