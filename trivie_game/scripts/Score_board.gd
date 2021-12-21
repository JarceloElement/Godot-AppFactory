extends VBoxContainer

# ---- consulta sql ----
#var sql_signup = SQLite.new();
#var sql = SQLite.new();
var dir_new = Directory.new()
var Home = ""
var ruta_media = ""
var ruta_image = ""
var ruta_data = ""
var path_res = ""
var path = ""
var count = 0
var item_DB_new = []
var field_name_list = []
var table_name = "score"

# para score board
var score_data = []
var user_datas = ""
#-------------



export var is_score_list = 0
var count_score = 0

var users_in_board = []
var scores_in_board = []

var scoreboard_id = []
var scoreboard_user = []
var scoreboard_score = []


# datos de partida del user
var user_id = ""
var user_name = "name"
var user_score = 0
var user_game_name = 0
var user_correct_answer = 0
var user_incorrect_answer = []
var user_point = 0
var user_game_time = 0
var save_wallet = 0
	

func _ready():
	
	add_to_group("score_board")
	
	# ATENCION  sin cargar el path antes no hace consulta | Debe precidir este codigo
	# --- PATH CONF ---
	Home = get_node("/root/FuncApp").Home
	ruta_media = str(Home) + get_node("/root/FuncApp").dir_name_media
	ruta_image = ruta_media + get_node("/root/FuncApp").dir_name_image
	ruta_data = ruta_media + get_node("/root/FuncApp").dir_name_data
	# print(ruta_data)
	
	#-------crear carpeta / DB--------
	if( !dir_new.dir_exists( Home ) ):
		dir_new.make_dir_recursive( Home )
		print( get_node("/root/FuncApp").dir_name_home + " | Folder created" )

	if( !dir_new.dir_exists( ruta_media ) ):
		dir_new.make_dir_recursive( ruta_media )
		print( get_node("/root/FuncApp").dir_name_media + " | Folder created" )

	if( !dir_new.dir_exists( ruta_image ) ):
		dir_new.make_dir_recursive( ruta_image )
		print( get_node("/root/FuncApp").dir_name_image + " | Folder created" )

	if( !dir_new.dir_exists( ruta_data ) ):
		dir_new.make_dir_recursive( ruta_data )
		print( get_node("/root/FuncApp").dir_name_data + " | Folder created" )




	# CREAR DATA BASE
#	table_name = "score_"+get_node("/root/FuncApp").SQL_DB_NAME # get_owner es el nodo raiz
#	path = (ruta_data+"/"+table_name+".db") # esto crea la DB en la ruta como texto plano en blanco sin registros
#	if sql.open(path) != sql.SQLITE_OK:
#		print("ERR SQL campo report: ", sql.get_errormsg());
#	else:
#		sql.open(path)
#		pass


	if is_score_list == 1:
		table_name = "score_"+get_node("/root/FuncApp").SQL_DB_NAME_score # lo agrega el boton con msm: add_popup_score
#		print(table_name)
		_show_scoreboard()




	# define los ID de la DB nueva segun el form
	item_DB_new.append("user_id INTEGER PRIMARY KEY AUTOINCREMENT ")

	# campos extras en DB
	# item_DB_new.append("user_id TEXT ") # con tipo
	item_DB_new.append("user_score TEXT ") # con tipo
	item_DB_new.append("answ_corect TEXT ") # con tipo
	item_DB_new.append("answ_incorrect TEXT ") # con tipo
	item_DB_new.append("point TEXT ") # con tipo
	item_DB_new.append("time TEXT ") # con tipo
	
	field_name_list.append("user_id")
	field_name_list.append("user_score")
	field_name_list.append("answ_corect")
	field_name_list.append("answ_incorrect")
	field_name_list.append("point")
	field_name_list.append("time")

	item_DB_new = str(item_DB_new).replace("[","").replace("]","") # nombre de los ID de la DB con tipo de campo

	# --- Create database SQL if not exists ---
