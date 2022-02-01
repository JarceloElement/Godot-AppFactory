extends Node

var scroll_top = 1

var config = ConfigFile.new()
var result = ""
var result_search = Array()
var result_where_search = Array()
var result_where_and = Array()
var pos_section = 0
var i_where = 0

#var file_path = "res://examples/file.txt"
#var path = "res://DB/vocabulario.cfg"
#var csv_path = "res://DB/vocabulario.csv"

var JSON_path = "res://DB/file.json"
var line = []
var data_string = " "







func _ready():



#	print( $"/root/FuncApp".save_csv_to_json("res://examples/file.csv") )
	
#	print( $"/root/FuncApp".save_csv_to_configfile("res://DB/tools_city.csv","res://DB/tools_city.cfg",",",0) )


#	print( $"/root/FuncApp".load_csv("res://examples/file.csv", "*") )
	
#	print( $"/root/FuncApp".load_json_param("res://examples/file.json","horse") )
#	print( $"/root/FuncApp".load_json_array("res://examples/file.json") )
	
#	var param = ["tablename", "key", "valor,valor2,valo3"]
#	print( $"/root/FuncApp".save_configFile(path,param) )
#	print( $"/root/FuncApp".erase_configFile(path,param) )
	
	
	# CONSULTA SIN PARAMETROS O CON ID: IMPRIME SOLO INDEX
#	var param["section"] = "*" # default *
#	var search = "*" # default *
#	var ID_ = "*" # alone no param["section"] no search | default *
#	var where = [] # format["active,==,0"] | deafault []
#	var id_field = "id" # default: ""

#	var result_cfg = $"/root/FuncApp".get_configFile(param["section"],search,ID_,where) # get_configFile("param["section"]","search","id",[where:"active,==,1"])
#	print("get_configFile_DB_total: ",$"/root/FuncApp".get_configFile_DB_total())
	# =======
	
	
	
#	var store_var: Dictionary =  {"A":6,"B:":"dos","Animal":"perro"}
#	print( $"/root/DbQuery".save_to_csv("res://DemoData.csv", store_var) )
	
	
#	var query_param = {
#		"section": "*",
#		"search": "*",
#		"id": "*",
#		"where": [],
#		"id_field": "id"
#	}
#	var DB = $"/root/DbQuery"
#	var path = "res://SocialApp/leader_conf.cfg"
#	print("QUERY-DEMO: ",DB.conf_query("CONF",path,query_param)["result"][0]["title"])
#

	pass




func export_to_csv(path_from,path_to,table_name):
	
	# SAVE TO CSV
	# crea el archivo si no esxiste
	var file_store: File = File.new()
	var dir_new = Directory.new()
#	if dir_new.file_exists(path) == false:
	file_store.open(path_to, File.WRITE)
	file_store.store_string("")
	print("Created file")
	
	file_store.open(path_to, File.READ_WRITE) # flags 3 = READ_WRITE
	
	
	var query_param = {
	"section": "*",
	"search": "*",
	"id": "*",
	"where": [],
	"id_field": "id"
	}
	var DB_conf = $"/root/DbQuery"
	var Qconf = DB_conf.conf_query(table_name,path_from,query_param)
	
	var return_var = {}
	return_var["finish"] = "Exporting..."
	return_var["max_value"] = Qconf["result"].size()
	
	# var set_line_to_csv
	for i in Qconf["result"]:
		
		var string_data = []
		for dat in i:
			string_data.append(i[dat])
	
		var store_var: PoolStringArray = string_data
		file_store.seek_end()
		file_store.store_csv_line(store_var,",")
		print("Inset to CSV: ",store_var)
		
		return_var["progress"] = 1
		for progress in get_tree().get_nodes_in_group("DB_export"):
			progress.set_progress(return_var)
#		return return_var
	
	file_store.close()

#	return "CSV saved on: "+path_to
	return_var["finish"] = "CSV saved on: "+path_to
	return return_var
	
	
	
	
	
func save_to_csv(path, param):
	
	var string_data = []
	for dat in param:
		string_data.append(param[dat])
#	print("save_to_csv: ",string_data)
	
	# SAVE TO CSV
	# crea el archivo si no esxiste
	var file_store: File = File.new()
	var dir_new = Directory.new()
#	if dir_new.file_exists(path) == false:
	file_store.open(path, File.WRITE)
	file_store.store_string("")
	print("Created file")
	
	file_store.open(path, File.READ_WRITE) # flags 3 = READ_WRITE
	
	var store_var: PoolStringArray = string_data
#	store_var.push_back("\n")
	file_store.seek_end()
	file_store.store_csv_line(store_var,",")
	file_store.close()

	return "CSV saved on: "+path



func load_csv(csv_path, search):
	
	var file: File = File.new()
	file.open(csv_path, File.READ)

	var search_result = Array()
	
	while not file.eof_reached():
		line = file.get_csv_line(",")
		
		if search == "*" or search == "":
			search_result.append(line)
		
		# busca una palabra completa en la linea
		elif Array(line).has(search): 
			search_result.append_array(line)
		
		# busca una coincidencia
		elif line.size() >= 2: # para buscar despues del ID
