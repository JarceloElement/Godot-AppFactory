extends Camera2D

var CAVE_LIMITxd = 3000
const CAVE_LIMITxi = -100
const CAVE_LIMITyu = 0
const CAVE_LIMITyd = 0


export var Cx = 0
var Cy = -300
var down = 1
export var top_margin = 0
var zx = 1.0
var zy = 1.0

var cavepos = null


var N_slider = 1
var slider_count = 1




var click_active = 0
var count_movement = 1
var time_pressed = 0

var pos_cero_cam = 0

var count_color_slid = 0.0


func _ready():
	set_process(true)
	set_process_input(true)
	

	add_to_group("click_awesome")
	add_to_group("slider_click_release")
	
	
	set_enable_follow_smoothing(1)
	smoothing_speed = 8



func slider_click_release(time_pressed,distance):
	# siguiente slider rapido
	if slider_count < N_slider and count_movement < 0 and time_pressed < 10:
		slider_count += 1

	# anterior slider rapido
	if count_movement > 0 and time_pressed < 10:
		if slider_count > 1:
			slider_count -= 1
			
			
func _process(delta):

	var pantalla = get_viewport_rect().size.x
	
	if down == 1:
		if Cy < -(top_margin):
			Cy += 20
	if Cy == 0:
		down = 0
		set_enable_follow_smoothing(1)

	set_offset(Vector2( Cx, Cy))


	for i in get_tree().get_nodes_in_group("slider_view"):
		N_slider = i.get_node("ParallaxBackground/VBoxContainer/Items").get_child_count()

	for i in get_tree().get_nodes_in_group("Slider_control"):
		click_active = i.click_active
	
	
	CAVE_LIMITxd = N_slider*pantalla-100
	
	if slider_count < N_slider:
		# siguiente slider
		if -count_movement > pantalla/2 and click_active == 0 and count_movement < 0:
			slider_count += 1

	# anterior slider
	if count_movement > pantalla/2 and click_active == 0 and count_movement > 0:
		if slider_count > 1:
			slider_count -= 1


	for i in get_tree().get_nodes_in_group("slider_view"):
		pos_cero_cam = -i.get_position().y 
		
	if click_active == 0:
		set_position(Vector2(pantalla*(slider_count-1),pos_cero_cam)) 


	if click_active == 0:
		count_movement = 0
		count_color_slid = 0.0

	# --- MENSAJE AWESOME ---
	for i in get_tree().get_nodes_in_group("click_awesome"):
		i.click_awesome("paginacion",str(slider_count))
		i.click_awesome("paginacion_color_back",-count_color_slid/pantalla)
	# ----------------------------------------------


func _input(event):
	if (event is InputEventMouseMotion and event.button_mask&1): 

		var rel_x = event.get_relative().x
		var rel_y = event.get_relative().y
		cavepos = get_position() 
		
		count_movement += rel_x # distancia recorrida en cada click
		count_color_slid += rel_x
		
		cavepos.x -= rel_x
		cavepos.y -= rel_y
		if (cavepos.x > CAVE_LIMITxd):
			cavepos.x = CAVE_LIMITxd
		if (cavepos.x < CAVE_LIMITxi):
			cavepos.x = CAVE_LIMITxi

		if (cavepos.y < CAVE_LIMITyu):
			cavepos.y = CAVE_LIMITyu
		if (cavepos.y > CAVE_LIMITyd):
			cavepos.y = CAVE_LIMITyd

		set_position(Vector2(cavepos.x,pos_cero_cam)) 


func click_awesome(id_message,message_text):
	if id_message == "paginacion":
		slider_count = int(message_text)