#	sql.query("CREATE TABLE IF NOT EXISTS "+table_name+" ("+str(item_DB_new)+");");
#	sql.open(path)
	# END CREAR DB






	# insertar datos de score board
	path = (ruta_data+"/"+table_name+".db") #
#	if sql.open(path) != sql.SQLITE_OK:
#		print("ERR SQL campo report: ", sql.get_errormsg());
#	else:
#		sql.open(path)
#		pass




func _insert_scoreboard():


	# insertar datos de partida
	score_data.append(user_id)
	score_data.append(user_score)
	score_data.append(user_correct_answer)
	score_data.append(str(user_incorrect_answer).replace("[","").replace("]","").replace(", ",","))
	score_data.append(user_point)
	score_data.append(user_game_time)
	
#	print("score_data; ",score_data)

	# consulta lista de usuarios existentes
#	for user in sql.fetch_array("SELECT * FROM "+table_name+" WHERE user_id='"+str(user_id)+"';"):
#		users_in_board.append(str(user["user_id"]))
#		scores_in_board.append(user["user_score"])
#		print("user_in_board ",users_in_board," user_id: -",user_id,"-")
#
	
	# existe el usuario | actualiza score
#	if users_in_board.has(str(user_id)):
#		sql.query("UPDATE "+table_name+" SET user_score='"+str(score_data[1])+"'"+", answ_corect='"+str(score_data[2])+"'"+", answ_incorrect='"+str(score_data[3])+"'"+", point='"+str(score_data[4])+"'"+", time='"+str(score_data[5])+"' WHERE user_id='"+str(score_data[0])+"';");
#		print("User exist: ",user_name)
#
#
#
#	# NO existe el usuario | crea registro
#	else:
#		var data = str(score_data).replace("[","'").replace("]","'").replace(", ","','")
#		field_name_list = str(field_name_list).replace("[","").replace("]","") # nombre de los ID de la DB sin tipo de campo
#	#	print(field_name_list,"-",data)
#		sql.query("INSERT INTO "+table_name+" ("+str(field_name_list)+") VALUES ( " +str(data)+ " )")
#		print("User no exist: ",user_id)
#
		
	
	_show_scoreboard()
		
func _show_scoreboard():
	
	path = (ruta_data+"/"+table_name+".db") #
#	print(path)
#	if sql.open(path) != sql.SQLITE_OK:
#		print("ERR SQL in scoreboard: ", sql.get_errormsg());
#	else:
#		sql.open(path)
#		pass
#
#	if sql_signup.open(ruta_data+"/signup.db") != sql_signup.SQLITE_OK:
#		print("ERR SQL in scoreboard: ", sql_signup.get_errormsg());
#	else:
#		sql_signup.open(ruta_data+"/signup.db")
#		pass
#
#
#
#	# consulta lista de usuarios existentes
#	for user in sql.fetch_array("SELECT * FROM "+table_name+" ORDER BY abs(user_score) DESC"):
#		scoreboard_id.append(user["user_id"])
#		scoreboard_score.append(user["user_score"])
##	print("score: ",scoreboard_user,scoreboard_score)
#
#	for id in scoreboard_id:
#		# consulta nombre de usuario en signup segun user_id
#		for user in sql_signup.fetch_array("SELECT * FROM signup WHERE user_id="+str(id)):
#			scoreboard_user.append(user["user_name"])

		

	set_process(1)
	
	