#			search = "hou"
			if str(line[1]).find(search,0) >= 0: 
#				print("Search: ",line[1],"|",str(line[1]).find(search,0))
				search_result.append(line)


	file.close()
#	print( load_json_param("house") )

	return search_result




func save_csv_to_json(csv_path):
	
	var file: File = File.new()
	file.open(csv_path, File.READ)
	
	
	# CSV to JSON
	var id_var = Array()
	var array_var = Array()
	var json_parse = ""
	
	var loading = 0
	while not file.eof_reached():
		line = file.get_csv_line(",")
		# CSV to JSON
		array_var = []
		id_var = Array(line)
		
		# coloca comillas a los datos del array
		for v in id_var:
			array_var.append('"'+v+'"')
		
		if id_var.size() > 1: # si hay datos en la linea
			data_string = data_string + '\n"'+id_var[1]+'": '+str(array_var)+","
			json_parse = "{ "+str(data_string)+" }"
			
			
		loading = loading+1
#		print("Loading csv: ",loading)
		
	# SAVE JSON
	var JSON_file_save = File.new()
	JSON_file_save.open(JSON_path, File.WRITE)
	JSON_file_save.store_string(str(json_parse))
	JSON_file_save.close()
#	print(str(json_parse))

	file.close()
#	print( load_json_param("house") )

	return ["CSV_to_JSON: Done"]
	
	
	




func save_to_json(JSON_path,dicc_param):
	
	# var file: File = File.new()
	# file.open(param, File.READ)
	
	
	# CSV to JSON
	# var id_var = Array()
	var array_var = Array()
	var json_parse = ""
	
	# var loading = 0
	# while not file.eof_reached():
	# 	line = file.get_csv_line(",")
	# 	# CSV to JSON
	# 	array_var = []
	# 	id_var = Array(line)
	print(dicc_param)
	# coloca comillas a los datos del array
	for dat in dicc_param:
#		dat = '"'+dat+'"'
		print(dat)
		data_string = data_string + '"'+dat+'": '+str(dicc_param[dat])+","
		
	json_parse = "{ "+str(data_string)+" }"
		
			
		
	# SAVE JSON
	var JSON_file_save = File.new()
	JSON_file_save.open(JSON_path, File.WRITE)
	JSON_file_save.store_string(str(json_parse+"\n"))
	JSON_file_save.close()
#	print(str(json_parse))

#	print( load_json_param("house") )

	return ["Save_to_JSON: Done to: ",JSON_path]






func create_configfile(path,table_name,field_array):
	
	var config = ConfigFile.new()
	var err = config.load(path)
	if err == OK: # If not, something went wrong with the file loading
		return ["DB_configfile exist on: ",path]
		pass
	
	# agrega el field ID si no esta
	if field_array[0] != "id":
		field_array.insert(0,"id")

	# SAVE CONFIGFILE
	if not config.has_section_key(table_name, "id" ):
		config.set_value(table_name, "id", str(field_array).replace(", ",",").replace("[","").replace("]",""))
		config.save(path)
		return ["create_configfile on: ",path]

		




func add_user(table_name,path,field_array):
	
	var config = ConfigFile.new()
	var err = config.load(path)
	if err == OK: # If not, something went wrong with the file loading
		pass
	
	# SAVE CONFIGFILE
	if not config.has_section_key(table_name, field_array[0] ):
		config.set_value(table_name, field_array[0], str(field_array).replace(", ",",").replace("[","").replace("]",""))
		config.save(path)
		return ["add_user: Done ",field_array,"TRUE"]
	else:
		return ["add_user ERROR: ",field_array[0]+" already exist","FALSE"]
	



func save_csv_to_configfile(table_name,csv_path,path,delimit,field_index):
	
	var file: File = File.new()
	file.open(csv_path, File.READ)
	
	# SAVE CONFIGFILE
	var config = ConfigFile.new()
	var err = config.load(path)
	
	if err == OK: # If not, something went wrong with the file loading
		return ["CSV_to_configfile :",path,"Exist ","TRUE"]
	
	
	else:
		var loading = 0
		while not file.eof_reached():
			line = file.get_csv_line(delimit)
			if line.size() >= 2:
				# print(line)
				# SAVE CONFIGFILE
				if not config.has_section_key(table_name, str(line[0]) ):
					if line[0] == "id":
						config.set_value(table_name, "id", str(line).replace(", ",",").replace("[","").replace("]",""))
					else:
						config.set_value(table_name, str(line[field_index]), str(line).replace(", ",",").replace("[","").replace("]",""))
		
					loading = loading+1
					
		config.save(path)
		file.close()
		print("CSV_to_configfile: CREATED")
		return ["CSV_to_configfile :",path," created ","TRUE"]
	
		# print("err: config.load(path) ",err) # 7= no existe, 0=existe
	
	
	
	


func load_json_param(path,param):

	# LOAD JSON
	var JSON_path = path # "res://examples/file.json"
	var JSON_file_load: File = File.new()
	JSON_file_load.open(JSON_path, File.READ)
	var json = JSON.parse(JSON_file_load.get_as_text())
	
	return json.result[str(param)]




