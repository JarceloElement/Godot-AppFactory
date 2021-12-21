extends MarginContainer

var path
export var DB_name = "vocabulario.cfg"
export var Table_name = "CONF"
export var language = "es"
export var voice_type = "male"
export var set_init = bool(false)

var sentence_question = ""
var sentence_trivie = ""
var sentence_options = ""
var sentence_pronunc = ""
var sentence_string = []
var array_word_options = []
var Word_button = null
var ID = 0
var ID_Item = 0
var total_report = 0
var answer = ""


var player_path = ""
onready var player_sound = get_node("AudioStreamPlayer") 
onready var title = get_node("VBoxContainer/title/Title")
onready var question = get_node("VBoxContainer/Question")
onready var image = get_node("VBoxContainer/Image/refer_image") 
onready var answer_verify = get_node("VBoxContainer/Word_interaction/Answer_verify")


# datos de la partida | solo ref. estan en global
var user_game_name = 0
var user_correct_answer = 0
var user_incorrect_answer = []
var user_game_time = 0





func _player_sound(track,vol):
	player_path = "res://trivie_game/sound/"
	var audio: AudioStreamOGGVorbis = load(player_path+track+".ogg")
	audio.loop = false
	player_sound.set("stream",audio)
	player_sound.set_volume_db(vol)
	player_sound.play()
#	print("_player_sound")



func _player_stop():
	player_sound.stop()
#	print("_play_stop")




func _ready():
	add_to_group("click_awesome")
	add_to_group("trivie_control")
	set_process(1)

	get_node("VBoxContainer/Word_interaction/Button_GridContainer/ScrollContainer").set_theme(get_node("/root/FuncApp").theme_city_tools)
	get_node("VBoxContainer/Word_interaction/Button_Grid_options").set_theme(get_node("/root/FuncApp").theme_city_tools)
	
	
	title.text = (str(get_node("/root/Messages").get("trivie_db_loaded")))
	title.set_align(1)
	question.hide()
#	image.set_texture(load("res://images/assets/buho_1.png"))
	answer_verify.hide()
	get_node("Popup").hide()
	
	
	get_node("/root/FuncApp").user_correct_answer = 0 # reinicia conteo

	
	for progres_bar_game in get_tree().get_nodes_in_group("progres_bar_game"):
		progres_bar_game.hide()
	
	# oculta el boton verificar al inicio
	for dynamic_btn in get_tree().get_nodes_in_group("verify_trivie"):
		dynamic_btn.hide()

	if set_init == true:
		# DB total
		var path = get_node("/root/FuncApp").dir_name_user+"/"+DB_name
		DB_name = path
		total_report = $"/root/DbQuery".get_configFile_DB_total(Table_name,DB_name)
		get_node("/root/FuncApp").total_answer_in_trivie = total_report
		_player_sound("notific",1)


func _DB_loaded_and_ini(): # de DB_control al terminar la carga
	
	title.text = (str(get_node("/root/Messages").get("trivie_db_loaded")))
	title.set_align(1)
	image.set_texture(load("res://trivie_game/assets/huevo.png"))
	print("trivie: _DB_loaded_and_ini")
	# lo asigna el DB_control
	DB_name = get_node("/root/FuncApp").ACTIVE_DB_PATH["path"]
#	print(DB_name)

	# DB total
	total_report = $"/root/DbQuery".get_configFile_DB_total(Table_name,DB_name)
	get_node("/root/FuncApp").total_answer_in_trivie = total_report
	_player_sound("notific",0.1)



func _process(delta):
	# agrega las palabras de opciones
	for i in sentence_options.split(" ",0):
		if ID < sentence_options.split(" ",0).size():
			add_word(i)
#		if ID == sentence_options.split(" ",0).size():
#			ID = 0
	
	get_node("Popup/VBoxContainer/timer_count").text = str(int(get_node("Timer").get_time_left()))



	# tiempo de la partida
