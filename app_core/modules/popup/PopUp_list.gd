extends CanvasLayer

var time = Timer

var id_field = 1
var title_field = ""
export var type = "popup_name"
export var options = ["A","B","C","D","E","A","B","C","D","E","A","B","C","D","E"]

var option_btn = preload("res://app_core/modules/popup/Options_btn.tscn")


# COMO AGREGAR POPUP OPTIONS
#var ping = PopUp_options.instance()
#ping.id_field = id
#ping.options = field_options
#get_node("../../../../").add_child(ping)


func _ready():
	add_to_group("click_awesome")
	get_node("/root/FuncApp").popup_list = 1
	
#	set_process(1)
	
	time = $Timer
	time.connect("timeout",self,"timeout")
	$AnimationP.play("in")
	
	$options_list/ScrollContainer/Menu_Item/title_field.set_text(title_field)
	$options_list/ScrollContainer/Menu_Item/title_field.set("custom_colors/font_color",get_node("/root/FuncApp").color_option_field_head)
	
	
	if options.size() > 0:
		_add_options()

func click_awesome(id_mensaje,param):
	if id_mensaje == "popup_list_queue_free_from_page":
		get_node("/root/FuncApp").popup_list = 0
		queue_free()
		
	if id_mensaje == "option_popup_queufree":
		get_node("/root/FuncApp").popup_list = 0
		queue_free()
		
	if id_mensaje == "popup_options_queue_free_from_page":
		var param_2 = [id_field,options[0],"from_option_list"]
		for msg in get_tree().get_nodes_in_group("click_awesome"):
			msg.click_awesome("option_popup_add_data",param_2)
			queue_free()


func _add_options():
	for opt in options:
		var ping = option_btn.instance()
		ping.option_text = opt
		ping.id_field = id_field
		ping.set("custom_colors/font_color",get_node("/root/FuncApp").color_option_field_body)
		$options_list/ScrollContainer/Menu_Item.add_child(ping)
	pass


func _process(delta):
	if get_node("/root/FuncApp").responsive_size != Vector2(0,0):
		$Panel_round.set_size(Vector2(get_node("/root/FuncApp").responsive_size.x,$Panel_round.get_size().y))
		$options_list.set_size(Vector2(get_node("/root/FuncApp").responsive_size.x,$options_list.get_size().y))
		$Panel_round.set_position(Vector2(get_node("/root/FuncApp").responsive_pos.x,$Panel_round.get_position().y)) 
		$options_list.set_position(Vector2(get_node("/root/FuncApp").responsive_pos.x,$options_list.get_position().y)) 
		pass
	
	# escalar lista de opciones segun la cantidad
	var size_y = 0
	for option in $options_list/ScrollContainer/Menu_Item.get_child_count():
		if size_y < $options_list.get_size().y:
			size_y += ($options_list/ScrollContainer/Menu_Item.get_child(option).rect_size.y+2)
			$Panel_round.set_size(Vector2($Panel_round.get_size().x,size_y))
		
		else:
			$Panel_round.set_size(Vector2($Panel_round.get_size().x,$options_list.get_size().y))


# quitar popup al presionar afuera
func _on_PanelContainer_gui_input(event):
	if event is InputEventMouseButton: 
		if !event.pressed:
			$AnimationP.play("out")
			time.set_wait_time(0.30)
			time.start()
#			yield(get_tree(),"idle_frame")

func timeout():
	var param = [id_field,options[0],"from_option_list"]
	for msg in get_tree().get_nodes_in_group("click_awesome"):
		msg.click_awesome("option_popup_add_data",param)
		get_node("/root/FuncApp").popup_list = 0
		queue_free()
				
				
				
