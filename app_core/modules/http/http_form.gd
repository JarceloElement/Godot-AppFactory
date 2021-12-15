extends HTTPRequest

var resultado = {}
var array = []





func _ready():

	array = get_node("/root/FuncApp").array_form
	# print("ARRAY: ",array.size()," Total_list_field: ",get_node("/root/FuncApp").Total_list_field)
	
	if get_node("/root/FuncApp").Total_list_field == array.size(): # si esta completo el formulario

		array = str(array).replace("[","").replace("]","").replace(" ","")
		request(str(get_node("/root/FuncApp").URL_POST)+"?ID="+str(get_node("/root/FuncApp").menu_tipo)+"&array_form="+str(array))
		
		connect("request_completed", self, "_on_HTTPRequest_request_completed")
	
		# --- MENSAJE AWESOME ---
		var param_msg = [get_node("/root/Messages").send_form_icon, get_node("/root/Messages").send_form]
		var mensajes = get_tree().get_nodes_in_group("click_awesome")
		for i in mensajes:
			i.click_awesome("message_request_form",param_msg)
			i.click_awesome("btn_send","cancelar")
			i.click_awesome("btn_requesting","1")
		# ----------------------------------------------




	else: # si no esta completo el formulario
		get_node("/root/FuncApp").array_form = []

		# --- MENSAJE AWESOME ---
		var param_msg = [get_node("/root/Messages").incomplete_form_icon, get_node("/root/Messages").incomplete_form]
		var mensajes = get_tree().get_nodes_in_group("click_awesome")
		for i in mensajes:
			i.click_awesome("message_request_form",param_msg)
			i.click_awesome("btn_send","continuar")
			i.click_awesome("btn_requesting","1")
		# ----------------------------------------------

		queue_free()






func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	if(result == HTTPRequest.RESULT_SUCCESS):
	#	print("response_code ",response_code)
		
		if response_code == 200:
		#	resultado.parse_json( body.get_string_from_ascii() )
		#	print (resultado)
			get_node("/root/FuncApp").array_form = []
			var mensajes = get_tree().get_nodes_in_group("limpiar_campos")
			for i in mensajes:
				i.limpiar_campos() # va a los campos del formulario

			# --- MENSAJE AWESOME ---
			var param_msg = [get_node("/root/Messages").send_form_complete_icon, get_node("/root/Messages").send_form_complete]
			var mensajes = get_tree().get_nodes_in_group("click_awesome")
			for i in mensajes:
				i.click_awesome("message_request_form",param_msg)
				i.click_awesome("btn_send","continuar")
				i.click_awesome("btn_requesting",str(response_code))
			# ----------------------------------------------
			
			print("response_code ",response_code)
			

		else:
			print("err_code ",response_code)
			# --- MENSAJE AWESOME ---
			var param_msg = [get_node("/root/Messages").send_form_request_no200_icon,
			get_node("/root/Messages").send_form_request_no200+str(response_code)]

			var mensajes = get_tree().get_nodes_in_group("click_awesome")
			for i in mensajes:
				i.click_awesome("message_request_form",param_msg)
				i.click_awesome("btn_send","continuar")
				i.click_awesome("btn_requesting",str(response_code))
			# ----------------------------------------------



	if(result == HTTPRequest.RESULT_CANT_CONNECT):
		print("err_code ",response_code)
		# --- MENSAJE AWESOME ---
		var param_msg = [get_node("/root/Messages").send_form_cant_connet,
		get_node("/root/Messages").send_form_cant_connet_icon+str(response_code)]

		var mensajes = get_tree().get_nodes_in_group("click_awesome")
		for i in mensajes:
			i.click_awesome("message_request_form",param_msg)
			i.click_awesome("btn_send","continuar")
			i.click_awesome("btn_requesting",str(response_code))
		# ----------------------------------------------


	queue_free()


func click_awesome(id_mensaje,mensaje_text):
	if id_mensaje == "_continuar":
		queue_free()

