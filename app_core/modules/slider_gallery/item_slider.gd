tool
extends MarginContainer

export var back_color = Color8(255,255,255) setget _set_color

var color_r =255
var color_g = 255
var color_b = 255

var r = 0
var g = 0
var b = 0
var next_item_color = 0

var click_active = 0
var current_dist_x = 0
var count = 0
var pag = 0


func _set_color(n_color):
	back_color = n_color
	if is_inside_tree():
		$ColorRect.set_size(Vector2(get_viewport_rect().size))
		$ColorRect.color = back_color
		$ColorRect.show()
		
func _ready():
	
	add_to_group("click_awesome")


	
	$ColorRect.hide()
#	set_process(1)

#	print(get_position_in_parent())
#	color_r = float(color_r)/255
#	color_g = float(color_g)/255
#	color_b = float(color_b)/255
	
	color_r = back_color[0]
	color_g = back_color[1]
	color_b = back_color[2]
#	print(color)
	
	r = back_color[0]
	g = back_color[1]
	b = back_color[2]
#	VisualServer.set_default_clear_color(Color(r,g,b,1.0)) # color de fondo


func _process(delta):
#	var N_slider = get_parent().get_child_count()
#	var pantalla = get_viewport_rect().size
#	set_size(Vector2(pantalla.x,get_size().y))
	
#	set_custom_minimum_size(Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y))

	pass
	

func click_awesome(id_message,param):
	

		
	if id_message == "paginacion":
		pag = int(param)
#		print(id_mensaje,param)
#	var mensajes = get_tree().get_nodes_in_group("Slider_control")
#	for i in mensajes:
	var control_s = $"/root/SliderControl"
	click_active = control_s.click_active
	current_dist_x = control_s.current_dist_x
	count = control_s.rel_x
		
#	print(get_position_in_parent()+1," -- ",pag)

		

	if count > 0: # atras
		for i in get_tree().get_nodes_in_group("slider_view"):
			if pag > 1 and id_message == "paginacion_color_back":
				next_item_color = i.get_node("ParallaxBackground/VBoxContainer/Items").get_child(int(pag-2))
	
				if get_position_in_parent()+1 == pag and id_message == "paginacion_color_back":
					if color_r < next_item_color.color_r and r < next_item_color.color_r:
						r = color_r-param
					if color_g < next_item_color.color_g and g < next_item_color.color_g:
						g = color_g-param
					if color_b < next_item_color.color_b and b < next_item_color.color_b:
						b = color_b-param
					VisualServer.set_default_clear_color(Color(r,g,b,1.0)) # color de fondo
					
					if color_r > next_item_color.color_r and r > next_item_color.color_r:
						r = color_r+param
					if color_g > next_item_color.color_g and g > next_item_color.color_g:
						g = color_g+param
					if color_b > next_item_color.color_b and b > next_item_color.color_b:
						b = color_b+param
					VisualServer.set_default_clear_color(Color(r,g,b,1.0)) # color de fondo
						
			#	print(r," -- ",next_item_color.color_r)
			#	print(get_position_in_parent()+1," -- ",pag)
			
	if count < 0: # adelante
		for i in get_tree().get_nodes_in_group("slider_view"):
			if pag == i.get_node("ParallaxBackground/VBoxContainer/Items").get_child_count():
				next_item_color = i.get_node("ParallaxBackground/VBoxContainer/Items").get_child(int(pag-1))
			if pag < i.get_node("ParallaxBackground/VBoxContainer/Items").get_child_count():
				next_item_color = i.get_node("ParallaxBackground/VBoxContainer/Items").get_child(int(pag))
				

		if get_position_in_parent()+1 == pag and id_message == "paginacion_color_back":
			if color_r < next_item_color.color_r and r < next_item_color.color_r:
				r = color_r+param
			if color_g < next_item_color.color_g and g < next_item_color.color_g:
				g = color_g+param
			if color_b < next_item_color.color_b and b < next_item_color.color_b:
				b = color_b+param
			VisualServer.set_default_clear_color(Color(r,g,b,1.0)) # color de fondo
				
			if color_r > next_item_color.color_r and r > next_item_color.color_r:
				r = color_r-param
			if color_g > next_item_color.color_g and g > next_item_color.color_g:
				g = color_g-param
			if color_b > next_item_color.color_b and b > next_item_color.color_b:
				b = color_b-param
			VisualServer.set_default_clear_color(Color(r,g,b,1.0)) # color de fondo
			
#		print(r," -- ",next_item_color.color_r)
	#	print(get_position_in_parent()+1," -- ",pag)
		
		
		
	if get_position_in_parent()+1 == pag and click_active == 0:

#	if click_activo == 0:
		r = color_r
		g = color_g
		b = color_b
		VisualServer.set_default_clear_color(Color(r,g,b,1.0)) # color de fondo
		

#		print((r))



		

		
		