#	if ID_Item > 0 and ID_Item <= total_report and get_node("Popup").is_hidden() and get_node("VBoxContainer/Word_interaction/Answer_verify").is_hidden():
#		get_node("/root/FuncApp").user_game_time += delta
##		print(get_node("/root/FuncApp").user_game_time)


func sql_next_trivie():
	
#	image.get_parent().hide()
	get_node("VBoxContainer/HBoxContainer/Button_icon").show()
	get_node("VBoxContainer/HBoxContainer/MarginContainer5").show()
	answer_verify.hide()
	get_node("Popup").hide()
	get_node("VBoxContainer/Word_interaction/Button_GridContainer/color_back").show() 
	
	# oculta boton verificar
	for dynamic_btn in get_tree().get_nodes_in_group("verify_trivie"):
		dynamic_btn.hide()
			# dynamic_btn.show()
	
	# muestra barra
	for progres_bar_game in get_tree().get_nodes_in_group("progres_bar_game"):
		progres_bar_game.show()

	ID_Item += 1
	var List_ID_Item = []

	
	
	# SIGUIENTE PREGUNTA
	if ID_Item < total_report:
		# DB QUERY
		var DB = $"/root/DbQuery"
		var query_param = {
		"section": "*",
		"search": "*",
		"id": str(ID_Item),
		"where": [],
		"id_field": "id"
		}
		var query = DB.conf_query(Table_name,DB_name,query_param)
#		print(query)
		
		for line in query["result"]:
#			print(line["title"])
			if language == "es":
				sentence_question = line["spanish"]
				sentence_trivie = line["english"]
				sentence_options = line["en_options"]
				sentence_pronunc = line["pronunciation"]
				answer = line["english"]
			elif language == "en":
				sentence_question = line["english"]
				sentence_trivie = line["spanish"]
				sentence_options = line["es_options"]
				sentence_pronunc = line["pronunciation"]
				answer = line["spanish"]
			# descripcion sobre la trivia activa
			title.text = line["description"]
			title.show()
			if title.text == "":
				title.hide()

		# asigna la pregunta en el question viewer
		get_node("VBoxContainer/Question/answer/Label").set_text(sentence_question)
		set_process(1) # agrega la lista de botones de opciones
		ID = 0

		# pronunciar
		get_node("/root/FuncApp").speak([sentence_question,"male","es"])
		
		# incrementa barra de progreso
		for progres_bar_game in get_tree().get_nodes_in_group("progres_bar_game"):
			progres_bar_game.total = total_report
			progres_bar_game.level = ID_Item
			progres_bar_game.bar_next_level()
	
	
		get_node("Popup/VBoxContainer/sentence").text = sentence_question
		get_node("Popup/VBoxContainer/pronunciation").text = sentence_pronunc


	# nivel completo
	if ID_Item >= total_report:
		for progres_bar_game in get_tree().get_nodes_in_group("progres_bar_game"):
			progres_bar_game.hide()
		
		title.text = (str(get_node("/root/Messages").get("trivie_finish")))
		title.set_align(1)
		question.hide()
		image.hide()
		get_node("VBoxContainer/Word_interaction").hide()
		image.set_texture(load("res://trivie_game/assets/buho_1.png"))
		image.get_parent().show()

		for dynamic_btn in get_tree().get_nodes_in_group("verify_trivie"):
			dynamic_btn.hide()

		_player_sound("fanfarria_corta",1)


		# muestra score board
		for score_board in get_tree().get_nodes_in_group("score_board"):
			score_board._set_scoreboard()
		get_node("VBoxContainer/Score_board").set_custom_minimum_size(Vector2(self.get_size().x,get_viewport_rect().size.y/2))
		get_node("VBoxContainer/Score_board").show()
		ID_Item = 0
		
		# cambia mensaje del boton
		for dynamic_btn in get_tree().get_nodes_in_group("next_trivie"):
			dynamic_btn.ID_message = "finish_game"
#				dynamic_btn.hide()


func add_word(i):
	Word_button = get_node("/root/FuncApp").Word_button.instance()
	var grid = get_node("VBoxContainer/Word_interaction/Button_Grid_options/ScrollContainer/GridContainer")
	
	Word_button.type = "option"
	Word_button.set_text(i)
	grid.add_child(Word_button)
	ID += 1
