extends MarginContainer

export var pag_icono = "circle"
export var pag_icono_size = 20
export var pag_icono_color = Color("999999")
export var pag_icon_active_color = Color("ed1a73")
export var show_parallax = 1
export (StreamTexture) var background_parallax

func _ready():
	add_to_group("slider_view")

	get_node("ParallaxBackground/nav_btn/MarginContainer/VBoxContainer/MarginContainer1/Paginacion").icono = pag_icono
	get_node("ParallaxBackground/nav_btn/MarginContainer/VBoxContainer/MarginContainer1/Paginacion").icono_size = pag_icono_size
	get_node("ParallaxBackground/nav_btn/MarginContainer/VBoxContainer/MarginContainer1/Paginacion").icono_color = pag_icono_color

	if show_parallax == 0:
		get_node("ParallaxBackground/ParallaxBackground").queue_free()
		
	if has_node("ParallaxBackground/ParallaxBackground/ParallaxLayer/Texture_parallax"): 
		if background_parallax:
			get_node("ParallaxBackground/ParallaxBackground/ParallaxLayer/Texture_parallax").set_texture(background_parallax)


		
		
	
	set_process(1)
	pass
	
func _process(delta):
	var N_slider = get_node("ParallaxBackground/VBoxContainer/Items").get_child_count()
	var screen = get_viewport_rect().size
	set_size(Vector2(screen.x*N_slider,get_size().y))
	
	if has_node("ParallaxBackground/ParallaxBackground/ParallaxLayer/Texture_parallax"): 
		get_node("ParallaxBackground/ParallaxBackground/ParallaxLayer/Texture_parallax").set_size(Vector2(screen.x*(N_slider+2),get_size().y)) 
		get_node("ParallaxBackground/ParallaxBackground/ParallaxLayer/Texture_parallax").set_position(Vector2(-screen.x,get_position().y)) 

	if get_owner().has_node("Down_container"):
		if get_owner().get_node("Boton_abajo/MarginContainer").is_visible():
			if has_node("ParallaxBackground"):
				get_node("ParallaxBackground/nav_btn/MarginContainer/VBoxContainer/MarginContainer1").set("custom_constants/margin_bottom",30)
	
	
	
	# --- MENSAJE AWESOME ---
	for i in get_tree().get_nodes_in_group("click_awesome"):
		i.click_awesome("color_icon_activo",pag_icon_active_color)
	# ----------------------------------------------


