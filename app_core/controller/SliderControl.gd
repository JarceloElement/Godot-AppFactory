extends Control

var count_movement = 1
var count_movement_y = 1

const MAX_POINTS = 10
var points = []
var last_dist = 0
var current_dist_y = 0
var last_dist_x = 0
var dist_x = 0
var dist = 0
var current_dist_x = 0
var zoom_started = false
var x_posi_n = 0
var y_posi_n = 0
var x_posi = current_dist_x
var y_posi = current_dist_y
var blok = 0
var click_active = 0

var rel_x = 0
var rel_y = 0
var float_y = 0.0


# var usables
var relative_input = "" # x or y
var slider_pos_global = 0 # distancia recorrida mientras se arrastra el click
var distance = Vector2() # distacia recorrida al soltar el click
var time_pressed = 0 # tiempo que duro el click presionado
# ====



func _ready():
	set_process(1)
	set_process_input(true)
	add_to_group("Slider_control")
	
	for i in range(MAX_POINTS):
		points.append({pos=Vector2(),start_pos=Vector2(),state=false})



func _process(delta):
	# eje activo
	x_posi_n = int(current_dist_x)
	y_posi_n = int(current_dist_y)
	
	if y_posi_n < 0:
		y_posi_n = int(-y_posi_n)
		
	if x_posi_n < 0:
		x_posi_n = int(-x_posi_n)
	
	# bloquea un eje mientras se usa el otro NORMAL
	if x_posi_n > 2 and relative_input != "y":
		relative_input = "x" # usar esta como condicion de bloquear eje
	elif y_posi_n > 2 and relative_input != "x":
		relative_input = "y" # usar esta como condicion de bloquear eje
	if x_posi_n == 0 and y_posi_n == 0:
		relative_input = "" # usar esta como condicion de bloquear eje
	# ----------------


	if click_active == 1:
		time_pressed += 1 # tiempo del click presionado
	else:
		time_pressed = 0
		count_movement = 0
		count_movement_y = 0
		distance = Vector2()




#--------slider---------
func _input(event):

	#------- mover -------
	if (event is InputEventMouseMotion and event.button_mask&1): 
		
		rel_x = event.get_relative().x
		rel_y = event.get_relative().y
		# pos_from_slider = get_position() 

		count_movement += rel_x # distancia recorrida en cada click
		count_movement_y += rel_y # distancia recorrida en cada click
		distance += event.get_relative() # distancia recorrida


	if event is InputEventScreenDrag: 
		points[event.index].position = event.position 

	if event is InputEventScreenTouch: 
		points[event.index].state = event.pressed
		points[event.index].position = event.position 
#		print(points)
		if event.pressed:
			points[event.index].start_pos = event.position

			click_active = 1
			zoom_started = true

		if !event.pressed:
			current_dist_y = 0
			last_dist = 0
			current_dist_x = 0
			last_dist_x = 0
			zoom_started = false
			click_active = 0
			float_y = 0

			if count_movement != 0:
				for i in get_tree().get_nodes_in_group("slider_click_release"):
					i.slider_click_release(time_pressed,distance)
				

	handle_zoom(event)
	


func handle_zoom(event):
	var bool_ = 1
	if event is InputEventScreenDrag: 
		
		# coloca el cursor en el scroll al desplazar verticalmente
		if slider_pos_global > 5 and bool_ == 1 and relative_input == "y":
			for i in get_tree().get_nodes_in_group("focus_scroll"):
				i.focus_scroll()
			bool_ = 0
#			# ----------------------------------------------

		dist = points[0].position.y 
		dist_x = points[0].position.x 
		
		if zoom_started: # asigna constante la posicion de cada clic al presionar en la pantalla
			zoom_started = false
			last_dist = dist
#			current_dist_y = dist
			last_dist_x = dist_x


		else:
			current_dist_y = last_dist - dist
			current_dist_x = last_dist_x - dist_x
			float_y = current_dist_y

#			last_dist = dist
			current_dist_y = int(current_dist_y/4) # eje y bipolar
			current_dist_x = int(current_dist_x/4) # eje x bipolar


	# ------coloca la direccion del raton siempre en positivo
	x_posi = distance.x
	y_posi = distance.y
	
	if y_posi < 0:
		y_posi = int(-y_posi)

	if x_posi < 0:
		x_posi = int(-x_posi)
	# ----------------

	if x_posi > y_posi:
		slider_pos_global = x_posi # pos global en positivo | todos los ejes
	else:
		slider_pos_global = y_posi # pos global en positivo | todos los ejes
	# ----------------
#	print(slider_pos_global)