func load_json_array(path):

	# LOAD JSON
	var JSON_path = path #"res://examples/file.json"
	var JSON_file_load: File = File.new()
	JSON_file_load.open(JSON_path, File.READ)
	
	# LOAD ARRAY FROM JSON
	var line_to_array = []
	var line_index: int = -1
	while not JSON_file_load.eof_reached():
		line_index += 1
		var line: Array = JSON_file_load.get_csv_line(",")
		if line_index >= 2:
			line_to_array.append(line)
			
#	print(line_to_array)
#	print(line_to_array[0][2])
	return line_to_array
	
	
	
	
	
	
	
func save_configFile(path,table_name,key,dicc_param):
	
	# SAVE CONFIGFILE
	var config = ConfigFile.new()
	var err = config.load(path)
	if err == OK: # If not, something went wrong with the file loading
		pass
	
	var autoincrement = 0
	autoincrement = int(get_configFile_DB_total(table_name,path))+1

	if key == "auto":
		key = autoincrement
		
	var string_data = []
	string_data.append(autoincrement) # agrega el id autoincrement al array | no requiere enviar id en el param dicc

	for dat in dicc_param:
		string_data.append(dicc_param[dat])

#	if not config.has_section_key(param[0],param[1]):
	config.set_value(table_name,str(key),str(string_data).replace("[","").replace("]",""))
	config.save(path)

	return ["save_configFile to: ",path]
	


func save_dict_configFile(path,table_name,key,dicc_param):
	
	# SAVE CONFIGFILE
	var config = ConfigFile.new()
	var err = config.load(path)
	if err == OK: # If not, something went wrong with the file loading
		pass

	config.set_value(table_name,str(key),dicc_param)
	config.save(path)
	return {"save_path":path,"save_dict":true}




func update_configFile(path,table_name,data_id,dicc_param): # dicc_param = arreglo dicc
	
#	print("update_configFile: ",path,table_name,dicc_param)

	# config.load(path)
	var config = ConfigFile.new()
	var err = config.load(path)
	if err == OK: # If not, something went wrong with the file loading
		pass

	result = (config.get_value(table_name, "id", true))


	# DECLARA LOS FIELD PARA LAS CONSULTAS
	var fields = {}
	var count = 0
	var json_parse = ""
	var data_string = " "
	for field in result.split(","):
		fields[field] = count # posicion de cada field
		count += 1
		# print("fields: ",fields)
	#-------------------------



	# CREAR DICC PARA ACTUALIZAR DATOS NUEVOS
	var data_update = {}
	var field_data = []
	var line = config.get_value(table_name, data_id, true).split(",")
	# print("line update: ",line)
	
	if line[0] != "id":
		for data in line.size():
			for field in fields:
				field_data.append(field)

			data_update[field_data[data]] = line[data]
	# -----------------------------------
	for field in result.split(","):
		# actuliza los campos diferentes
		if dicc_param.has(field) and data_update.has(field):
			if str(data_update[field]) != str(dicc_param[field]):
				data_update[field] = dicc_param[field]
	# -----------------------------------
		# print(field," - ",dicc_param.has(field)," | ",data_update.has(field))
	
	# --- save data
	var string_data = []
	for dat in data_update:
		string_data.append(data_update[dat])
	
	string_data = str(string_data).replace("[","").replace("]","").replace(", ",",")

	if config.has_section(table_name):
		config.set_value(table_name,data_id,string_data)
		config.save(path)
	
	else:
		result = "ERROR: No table_name "+table_name+" in DB"
		return result
	# --- end save data


	# ARREGLA RESULT COMO DICC
	var dicc_result_line = {}
	var field_data_cons = []
	var line_cons = config.get_value(table_name, data_id, true).split(",")
#	print(line)
	
	if line_cons[0] != "id":
		for data in line_cons.size():
			for field in fields:
				field_data_cons.append(field)

			dicc_result_line[field_data_cons[data]] = line_cons[data]
	# -----------------------------------

	result = dicc_result_line
	
	return result





func erase_configFile(path,param):
	
	# config.load(path)
	var config = ConfigFile.new()
	var err = config.load(path)
	if err == OK: # If not, something went wrong with the file loading
		pass
	
	
		# DEL key
	if param[1] != "":
		if config.has_section_key(param[0],param[1]):
			config.erase_section_key(param[0], param[1])
			
	# DEL param["section"]
	elif param[1] == "" and param[0] != "":
		if config.has_section(param[0]):
			config.erase_section(param[0])
			
	config.save(path)

	return "erase_configFile DONE"







func get_configFile_DB_total(table_name,path):
	
	# config.load(path)
	var config = ConfigFile.new()
	var err = config.load(path)
	if err == OK: # If not, something went wrong with the file loading
		# print("ERROR: Config load: ",path)
		pass
		
	if config.has_section(table_name):
		var total = config.get_section_keys(table_name).size()
		print("get_configFile_DB_total: ",total)
		return int(total)-1