func _process(delta):
	
	# muestra un listado de 10 en la scn scoreboard
	if is_score_list == 1:
		if count_score < 10 and count_score < scoreboard_user.size():
			var User_score = get_node("/root/FuncApp").get("User_score").instance() # add new
			User_score.score = str(scoreboard_user[count_score]).to_upper()+": "+str(int(scoreboard_score[count_score]))
			User_score.position = count_score+1
			
			User_score.set_name(str(scoreboard_user[count_score]))
			if User_score.position == 1:
				User_score.set_process(1) # resalta el usuario en la tabla
			add_child(User_score)
			count_score += 1
	
	#		print("ADD_SCORE > 5 ",count_score,"-",scoreboard_user)
	
		
	# muestra los 5 mejores al terminar cada nivel
	if is_score_list == 0:
		
		if count_score < scoreboard_user.size() and scoreboard_user.size() < 5:
			var User_score = get_node("/root/FuncApp").get("User_score").instance() # add new
			User_score.score = str(scoreboard_user[count_score]).to_upper()+": "+str(int(scoreboard_score[count_score]))
			User_score.position = count_score+1
			User_score.wallet = save_wallet
			
			User_score.set_name(str(scoreboard_user[count_score]))
			if User_score.get_name() == user_name:
				User_score.set_process(1) # resalta el usuario en la tabla
			add_child(User_score)
			count_score += 1
			
		elif count_score < 5 and scoreboard_user.size() >= 5:
			var User_score = get_node("/root/FuncApp").get("User_score").instance() # add new
			User_score.score = str(scoreboard_user[count_score]).to_upper()+": "+str(int(scoreboard_score[count_score]))
			User_score.position = count_score+1
			User_score.wallet = save_wallet
			
			User_score.set_name(str(scoreboard_user[count_score]))
			if User_score.get_name() == user_name:
				User_score.set_process(1) # resalta el usuario en la tabla
			add_child(User_score)
			count_score += 1
	
	#		print("ADD_SCORE > 5 ",count_score,"-",scoreboard_user)


func _set_scoreboard():
	# carga EL usuario
	var wallet = ""
	user_id = get_node("/root/FuncApp").SESSION["user_id"]
	user_name = get_node("/root/FuncApp").SESSION["user_name"]
	wallet = get_node("/root/FuncApp").SESSION["wallet"]

	user_game_name = get_node("/root/FuncApp").user_game_name
	user_correct_answer = get_node("/root/FuncApp").user_correct_answer
	user_incorrect_answer = get_node("/root/FuncApp").user_incorrect_answer
	user_game_time = get_node("/root/FuncApp").user_game_time
	user_score = (user_correct_answer*1000)-int(user_game_time)
#	user_score = user_correct_answer*1000/user_game_time
#	print("user_score: ",user_correct_answer*1000," - Time: ",user_game_time)
#	print(user_incorrect_answer)
	show()

	get_node("/root/FuncApp").user_game_name = 0
	get_node("/root/FuncApp").user_correct_answer = 0
	get_node("/root/FuncApp").user_incorrect_answer = []


	# actulizar wallet
#	if sql_signup.open(ruta_data+"/signup.db") != sql_signup.SQLITE_OK:
#		print("ERR SQL in scoreboard: ", sql_signup.get_errormsg());
#	else:
#		sql_signup.open(ruta_data+"/signup.db")
#		pass
#
#	# si no esta completo el nivel o hay respuestas incorrectas | gana la mitad del puntaje acumulado
#	if user_correct_answer < get_node("/root/FuncApp").total_answer_in_trivie or user_incorrect_answer.size() > 0:
#		# guarda dinero en wallet
#		sql_signup.query("UPDATE signup SET wallet='"+str(int(wallet)+user_score/2)+"' WHERE user_id='"+str(user_id)+"';");
#		save_wallet = user_score/4
#		print("Incomplete level-Score: ",user_score/2)
#
#	elif user_correct_answer == get_node("/root/FuncApp").total_answer_in_trivie:
#		# guarda dinero en wallet
#		sql_signup.query("UPDATE signup SET wallet='"+str(int(wallet)+user_score)+"' WHERE user_id='"+str(user_id)+"';");
#		save_wallet = user_score/2
#		print("Complete level-Score: ",user_score)
#
#	# carga session actualizada
#	get_node("/root/FuncApp").SESSION = sql_signup.fetch_array("SELECT * FROM signup WHERE user_id="+str(user_id))


	_insert_scoreboard()

#	print("_set_scoreboard()")
	pass
