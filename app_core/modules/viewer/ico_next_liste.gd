extends MarginContainer

export var icon_pos = 1
export var icon_refresh = "refresh"
export var icon_color = "6dadff"
export var icon_size = 40
var Form_viewer_size = 0


func _ready():
	add_to_group("click_awesome")
	
	get_node("FontAwesome")._set_icon(icon_refresh)
	get_node("FontAwesome").set("custom_colors/font_color",icon_color)
	get_node("FontAwesome")._set_size(icon_size)

	get_node("FontAwesome").hide()


func click_awesome(id_message,param):
	
#	print(id_message)
	
	if id_message == "pos_scroll_y_top":
		if icon_pos == 1:
			var float_var = float(param)/20 #get_owner().get_node("Slider_control").float_y/200
#			print(float_var)
			
			get_node("FontAwesome").set_rotation(-float_var)
			set_position(Vector2(get_position().x,int(param)/2)) 
			
			if get_position().y < 20: 
				get_node("FontAwesome").hide()
	
			if param == "show":
			# if get_position().y >= 10: 
				get_node("FontAwesome").show()

			if param == "hide":
				get_node("FontAwesome").hide()

			# print(get_position().y) 

	if id_message == "pos_scroll_y_down":
		if icon_pos == 2:

			var float_var = float(param)/40
			var mensajes = get_tree().get_nodes_in_group("Form_viewer")
			for i in mensajes:
				Form_viewer_size = i.get_size()

			get_node("FontAwesome").set_rotation(float_var)
			set_position(Vector2(get_position().x,(Form_viewer_size.y/2)+int(param)/2)) 
	
			if get_position().y > (Form_viewer_size.y/2)-12: 
				get_node("FontAwesome").hide()
			else:
				get_node("FontAwesome").show()
				
			# print(get_position().y," | ",(Form_viewer_size.y/2)-5) 

	if id_message == "pos_scroll_y_all":
	#	if icon_pos == 1:
			var float_var = float(param)/10 #get_owner().get_node("Slider_control").float_y/200
			get_node("FontAwesome").set_rotation(-float_var)
			set_position(Vector2(get_position().x,int(param)*2)) 

			if get_position().y < 15: 
				get_node("FontAwesome").hide()
			else:
				get_node("FontAwesome").show()



	# print(param)
	# print(get_position().y) 
		
	# print(get_position()," | ",get_owner().get_node("Form_viewer").get_size().y/2) 
		
		
		