func dicc_query(table_name,path,param):
	# buscar TODO los index de la DB sin where | tambien por id
	
	var config = ConfigFile.new()
	var err = config.load(path)
	if err == OK: # If not, something went wrong with the file loading
		pass

	var array_index = []
	var query = {}
	var fields = {}
	
	result = (config.get_value(table_name, param["id_field"], true))
	# print("result: ",result)
	
	# DECLARA LOS FIELD PARA LAS CONSULTAS
	var count = 0
	var json_parse = ""
	var data_string = " "
	for field in result.split(","):
		fields[field] = count
		count += 1
		# print("fields: ",fields)
	#-------------------------


	if param["search"] == "*" and param["where"] == []:
		if config.has_section(table_name): 
			# busca pos de param["section"]
			if param["section"] != "*":
				for i in range(0,Array(config.get_value(table_name, "id", true).split(",")).size() ):
					if Array(config.get_value(table_name, "id", true).split(",") ).has(param["section"]):
						if param["section"] == Array(config.get_value(table_name, "id", true).split(",") )[i]:
							pos_section = i
					else:
						result = "ERROR: No field: "+'"'+param["section"]+'"'
						break
			
			
			if param["section"] == "*" and param["id"] == "*":
				var dicc_result_line = []
				for index in config.get_section_keys(table_name):
					if index != "id":
						dicc_result_line.append( config.get_value(table_name, index, true) ) #.split(",",true)
				if dicc_result_line.size() > 0:
					result = dicc_result_line
				else:
					result = null

			elif param["section"] == "*" and param["id"] != "*":
				result = config.get_value(table_name, config.get_section_keys(table_name)[int(param["id"])], true)


		else:
			# print("RESULT_QUERY: ",result)
			result = null


	if param["search"] != "*" and param["where"] == []:
		if config.has_section_key(table_name, param["search"]):
			result = config.get_value(table_name, param["search"], true)
			
#		elif not config.has_section_key(table_name, param["search"]):
##			var result_search = []
#			for index in config.get_section_keys(table_name): # recorre las lineas
#				if config.get_value(table_name, index, true).find(param["search"],0) >= 0: # busca una cadena en el index
#					result_search.append(config.get_value(table_name, index, true).split(",")[pos_section])
#					result = result_search
					
		else:
			# print("RESULT_QUERY: ",result)
			result = null
		
#		print(result[0])

	# print("RESULT_QUERY: ",result)
	query["result"] = result
	query["fields"] = fields
	return query








func conf_query(table_name,path,param):
	# print("conf_query: ",table_name,path)

	var config = ConfigFile.new()
	var db_exist = config.load(path)
	if db_exist != OK: # no existe la DB
		return null
		pass




	if !param.has("id_field") or param["id_field"] == "":
		param["id_field"] = "id"

	if config.has_section(table_name):
#		print("where:",where[0].split(",")[0])
		
		if param["section"] == "*" and param["search"] == "*" and param["where"] == []:
			print("DB_get_all_index()")
			return DB_get_all_index(table_name,path,param)
			
		if param["section"] == "*" and param["search"] != "*" and param["id"] == "*" and param["where"] == []:
			print("DB_get_all_search_index()")
			return DB_get_all_search_index(table_name,path,param)
			
		if param["section"] != "*" and param["search"] != "*" and param["id"] == "*" and param["where"] == []:
			print("DB_get_section_and_search()")
			return DB_get_section_and_search(table_name,path,param)
		
		if param["section"] != "*" and param["search"] == "*" and param["id"] == "*" and param["where"] == []:
			print("DB_get_all_index()")
			return DB_get_all_index(table_name,path,param)
			
		if param["section"] != "*" and param["search"] == "*" and param["id"] != "*" and param["where"] == []:
			print("DB_get_all_index()")
			return DB_get_all_index(table_name,path,param)
			
		if  param["where"] != []:
			print("DB_get_where()")
			return DB_get_where(table_name,path,param)
			
		pass



func DB_get_all_search_index(table_name,path,param):

	var config = ConfigFile.new()
	var err = config.load(path)
	if err == OK: # If not, something went wrong with the file loading
		pass

	var array_index = []
	var query = {}
	var fields = {}
	
	result = (config.get_value(table_name, param["id_field"], true))
#	print("result: ",path)
	
	# DECLARA LOS FIELD PARA LAS CONSULTAS
	var count = 0
	var json_parse = ""
	var data_string = " "
	for field in result.split(","):
		fields[field] = count
		count += 1
		# print("fields: ",fields)
	#-------------------------

	# buscar todo sin SECTION | solo busqueda exacta en index
	if config.has_section_key(table_name, param["search"]):

		# CREAR RESULT COMO DICC
		# print("CONSULT: TABLENAME: ",table_name," SEARCH: ",search)
		query["EXIST"] = "TRUE"
		
		# CREAR RESULT COMO DICC
		var dicc_result_line = {}
		var field_data = []
		var line = config.get_value(table_name, param["search"], true).split(",")
