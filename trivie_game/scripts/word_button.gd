extends Button

export var type = "word"

var player_path = ""
onready var player_sound = $StreamPlayer 


#func _player_sound(track,vol):
#	player_path = "res://trivie_game/sound/"
#	player_sound.set_stream(load(player_path+track+".ogg"))
#	player_sound.set_volume_db(vol)
#	player_sound.play(0)
	
	
func _ready():
	add_to_group("word_button")
	connect("pressed",self,"_pressed_word")
	set("rect_min_size",Vector2(get_size().x+10,get_size().y))
	pass

func _pressed_word():
	
	if type == "word":
#		
		set_toggle_mode(1)
		
		for button in get_tree().get_nodes_in_group("word_button"):
			
			if button.get_name() == get_name() and button.type == "word":
				button.set_pressed(1)
				
				for grid in get_tree().get_nodes_in_group("button_grid_container"):
					grid.active_word = get_name()
					grid.active_word_string = get_text()
			
				# habilitar palabra de opcion si esta precionado en respuesta
				for message in get_tree().get_nodes_in_group("click_awesome"):
					message.click_awesome("enab_option",get_text())
					
			elif button.get_name() != get_name() and button.type == "word":
				button.set_pressed(0)



	if type == "option":
		for grid in get_tree().get_nodes_in_group("button_grid_container"):
			if grid.active_word != ""  and grid.type == "word":
				grid._rectify(get_text())
			
				
				# habilitar o des palabra de opcion
				for message in get_tree().get_nodes_in_group("click_awesome"):
					message.click_awesome("enab_disab_option","")
			
			
			elif grid.active_word == "" and grid.type == "word":
				grid.add_option(get_text())
			#	_player_sound("notific",5)

#			print(grid.active_word)