#	print(i)
	
	for set_high in get_tree().get_nodes_in_group("button_grid_container"):
		set_high.set_process(1)
		pass
	
	
func _verific():
#		print("_verific")
		# ocultar boton verificar al presionarlo
		for dynamic_btn in get_tree().get_nodes_in_group("verify_trivie"):
			title.hide()
			dynamic_btn.hide()
				
		if get_node("VBoxContainer/Word_interaction/Button_GridContainer").type == "word":
			sentence_string = []
			var sentence_grid = get_node("VBoxContainer/Word_interaction/Button_GridContainer/ScrollContainer/GridContainer")
			var sentence_length = sentence_grid.get_child_count()
			
			for words in range(0,sentence_length):
				sentence_string.append(sentence_grid.get_child(words).get_text())

			sentence_string = str(sentence_string).replace("[","").replace("]","").replace(",","")
			# print(sentence_trivie,"-",sentence_string)
			

			# si es correcto
			if sentence_trivie == sentence_string:
				answer_verify.hide()
				get_node("Popup").show()
				get_node("Timer").start()
				_player_sound("bonus_soft",1)
				print("Sentence TRUE")
			
				# datos de usuario para el score board al terminar partida
				get_node("/root/FuncApp").user_correct_answer += 1
			
			# no es correcto
			elif sentence_trivie != sentence_string:
				answer_verify.text = sentence_trivie
				answer_verify.show()
				_player_sound("juissh",1)
				
				# datos de usuario para el score board al terminar partida
				get_node("/root/FuncApp").user_incorrect_answer.append(ID_Item)
				
				# coloca los botones en rojo | disabled
				for button in get_tree().get_nodes_in_group("word_button"):
					if button.type == "word":
						button.set_disabled(1)
				
				print("Sentence FALSE")
		
			
			sentence_string = []
			for words in range(0,sentence_length):
				sentence_string.append(sentence_grid.get_child(words).get_text())

			# pronunciar
			yield(get_tree().create_timer(1),"timeout")
			if int(get_node("Timer").get_time_left()) != 0: 
				get_node("/root/FuncApp").speak([answer,voice_type,language])




func click_awesome(ID_message,param):
#	if ID_message != "top_bar_volver" and ID_message != "pos_scroll_y_all":
#		print(ID_message," | param: ",param)

	if ID_message == "trivie_control":
		_verific()


		
	if ID_message == "add_option":

		Word_button = get_node("/root/FuncApp").Word_button.instance()
		var grid = get_node("VBoxContainer/Word_interaction/Button_GridContainer/ScrollContainer/GridContainer")
		var grid_option = get_node("VBoxContainer/Word_interaction/Button_Grid_options/ScrollContainer/GridContainer").get_children()
		
		if grid.get_children().size() < sentence_trivie.split(" ",0).size():
			Word_button.type = "word"
			Word_button.set_text(param)
			grid.add_child(Word_button)
			sentence_string.append(param)
			_player_sound("notific",1)
		#	print(param)
			
			for set_high in get_tree().get_nodes_in_group("button_grid_container"):
				set_high.set_process(1)
				pass



			# restaurar palabra en las opciones
			var sentence_grid = get_node("VBoxContainer/Word_interaction/Button_GridContainer/ScrollContainer/GridContainer")
			var sentence_length = sentence_grid.get_child_count()
			
		#	for words in range(0,sentence_length):
		#		sentence_string.append(sentence_grid.get_child(words).get_text())
		
	
#			var sentence_grid_opt = get_node("Word_interaction/Button_Grid_options/ScrollContainer/GridContainer")
#			var sentence_length_opt = sentence_grid_opt.get_child_count()
		
