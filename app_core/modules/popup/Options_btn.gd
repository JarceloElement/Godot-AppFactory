extends Label


var option_text = "Option"
export var id_field = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("gui_input",self,"_on_FontAwesome_gui_input")
	
	if id_field == 0:
		queue_free()
		
	set_text(option_text)
	pass



func _on_FontAwesome_gui_input( ev ):
	if ev is InputEventMouseButton: 
		var slider_pos_global = get_node("/root/SliderControl")

		if ev.pressed:
			for i in get_tree().get_nodes_in_group("Slider_control"):
				i.slider_pos_global = 0
		if !ev.pressed:
		
			if slider_pos_global.slider_pos_global < 5:
				var param = [id_field,get_text(),"from_option_list"]
				for i in get_tree().get_nodes_in_group("form_field"):
					i.set_option(param)
					
				for msg in get_tree().get_nodes_in_group("click_awesome"):
#					msg.click_awesome("popup_list_queue_free_from_page",param)
					msg.click_awesome("focus_next",param)
					msg.click_awesome("get_option",param)
				
				pass