#		print(line)
		if line[0] != param["id_field"]:
			for data in line.size():
				for field in fields:
					field_data.append(field)
				dicc_result_line[field_data[data]] = line[data]
			array_index.append(dicc_result_line)
		result = array_index
	# -----------------------------------
		
	elif not config.has_section_key(table_name, param["search"]):
		query["EXIST"] = "FALSE"
		print("CONSULT - SEARCH NO EXIST: ",param["search"])
	
	else:
		# print("RESULT_QUERY: ",result)
		result = null
		
	query["result"] = result
	query["fields"] = fields
	return query



func DB_get_section_and_search(table_name,path,param):
	
	var config = ConfigFile.new()
	var err = config.load(path)
	if err == OK: # si existe
#		print("DB: OK")
		pass
		
	# buscar una param["section"] | solo busqueda exacta en index
	if param["section"] != "*" and param["search"] != "*":
		# BUSCA EL TIPO DE SECTION para WHERE
		for i in range(0,Array(config.get_value(table_name, "id", true).split(",")).size() ):
			if Array(config.get_value(table_name, "id", true).split(",") ).has(param["section"]):
				if param["section"] == Array(config.get_value(table_name, "id", true).split(",") )[i]:
					pos_section = i
#						print(i)
			else:
				result = "ERROR: No field: "+'"'+param["section"]+'"'
				return result
				break
				
		if config.has_section_key(table_name, param["search"]):
			result = config.get_value(table_name, param["search"], true).split(",")[pos_section]
			
		elif not config.has_section_key(table_name, param["search"]):
#			var result_search = []
			for index in config.get_section_keys(table_name): # recorre las lineas
				if config.get_value(table_name, index, true).find(param["search"],0) >= 0: # busca una cadena en el index
					result_search.append(config.get_value(table_name, index, true).split(",")[pos_section])
					result = result_search
#			print( "ERROR: NO: "+param["search"]+" on INDEX" )
			
#		print("Buscar INDEX CON param["section"]: ", result )


	return result




func DB_get_all_index(table_name,path,param):#=======================
	# buscar TODO los index de la DB sin where | tambien por id
	
	var config = ConfigFile.new()
	var err = config.load(path)
	if err == OK: # If not, something went wrong with the file loading
		pass

	var array_index = []
	var query = {}
	var fields = {}
	
	result = (config.get_value(table_name, param["id_field"], true))
	# print("result: ",result)
	
	# DECLARA LOS FIELD PARA LAS CONSULTAS
	var count = 0
	var json_parse = ""
	var data_string = " "
	for field in result.split(","):
		fields[field] = count
		count += 1
		# print("fields: ",fields)
	#-------------------------


	if param["search"] == "*" and param["where"] == []:
		if config.has_section(table_name): 
			# busca pos de la param["section"]
			if param["section"] != "*":
				for i in range(0,Array(config.get_value(table_name, "id", true).split(",")).size() ):
					if Array(config.get_value(table_name, "id", true).split(",") ).has(param["section"]):
						if param["section"] == Array(config.get_value(table_name, "id", true).split(",") )[i]:
							pos_section = i
					else:
						result = "ERROR: No field: "+'"'+param["section"]+'"'
						break
			
			if param["section"] != "*" and param["id"] == "*": # todos filtrados por param["section"]
				result_search = []
				for index in config.get_section_keys(table_name): # recorre las lineas
					result_search.append(config.get_value(table_name, index, true).split(",")[pos_section])
					result = result_search
#						print(config.get_value(table_name, index, true).split(",")[pos_section])
					
					# CREAR RESULT COMO DICC
#					for index in config.get_section_keys(table_name):
					var dicc_result_line = {}
					var field_data = []
					var line = result
#					print(line)
					if line[0] != param["id_field"]:
						for data in line.size():
							for field in fields:
								field_data.append(field)
							dicc_result_line[field_data[data]] = line[data]
						array_index.append(dicc_result_line)
				result = array_index
				# -----------------------------------
			
			elif param["section"] == "*" and param["id"] == "*":

# 				# CREAR RESULT COMO DICC
				for index in config.get_section_keys(table_name):
					var dicc_result_line = {}
					var field_data = []
					var line = config.get_value(table_name, index, true).split(",")
#					print(line)
					if line[0] != param["id_field"]:
						for data in line.size():
							for field in fields:
								field_data.append(field)
							dicc_result_line[field_data[data]] = line[data]
							# print(line[data])
						array_index.append(dicc_result_line)
				result = array_index
				# -----------------------------------

				
	
			elif param["section"] == "*" and param["id"] != "*":

				result = config.get_value(table_name, config.get_section_keys(table_name)[int(param["id"])], true).split(",")

# 				# CREAR RESULT COMO DICC
				for index in config.get_section_keys(table_name):
					var dicc_result_line = {}
					var field_data = []
					var line = result