#			for words in range(0,sentence_length_opt):
#				array_word_options.append(sentence_grid_opt.get_child(words).get_text())
	
			for option in sentence_string:
				for button in get_tree().get_nodes_in_group("word_button"):
					if button.type == "option":
						button.set_toggle_mode(1)
						if button.get_text() == option:
							button.set_pressed(1)
	#						print(button.get_text())




		# print(sentence_string)
	
	
		if grid.get_children().size() >= sentence_trivie.split(" ",0).size():
			# desactiva las palabras de opciones usadas
			for option in sentence_string:
				for button in get_tree().get_nodes_in_group("word_button"):
					if button.type == "option":
						button.set_toggle_mode(1)
						
						if sentence_string.has(button.get_text()):
						#	if button.get_text() == option:
							button.set_pressed(1)
							
						else:
							button.set_pressed(0)



		# mostrar boton verificar al completar la oracion
		# if grid.get_children().size() >= sentence_trivie.split(" ",0).size():
			for dynamic_btn in get_tree().get_nodes_in_group("verify_trivie"):
				dynamic_btn.Title_message = "Revisar"
#				title.show()
				dynamic_btn.show()
					

		# si solo hay una palabra en la pregunta
		if sentence_trivie.split(" ",0).size() == 1:
			for dynamic_btn in get_tree().get_nodes_in_group("verify_trivie"):
				dynamic_btn.Title_message = "Revisar"
#				title.show()
				dynamic_btn.show()
			
			
	if ID_message == "enab_disab_option":
		_player_sound("notific",1)
		
		# rehace la lista de palabras en la respuesta
		sentence_string = []
		var sentence_grid = get_node("VBoxContainer/Word_interaction/Button_GridContainer/ScrollContainer/GridContainer")
		var sentence_length = sentence_grid.get_child_count()
		for words in range(0,sentence_length):
			sentence_string.append(sentence_grid.get_child(words).get_text())

		# desactiva las palabras de opciones usadas
		for option in sentence_string:
			for button in get_tree().get_nodes_in_group("word_button"):
				if button.type == "option":
					button.set_toggle_mode(1)
					
					if sentence_string.has(button.get_text()):
					#	if button.get_text() == option:
						button.set_pressed(1)
						
					else:
						button.set_pressed(0)
						
#		print(sentence_string)


	if ID_message == "enab_option":
		_player_sound("lump",1)
		
		# rehace la lista de palabras en la respuesta
		sentence_string = []
		var sentence_grid = get_node("VBoxContainer/Word_interaction/Button_GridContainer/ScrollContainer/GridContainer")
		var sentence_length = sentence_grid.get_child_count()
		
		for words in range(0,sentence_length):
			sentence_string.append(sentence_grid.get_child(words).get_text())

		# desactiva las palabras de opciones usadas
		for option in sentence_string:
			for button in get_tree().get_nodes_in_group("word_button"):
				if button.type == "option":
					button.set_toggle_mode(1)
					
					if sentence_string.has(button.get_text()):
					#	if button.get_text() == option:
						button.set_pressed(1)
						
					else:
						button.set_pressed(0)
		
		
		# activa palabra opcion presionada en respuesta
		for button in get_tree().get_nodes_in_group("word_button"):
			if button.type == "option":
				if button.get_text() == param:
					button.set_pressed(0)
					
					
#		print(param)

	if ID_message == "sql_next_trivie":
		_player_sound("notific",1)
		print("sql_next_trivie")
		
		for button in get_tree().get_nodes_in_group("word_button"):
			button.queue_free()
			
		sentence_string = []
		array_word_options = []
		title.set_align(0)
		title.show()
		question.show()
#		image.show()
		sql_next_trivie()
		get_node("Timer").stop()

		for grid in get_tree().get_nodes_in_group("button_grid_container"):
			grid.active_word = ""

	if ID_message == "pronunc":
		get_node("/root/FuncApp").speak([sentence_question,"male","es"])
		
		
func _on_Timer_timeout():
	get_node("Popup").hide()
	get_node("Timer").stop()
	
	var mensajes = get_tree().get_nodes_in_group("click_awesome")
	for i in mensajes:
		i.click_awesome("sql_next_trivie","")






func _on_AudioStreamPlayer_finished():
	player_sound.stop()
	print("player_sound.stop()")
	pass # Replace with function body.
