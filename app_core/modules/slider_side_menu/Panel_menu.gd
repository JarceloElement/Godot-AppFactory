extends CanvasLayer

export var menu_bottom_conf = bool(0)
export var speed_menu = 10
export var size_x = 100

var menu_pos = 0
var count_movement = 0
var anima = -500
var speed = 80
var active = 0
var move = 0
var back_color = 0.0
onready var screen = get_node("MarginContainer").get_viewport_rect().size
onready var RayCast2D_W = RayCast2D.new()
onready var slider_control = get_node("/root/SliderControl")




func _ready():
	add_to_group("click_awesome")
	add_to_group("slider_click_release")
	
	if menu_bottom_conf == false:
		get_node("MarginContainer/VBoxContainer/Menu_conf").queue_free()

	set_process(true)

	# RayCast2D_W notifica el ancho del menu
	get_node("MarginContainer").add_child(RayCast2D_W)






func _process(delta):
	$ColorRect.color = Color(0,0,0,back_color)
	var menu = get_node("MarginContainer")

	# % menu size
	menu.set_size(Vector2(menu.get_size().x*size_x/100,menu.get_size().y))
	
	# closed limite
	RayCast2D_W.enabled = true
	RayCast2D_W.collide_with_areas = true
	RayCast2D_W.rotation_degrees = -90
	RayCast2D_W.cast_to.y = menu.get_size().x+5
	# print("RayCast2D_W: ",RayCast2D_W.is_colliding())
	
	# slider control
	var count_movement = slider_control.count_movement
	var current_dist_y = slider_control.current_dist_y
	var current_dist_x = slider_control.current_dist_x
	var dist_x = slider_control.dist_x
	var rel_x = slider_control.rel_x
	var relative_input = slider_control.relative_input


	# desliza menu manual
	# ----- margen izq minimo para deslizar menu slider-------
	if active == 0 and count_movement > 0 and current_dist_x < -1 and dist_x < 100 and get_node("/root/FuncApp").anime_menu == 0: # abre
		move = 1
	# ------

	# open
	if relative_input == "x" and count_movement > 0 and move == 1 and get_node("/root/FuncApp").preview_active == 0: # abrir
		menu_pos = -get_node("MarginContainer").get_position().x
		# print("open_movement: ",menu_pos," // ",count_movement-screen.x)

		if screen.x <= 600:
			get_node("MarginContainer").set_position(Vector2(count_movement-menu.get_size().x,0))
			# limite de menu abierto
			if get_node("MarginContainer").get_position().x > 0:
				get_node("MarginContainer").set_position(Vector2(-1,0)) 
				
		if screen.x > 600:
			get_node("MarginContainer").set_position(Vector2(count_movement-menu.get_size().x/2,0))  
			# limite de menu abierto
			if get_node("MarginContainer").get_position().x > 0:
				get_node("MarginContainer").set_position(Vector2(-1,0)) 

		# open
		if menu_pos <= menu.get_size().x/2 and menu_pos != 0:
			active = 1


		if back_color < 0.6:
			back_color += rel_x/500

	
	# close
	if relative_input == "x" and count_movement < 0 and RayCast2D_W.is_colliding() == true and get_node("/root/FuncApp").preview_active == 0: # abrir
		menu_pos = -get_node("MarginContainer").get_position().x
		# print("close movement: ",menu_pos," // ",speed)

		if screen.x <= 600:
			get_node("MarginContainer").set_position(Vector2(count_movement,0))  
		if screen.x > 600:
			get_node("MarginContainer").set_position(Vector2(menu.get_size().x/2-count_movement,0))  
	
		# close
		if menu_pos > menu.get_size().x/3 and menu_pos != 0:
			active = 0

		# limite de menu abierto
		if get_node("MarginContainer").get_position().x > 0:  
			get_node("MarginContainer").set_position(Vector2(-1,0))  


		if back_color > 0:
			back_color += rel_x/500

	# fin desliza menu manual






	# ------ ABRE Y CIERRA MENU | RELEASE ------
	# open
	if count_movement == 0 and  active == 1:
		move = 0
		if get_node("MarginContainer").get_position().x < 0:  
			speed = int(-(get_node("MarginContainer").get_position().x)/speed_menu)+1 # mov_fundido  
			anima = int(get_node("MarginContainer").get_position().x+speed)
			# print("anima: ",anima)
			
		if has_node("Top_menu"):
			get_node("MarginContainer").set_position(Vector2(anima,0))  

		else:
			get_node("MarginContainer").set_position(Vector2(anima,0))  

		if back_color < 0.6:
			back_color += 0.1

		if get_node("MarginContainer").get_position().x >= 0:  
			get_node("MarginContainer").set_position(Vector2(0,0))  


	# close
	if count_movement == 0 and  active == 0:
		move = 0

		if RayCast2D_W.is_colliding() == true and -get_node("MarginContainer").get_position().x < menu.get_size().x:
			speed = int(-((-menu.get_size().x)-get_node("MarginContainer").get_position().x)/speed_menu)+1 # mov_fundido  
			anima = int(get_node("MarginContainer").get_position().x-speed)
			# print("anima close: ",anima)
			
			if has_node("Top_menu"):
				get_node("MarginContainer").set_position(Vector2(anima,0))  

			else:
				get_node("MarginContainer").set_position(Vector2(anima,0))  

			if back_color > 0:
				back_color -= 0.1

		

	# notification menu if is closed
	if RayCast2D_W.is_colliding() == false:  
		get_node("MarginContainer").hide()
		get_node("/root/FuncApp").menu_hide = 1
		back_color = 0.0
	else:
		get_node("MarginContainer").show()
		get_node("/root/FuncApp").menu_hide = 0


	




func click_awesome(id_message,param):

	if id_message == "btn_menu":
	
		if active == 1:
			active = 0
			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("change_toggle","close")

		elif active == 0:
			active = 1
			for i in get_tree().get_nodes_in_group("click_awesome"):
				i.click_awesome("change_toggle","open")




func slider_click_release(time_pressed,distance): # al soltar el click | lo envia SliderGlobal al grupo: slider_click_release
	# print(time_pressed," / ",distance)
	# open
	if active == 0 and slider_control.dist_x < 100 and RayCast2D_W.is_colliding() and time_pressed < 15:
		active = 1
		for i in get_tree().get_nodes_in_group("click_awesome"):
			i.click_awesome("change_toggle","open")
	# close
	if active == 1 and slider_control.dist_x > 100 and RayCast2D_W.is_colliding() and time_pressed < 15 and distance.x < 0:
		active = 0
		for i in get_tree().get_nodes_in_group("click_awesome"):
			i.click_awesome("change_toggle","close")
	pass