#					print(line)
					if line[0] != param["id_field"]:
						for data in line.size():
							for field in fields:
								field_data.append(field)
							dicc_result_line[field_data[data]] = line[data]
						array_index.append(dicc_result_line)
				result = array_index
				# -----------------------------------

			
			elif param["section"] != "*" and param["id"] != "*":
				result = config.get_value(table_name, config.get_section_keys(table_name)[int(param["id"])], true).split(",")[pos_section]
				# CREAR RESULT COMO DICC
				for index in config.get_section_keys(table_name):
					var dicc_result_line = {}
					var field_data = []
					var line = result
#					print(line)
					if line[0] != param["id_field"]:
						for data in line.size():
							for field in fields:
								field_data.append(field)
							dicc_result_line[field_data[data]] = line[data]
						array_index.append(dicc_result_line)
				result = array_index
				# -----------------------------------


		else:
			# print("RESULT_QUERY: ",result)
			result = null
			return query

#		print(result[0])

		# print("RESULT_QUERY: ",result)
		query["result"] = result
		query["fields"] = fields
		return query


func DB_get_where(table_name,path,param):
	# print("DB_get_where: ",table_name,param)
	
	var config = ConfigFile.new()
	var err = config.load(path)
	if err == OK: # si existe
#		print("DB: OK")
		pass
		
	var array_index = []
	var query = {}
	var fields = {}
	
	result = config.get_value(table_name, param["id_field"], true)

	# DECLARA LOS FIELD PARA LAS CONSULTAS
	var count = 0
	var json_parse = ""
	var data_string = " "
	for field in result.split(","):
		fields[field] = count
		count += 1
		# print("fields: ",fields)
	#-------------------------


	# consulta con condicion where
	if param["where"] != []:
		
		# BUSCA UBICACION DEL ID para WHERE Y SECTION
		if param["section"] != "*":
			for i in range(0,Array(config.get_value(table_name, "id", true).split(",")).size() ): # recorre la linea de id
				# busca param["section"] del param
				if Array(config.get_value(table_name, "id", true).split(",") ).has(param["section"]): # si la linea contiene la section
					if param["section"] == Array(config.get_value(table_name, "id", true).split(",") )[i]:
						pos_section = i
				else:
					result = "ERROR: No field: "+'"'+param["section"]+'"'
					return result
#					break
	
	
	
#		for where in param["where"]:

		

	
		# consulta busqueda con condicion where
		if param["search"] != "*":
			# con WHERE encuentra la frase exacta
			if config.has_section_key(table_name, param["search"]):
				var section_where = config.get_value(table_name, param["search"], true).split(",")[i_where]
				
				if param["section"] == "*":
					if param["where"][0].split(",")[1] == "==": # tipo de condicion where
						if section_where == param["where"][0].split(",")[2]:
							result_where_search = config.get_value(table_name, param["search"], true).split(",") 
#				
				elif param["section"] != "*":
					if param["where"][0].split(",")[1] == "==": # tipo de condicion where
						if section_where == param["where"][0].split(",")[2]:
							result_where_search = config.get_value(table_name, param["search"], true).split(",")[pos_section] 
							
				result = result_where_search



			# con WHERE si no encuentra la frase exacta busca una coincidencia
			elif not config.has_section_key(table_name, param["search"]):
#				var result_search = []
				for index in config.get_section_keys(table_name):
					if index.find(param["search"],0) >= 0: # busca una cadena en el index
						var section_where = config.get_value(table_name, index, true).split(",")[i_where]
						
						if param["where"][0].split(",")[1] == "==": # tipo de condicion where
							if section_where == param["where"][0].split(",")[2]:
								result_search.append( config.get_value(table_name, index, true).split(",") )
						
						elif param["where"][0].split(",")[1] == "!=": # tipo de condicion where
							if section_where != param["where"][0].split(",")[2]:
								result_search.append( config.get_value(table_name, index, true).split(",") )
			
#				print("WHERE_search_NO | coincidence: ", result)
			
				result = result_search
			
			
			
			
		# consulta sin busqueda con condicion where
		elif param["search"] == "*":
			
			if config.has_section(table_name):
				result_where_search = []
				var validate_where_type = []
				var validate_where = []
				var conditional = ""
				var conditional_param = ""
						
				for index in config.get_section_keys(table_name): # recorre los registros de la DB
					
					if index != param["id_field"]:
						for where in param["where"]:
	#						print(where)
							for i in range(0,Array(config.get_value(table_name, "id", true).split(",")).size() ):
								# busca la pos de la section en la linea para consultarla
								if where.split(",")[0] != "and" or where.split(",")[0] != "or":
									if where.split(",")[0] == Array(config.get_value(table_name, "id", true).split(",") )[i]:
										i_where = i # pos del section where
	#								print(where.split(",")[0],"--",i_where)
										
								if where.split(",")[0] == "and" or where.split(",")[0] == "or":
									if where.split(",")[1] == Array(config.get_value(table_name, "id", true).split(",") )[i]:
										i_where = i # pos del section where
	#								print(where.split(",")[1],"--",i_where)
						
							var var_section_where = config.get_value(table_name, index, true).split(",")[i_where]
							
							
							
							
							if param["section"] != "*": # busca solo una seccion de la linea
						
					
								# define la section y el valor de la condicion solicitada
								if where.split(",")[0] != "and" or where.split(",")[0] != "or":
									conditional = where.split(",")[1]
									conditional_param = where.split(",")[2]
									
								elif where.split(",")[0] == "and" or where.split(",")[0] == "or":
									conditional = where.split(",")[2]
									conditional_param = where.split(",")[3]
								
								# compara segun la peticion
								if conditional == "==": # tipo de condicion
									if var_section_where == conditional_param:
										result_where_search.append( config.get_value(table_name, index, true).split(",")[pos_section] )
										
								if conditional == "!=": # tipo de condicion
									if var_section_where != conditional_param:
										result_where_search.append( config.get_value(table_name, index, true).split(",")[pos_section] )


							elif param["section"] == "*": # busca toda la linea
								
	#							print(var_section_where,"--",conditional_param)
	#							print(config.get_value(table_name, index, true).split(",")[0],"--",var_section_where,"--",conditional_param)
				
								if where.split(",")[0] != "and" or where.split(",")[0] != "or":
