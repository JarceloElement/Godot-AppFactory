extends CanvasLayer

export var title = "contact"
export var title_btn_L = "_accept"
export var title_btn_R = "_cancel"
export var message_btn_L = "set_message_L"
export var message_btn_R = "set_message_R"
export var message_param_L = ""
export var message_param_R = ""
export var confirm_to_group = ""
export var only_accept = 0


func _ready():
	add_to_group("click_awesome")
	get_node("/root/FuncApp").PopUp_contact_var = 1

	get_node("back_close/Button").connect("pressed",self,"_queue_free")

	
	get_node("MarginContainer/MarginContainer").modulate.a = 0 

#	print("message_param_L ",message_param_L)
	# mensajes de los botones L y R
	get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/button_border_L").ID_message = message_btn_L
	get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/button_border_L").message_param = message_param_L
#	get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/Button_round").ID_message = message_btn_L
#	get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/Button_round").message_param = message_param_L
#	get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/Button_round1").ID_message = message_btn_R
#	get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/Button_round1").message_param = message_param_R

	if get_node("/root/Messages").get(title):
		get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/Title/Label").set_text(get_node("/root/Messages").get(title))
	else:
		get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/Title/Label").set_text(title)
	
	if only_accept == 1:
		get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer").queue_free()

		
#	if has_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/Button_round/HBoxContainer/title_margin/title"):
#		get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/Button_round/HBoxContainer/title_margin/title").set_text(str(get_node("/root/Messages").get(title_btn_L)))
#		get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/Button_round/HBoxContainer/title_margin/title").show()
#
	if title_btn_L == "":
#		get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/Button_round").queue_free()
		get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/button_border_L").queue_free()
	else:
		get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/button_border_L/Button").text = get_node("/root/Messages").get(title_btn_L)

	if title_btn_R == "":
#		get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/Button_round1").queue_free()
		get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/button_border_R").queue_free()
	else:
		get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/button_border_R/Button").text = get_node("/root/Messages").get(title_btn_R)
	
#	if has_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/Button_round1"):
#		get_node("MarginContainer/MarginContainer/Buttons/VBoxContainer/HBoxContainer1/Button_round1/HBoxContainer/title_margin/title").set_text(str(get_node("/root/Messages").get(title_btn_R)))



func click_awesome(id_mensaje,param):
	
	if id_mensaje == "popup_contact_close":
		get_node("/root/FuncApp").PopUp_contact_var = 0
		queue_free()
		
	if id_mensaje == "user_delete":
		var ping = get_node("/root/FuncApp").get("HTTPRequest_form").instance() # add new
		ping.form_request_type = "user_delete"
		add_child(ping)


#func _process(delta):
#	print(get_node("MarginContainer").get_position()) 
#	pass
	
	
func _queue_free():
	get_node("/root/FuncApp").PopUp_contact_var = 0
	queue_free()
	


#func _send_confirmation(event):
#	if event is InputEventMouseButton: 
#		if event.pressed:
#			for i in get_tree().get_nodes_in_group("Slider_control"):
#				i.slider_pos_global = 0
#		if !event.pressed:
#			if get_node("/root/SliderControl").slider_pos_global < 5:
#				for i in get_tree().get_nodes_in_group(confirm_to_group):
#					i.popup_confirmation()
#					_queue_free()


func _on_Button_pressed():
	for i in get_tree().get_nodes_in_group(confirm_to_group):
		i.popup_confirmation()
		_queue_free()
	
	pass # Replace with function body.