#									if where.split(",")[0] != "or":
									conditional = where.split(",")[1]
									conditional_param = where.split(",")[2]
										
#									elif where.split(",")[0] == "or":
#										conditional = where.split(",")[2]
#										conditional_param = where.split(",")[3]
										
#									print(var_section_where,"--",conditional_param)
									
									if conditional == "==": # tipo de condicion
										if var_section_where == conditional_param:
											validate_where.append(1)
											validate_where_type.append("all")
#											print("== ",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
										
									if conditional == "!=": # tipo de condicion
										if var_section_where != conditional_param:
											validate_where.append(1)
											validate_where_type.append("all")
#											print("!= ",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
									
									if conditional == ">": # tipo de condicion
#										print(var_section_where,conditional_param)
										if int(var_section_where) > int(conditional_param):
											validate_where.append(1)
											validate_where_type.append("all")
#											print("> ",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
								
									if conditional == ">=": # tipo de condicion
#										print(var_section_where,conditional_param)
										if int(var_section_where) >= int(conditional_param):
											validate_where.append(1)
											validate_where_type.append("all")
#											print(">= ",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
								
									if conditional == "<": # tipo de condicion
#										print(var_section_where,conditional_param)
										if int(var_section_where) < int(conditional_param):
											validate_where.append(1)
											validate_where_type.append("all")
#											print("< ",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
								
									if conditional == "<=": # tipo de condicion
#										print(var_section_where,conditional_param)
										if int(var_section_where) <= int(conditional_param):
											validate_where.append(1)
											validate_where_type.append("all")
#											print("<= ",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
								
#									print(param["where"].size(),"--",validate_where.size(),"--",config.get_value(table_name, index, true).split(",")[0])
								
								
								
								if where.split(",")[0] == "and":
	#								print(where,"--",i_where)
									
									conditional = where.split(",")[2]
									conditional_param = where.split(",")[3]
#									print(var_section_where,"--",conditional_param)
									
									if conditional == "==": # tipo de condicion
										if var_section_where == conditional_param:
											validate_where.append(1)
											validate_where_type.append("and")
#											print("and == ",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
										
									if conditional == "!=": # tipo de condicion
										if var_section_where != conditional_param:
											validate_where.append(1)
											validate_where_type.append("and")
#											print("and != ",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
									
									if conditional == ">": # tipo de condicion
#										print(var_section_where,conditional_param)
										if int(var_section_where) > int(conditional_param):
											validate_where.append(1)
											validate_where_type.append("and")
#											print("and > ",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
									
									if conditional == ">=": # tipo de condicion
#										print(var_section_where,conditional_param)
										if int(var_section_where) >= int(conditional_param):
											validate_where.append(1)
											validate_where_type.append("and")
#											print("and >= ",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
									
									if conditional == "<": # tipo de condicion
#										print(var_section_where,conditional_param)
										if int(var_section_where) < int(conditional_param):
											validate_where.append(1)
											validate_where_type.append("and")
#											print("and < ",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
									
									if conditional == "<=": # tipo de condicion
#										print(var_section_where,conditional_param)
										if int(var_section_where) <= int(conditional_param):
											validate_where.append(1)
											validate_where_type.append("and")
#											print("and <= ",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
									
									
									

								
										

								if where.split(",")[0] == "or":
	#								print(where,"--",i_where)
									
									conditional = where.split(",")[2]
									conditional_param = where.split(",")[3]
#									print(var_section_where,"--",conditional_param)
									
									if conditional == "==": # tipo de condicion
										if var_section_where == conditional_param:
											if not result_where_search.has(config.get_value(table_name, index, true).split(",")):
												result_where_search.append( config.get_value(table_name, index, true).split(",") )
#											print("or ==",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
										
									if conditional == "!=": # tipo de condicion
										if var_section_where != conditional_param:
											if not result_where_search.has(config.get_value(table_name, index, true).split(",")):
												result_where_search.append( config.get_value(table_name, index, true).split(",") )
#											print("or !=",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
									
									if conditional == ">": # tipo de condicion
#										print(var_section_where,conditional_param)
										if int(var_section_where) > int(conditional_param):
											if not result_where_search.has(config.get_value(table_name, index, true).split(",")):
												result_where_search.append( config.get_value(table_name, index, true).split(",") )
#											print("or >",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
									
									if conditional == ">=": # tipo de condicion
#										print(var_section_where,conditional_param)
										if int(var_section_where) >= int(conditional_param):
											if not result_where_search.has(config.get_value(table_name, index, true).split(",")):
												result_where_search.append( config.get_value(table_name, index, true).split(",") )
#											print("or >=",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
									
									if conditional == "<": # tipo de condicion
#										print(var_section_where,conditional_param)
										if int(var_section_where) < int(conditional_param):
											if not result_where_search.has(config.get_value(table_name, index, true).split(",")):
												result_where_search.append( config.get_value(table_name, index, true).split(",") )
#											print("or <",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
									
									if conditional == "<=": # tipo de condicion
#										print(var_section_where,conditional_param)
										if int(var_section_where) <= int(conditional_param):
											if not result_where_search.has(config.get_value(table_name, index, true).split(",")):
												result_where_search.append( config.get_value(table_name, index, true).split(",") )
#											print("or <=",config.get_value(table_name, index, true).split(",")[0],": ",var_section_where,"--",conditional_param)
									
									
						# valida las condiciones and
						if param["where"].size() == validate_where.size():
							if not result_where_search.has(config.get_value(table_name, index, true).split(",")):
								result_where_search.append( config.get_value(table_name, index, true).split(",") )
						
						validate_where = []
										
										
						# valida las condiciones and
						if !validate_where_type.has("and") and validate_where_type.has("all") and param["where"].size() == validate_where_type.size():
							if not result_where_search.has(config.get_value(table_name, index, true).split(",")):
								result_where_search.append( config.get_value(table_name, index, true).split(",") )
						
#							validate_where = []
						validate_where_type = []
							

										
#						
						
					
					result = result_where_search
						
					


					


			# CREAR RESULT COMO DICC
			for index in result_where_search:
				var dicc_result_line = {}
				var field_data = []
				var line = index
	#					print(line)
				if line[0] != param["id_field"]:
					for data in line.size():
						for field in fields:
							field_data.append(field)
						dicc_result_line[field_data[data]] = line[data]
					array_index.append(dicc_result_line)
				result = array_index
				# print("DB_get_where NO search: ", result)
				
			# -----------------------------------
		
		


	query["result"] = result
	query["fields"] = fields
	return query
















func fecha_dma(fecha):
	# --- formatear fecha a: d/m/a desde Y-m-d (2020-01-01)---
	var fecha_dma = fecha.split("-")
	fecha_dma.invert()
	var year = fecha_dma[2]
	year.erase(0,2)
	fecha_dma.remove_and_collide(2) 
	fecha_dma.append(year)
	fecha_dma = fecha_dma[0]+"/"+fecha_dma[1]+"/"+fecha_dma[2]
	return fecha_dma
	# -------------------

func _fecha_Ymd(datetime):
	# --- formatear fecha a: Y-m-d (2020-01-01) DESDE Datetime 2020-04-26 00:18:41---
	var fecha_Ymd = datetime.split(" ")
	return fecha_Ymd[0]
	# -------------------


func _hoy_datetime():
	var hoy = OS.get_datetime(0)
	var mes = ""
	var dia = ""
	var hora = ""
	var minu = ""
	var seg = ""

	if str(hoy["month"]).length() == 1:
		mes = "0"+str(hoy["month"])
	else:
		mes = str(hoy["month"])
	
	if str(hoy["day"]).length() == 1:
		dia = "0"+str(hoy["day"])
	else:
		dia = str(hoy["day"])
	
	if str(hoy["hour"]).length() == 1:
		hora = "0"+str(hoy["hour"])
	else:
		hora = str(hoy["hour"])

	if str(hoy["minute"]).length() == 1:
		minu = "0"+str(hoy["minute"])
	else:
		minu = str(hoy["minute"])
	
	if str(hoy["second"]).length() == 1:
		seg = "0"+str(hoy["second"])
	else:
		seg = str(hoy["second"])
	


	hoy = str(hoy["year"])+"-"+mes+"-"+dia+" "+hora+":"+minu+":"+seg
	return hoy
	
	# (day:26), (dst:False), (hour:0), (minute:20), (month:4), (second:36), (weekday:0), (year:2020)
#	2020-04-26 00:18:41


func _hoy_date():
	var hoy = OS.get_datetime(0)
	var mes = ""
	var dia = ""

	if str(hoy["month"]).length() == 1:
		mes = "0"+str(hoy["month"])
	else:
		mes = str(hoy["month"])
	
	if str(hoy["day"]).length() == 1:
		dia = "0"+str(hoy["day"])
	else:
		dia = str(hoy["day"])

	hoy = str(hoy["year"])+"-"+mes+"-"+dia
	return hoy


func _hora(datetime):
	var hora = datetime.split(" ")
	hora = hora[1].split(":")
	hora = hora[0]+":"+hora[1]
	return hora
