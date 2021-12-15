extends Node

var scroll_top = 1

var config = ConfigFile.new()
var result = ""
var result_search = Array()
var result_where_search = Array()
var pos_section = 0
var i_where = 0

var file_path = "res://examples/file.txt"
var conf_path = "res://DB/vocabulario.cfg"
var csv_path = "res://DB/vocabulario.csv"
var JSON_path = "res://examples/file.json"

var line = []

var data_string = " "



# This is a valid dictionary.
# To access the string "Nested value" below, use `my_dir.sub_dir.sub_key` or `my_dir["sub_dir"]["sub_key"]`.
# Indexing styles can be mixed and matched depending on your needs.
var my_dict = {
	"house": ["casa","jaus"],
	"car": "carro",
	"horse": "caballo",
	"hour": "hora",
	"sub_dict": {"sub_key": "Nested value"},
}




func _ready():

	
#	my_dict["house"] = "hogar" # asigna valor
#	print(my_dict["house"]) # imprime el valor de la var


#	print( $"/root/FuncApp".save_csv_to_json("res://examples/file.csv") )
	
#	print( $"/root/FuncApp".save_csv_to_configfile(csv_path",conf_path",",",1) )

#	print( $"/root/FuncApp".load_csv("res://examples/file.csv", "*") )
	
#	print( $"/root/FuncApp".load_json_param("res://examples/file.json","horse") )
#	print( $"/root/FuncApp".load_json_array("res://examples/file.json") )
	
	var param = ["tablename", "key", "valor,valor2,valo3"]
#	print( $"/root/FuncApp".save_configFile(conf_path,param) )
#	print( $"/root/FuncApp".erase_configFile(conf_path,param) )
	
	
	# CONSULTA SIN PARAMETROS O CON ID: IMPRIME SOLO INDEX
	var section = "*" # default *
	var search = "*" # default *
	var ID_ = "*" # alone no section no search | default *
	var where = [] # format["active,==,0"] | deafault []
	
#	var result_cfg = $"/root/FuncApp".get_configFile(section,search,ID_,where) # get_configFile("section","search","id",[where:"active,==,1"])
#	print("get_configFile_DB_total: ",$"/root/FuncApp".get_configFile_DB_total())
	# =======
	
	
	
#	var store_var: Array =  [6,"DDDDD","perro","dog","animal; mascota"]
#	print( $"/root/FuncApp".save_to_csv("res://examples/demoData.csv", store_var) )
	
	
	# SAVE CONFIGFILE
	var err = config.load(conf_path)
	if err == OK: # If not, something went wrong with the file loading
		pass
		
	
	pass




func save_to_csv(path, param):
	
	# SAVE TO CSV
	var file_store: File = File.new()
	file_store.open(path, 3) # flags 3 = READ_WRITE
	
	var store_var: PoolStringArray = param
#	store_var.push_back("\n")
	file_store.seek_end()
	file_store.store_csv_line(store_var,",")
	file_store.close()

	return "CSV saved"



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
	
	
	




func save_csv_to_configfile(csv_path,conf_path,delimit,index_field):
	
	var file: File = File.new()
	file.open(csv_path, File.READ)
	
	# SAVE CONFIGFILE
	var config = ConfigFile.new()
	var err = config.load(conf_path)
	if err == OK: # If not, something went wrong with the file loading
		pass
	
	var loading = 0
	
	while not file.eof_reached():
		line = file.get_csv_line(delimit)
		if line.size() >= 2:
#			print(line)
			# SAVE CONFIGFILE
			if not config.has_section_key("CONF", str(line[0]) ):
				if line[0] == "id":
					config.set_value("CONF", "id", str(line).replace(", ",",").replace("[","").replace("]",""))
				else:
					config.set_value("CONF", str(line[index_field]), str(line).replace(", ",",").replace("[","").replace("]",""))
	
				loading = loading+1
#				print("Loading csv: ",line[1])
				
	config.save(conf_path)
	file.close()
	return ["CSV_to_configfile: Done: ",loading]
	
	
	
	


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
	
	
	
	
	
	
	
func save_configFile(conf_path,param):
	
#	var param = ["CONF", "key", "valor"]
	
	# SAVE CONFIGFILE
	var config = ConfigFile.new()
	var err = config.load(conf_path)
	if err == OK: # If not, something went wrong with the file loading
		pass
	
#	if not config.has_section_key(param[0],param[1]):
	config.set_value(param[0],param[1],param[2])
	config.save(conf_path)

	return "save_configFile"
	



func erase_configFile(conf_path,param):
	
	var config = ConfigFile.new()
	var err = config.load(conf_path)
	if err == OK: # If not, something went wrong with the file loading
		pass
	
	
		# DEL key
	if param[1] != "":
		if config.has_section_key(param[0],param[1]):
			config.erase_section_key(param[0], param[1])
			
	# DEL section
	elif param[1] == "" and param[0] != "":
		if config.has_section(param[0]):
			config.erase_section(param[0])
			
	config.save(conf_path)

	return "erase_configFile"







func get_configFile_DB_total():
	
	var config = ConfigFile.new()
	var err = config.load(conf_path)
	if err == OK: # If not, something went wrong with the file loading
		print("ERROR: Config load: ",conf_path)
		pass
		
	if config.has_section("CONF"):
#		print("get_configFile_total: ",config.get_section_keys("CONF").size())
		return config.get_section_keys("CONF").size()





func get_configFile_DB(section,search,id,where):

	if config.has_section("CONF"):
#		print("where:",where[0].split(",")[0])
		
		if section == "*" and search == "*" and where == []:
			print("DB_get_all_index()")
			return DB_get_all_index(section,search,id,where)
			
		if section == "*" and search != "*" and id == "*" and where == []:
			print("DB_get_all_search_index()")
			return DB_get_all_search_index(section,search,id,where)
			
		if section != "*" and search != "*" and id == "*" and where == []:
			print("DB_get_section_and_search()")
			return DB_get_section_and_search(section,search,id,where)
		
		if section != "*" and search == "*" and id == "*" and where == []:
			print("DB_get_all_index()")
			return DB_get_all_index(section,search,id,where)
			
		if section != "*" and search == "*" and id != "*" and where == []:
			print("DB_get_all_index()")
			return DB_get_all_index(section,search,id,where)
			
		if  where != []:
			print("DB_get_where()")
			return DB_get_where(section,search,id,where)
			
		pass



func DB_get_all_search_index(section,search,id,where):
	# buscar todo sin SECTION | solo busqueda exacta en index
	if section == "*" and search != "*" and  where == [] and config.has_section_key("CONF", search):
		result = config.get_value("CONF", search, true).split(",")

#	# busca coincidencias en el index | ===============================
	elif section == "*" and search != "*" and where == []:
		var index_result = []
		for index in config.get_section_keys("CONF"): # recorre las lineas
			if index.find(search,0) >= 0:
				index_result.append(config.get_value("CONF", index, true).split(","))
##			if config.get_value("CONF", string_line, true).find(search,0) >= 0: # busca una cadena en el index
#				result_search.append( config.get_value("CONF", string_line, true).split(",") )
				result = index_result

#		print( "SEARCH_STRING ALL LINE: " )
		
	return result



func DB_get_section_and_search(section,search,id,where):
	# buscar una section | solo busqueda exacta en index
	if section != "*" and search != "*":
		# BUSCA EL TIPO DE SECTION para WHERE
		for i in range(0,Array(config.get_value("CONF", "id", true).split(",")).size() ):
			if Array(config.get_value("CONF", "id", true).split(",") ).has(section):
				if section == Array(config.get_value("CONF", "id", true).split(",") )[i]:
					pos_section = i
#						print(i)
			else:
				result = "ERROR: No section: "+'"'+section+'"'
				return result
				break
				
		if config.has_section_key("CONF", search):
			result = config.get_value("CONF", search, true).split(",")[pos_section]
			
		elif not config.has_section_key("CONF", search):
			var result_search = []
			for index in config.get_section_keys("CONF"): # recorre las lineas
				if config.get_value("CONF", index, true).find(search,0) >= 0: # busca una cadena en el index
					result_search.append(config.get_value("CONF", index, true).split(",")[pos_section])
					result = result_search
#			print( "ERROR: NO: "+search+" on INDEX" )
			
#		print("Buscar INDEX CON section: ", result )


	return result




func DB_get_all_index(section,search,id,where):#=======================
	# buscar TODO los index de la DB sin where | tambien por id
	if search == "*" and where == []:
		if config.has_section("CONF"): 
			# busca pos de la section
			if section != "*":
				for i in range(0,Array(config.get_value("CONF", "id", true).split(",")).size() ):
					if Array(config.get_value("CONF", "id", true).split(",") ).has(section):
						if section == Array(config.get_value("CONF", "id", true).split(",") )[i]:
							pos_section = i
					else:
						result = "ERROR: No section: "+'"'+section+'"'
						break
			
			if section != "*" and id == "*": # todos filtrados por section
				result_search = []
				for index in config.get_section_keys("CONF"): # recorre las lineas
					result_search.append(config.get_value("CONF", index, true).split(",")[pos_section])
					result = result_search
#						print(config.get_value("CONF", index, true).split(",")[pos_section])
			
			
			elif section == "*" and id == "*":
				var array_index = []
#				for index in range(0,config.get_section_keys("CONF").size()):
				for index in config.get_section_keys("CONF"):
					array_index.append(config.get_value("CONF", index, true)) # esto darda mucho > 1000 datos
#					array_index.append(index)
#					print(index)
				result = array_index
				
			elif section == "*" and id != "*":
				result = config.get_value("CONF", config.get_section_keys("CONF")[int(id)], true).split(",")
			
			elif section != "*" and id != "*":
				result = config.get_value("CONF", config.get_section_keys("CONF")[int(id)], true).split(",")[pos_section]
			
#		print( "DB_get_all_index: ",result )
#				search_word = Array(line)

	
		return result
	
	
	


func DB_get_where(section,search,id,where):
	# consulta con condicion where
	if where != []:
		# BUSCA UBICACION DEL ID para WHERE Y SECTION
		if section != "*":
			for i in range(0,Array(config.get_value("CONF", "id", true).split(",")).size() ):
				# busca section del param section
				if Array(config.get_value("CONF", "id", true).split(",") ).has(section):
					if section == Array(config.get_value("CONF", "id", true).split(",") )[i]:
						pos_section = i
				else:
					result = "ERROR: No section: "+'"'+section+'"'
					return result
					break
				
				if where[0].split(",")[0] == Array(config.get_value("CONF", "id", true).split(",") )[i]:
					i_where = i
					
		elif section == "*":
			for i in range(0,Array(config.get_value("CONF", "id", true).split(",")).size() ):
				# busca section del param where
				if where[0].split(",")[0] == Array(config.get_value("CONF", "id", true).split(",") )[i]:
					i_where = i
	#				print(i)
	
	
		# consulta busqueda con condicion where
		if search != "*":
			# con WHERE encuentra la frase exacta
			if config.has_section_key("CONF", search):
				var section_where = config.get_value("CONF", search, true).split(",")[i_where]
				
				if section == "*":
					if where[0].split(",")[1] == "==": # tipo de condicion where
						if section_where == where[0].split(",")[2]:
							result_where_search = config.get_value("CONF", search, true).split(",") 
#				
				elif section != "*":
					if where[0].split(",")[1] == "==": # tipo de condicion where
						if section_where == where[0].split(",")[2]:
							result_where_search = config.get_value("CONF", search, true).split(",")[pos_section] 
							
				result = result_where_search



			# con WHERE si no encuentra la frase exacta busca una coincidencia
			elif not config.has_section_key("CONF", search):
				var result_search = []
				for index in config.get_section_keys("CONF"):
					if index.find(search,0) >= 0: # busca una cadena en el index
						var section_where = config.get_value("CONF", index, true).split(",")[i_where]
						
						if where[0].split(",")[1] == "==": # tipo de condicion where
							if section_where == where[0].split(",")[2]:
								result_search.append( config.get_value("CONF", index, true).split(",") )
						
						elif where[0].split(",")[1] == "!=": # tipo de condicion where
							if section_where != where[0].split(",")[2]:
								result_search.append( config.get_value("CONF", index, true).split(",") )
			
#				print("WHERE_search_NO | coincidence: ", result)
			
				result = result_search
			
			
			
			
		# consulta sin busqueda con condicion where
		elif search == "*":
			if config.has_section("CONF"):
#					var section_result = config.get_value("CONF", search, true).split(",")[pos_section]
				
				if section != "*": # busca solo una seccion de la linea
					result_where_search = []
					for index in config.get_section_keys("CONF"): # recorre las lineas
						var section_where = config.get_value("CONF", index, true).split(",")[i_where]
						
						if where[0].split(",")[1] == "==": # tipo de condicion
							if section_where == where[0].split(",")[2]:
								result_where_search.append( config.get_value("CONF", index, true).split(",")[pos_section] )
								
						if where[0].split(",")[1] == "!=": # tipo de condicion
							if section_where != where[0].split(",")[2]:
								result_where_search.append( config.get_value("CONF", index, true).split(",")[pos_section] )


				elif section == "*": # busca toda la linea
					result_where_search = []
					for index in config.get_section_keys("CONF"): # recorre las lineas
						var section_where = config.get_value("CONF", index, true).split(",")[i_where]
#						print(i_where)
						if where[0].split(",")[1] == "==": # tipo de condicion
							if section_where == where[0].split(",")[2]:
								result_where_search.append( index )
#								result_where_search.append( config.get_value("CONF", index, true).split(",") )

						if where[0].split(",")[1] == "!=": # tipo de condicion
							if section_where != where[0].split(",")[2]:
								result_where_search.append( index )
#								result_where_search.append( config.get_value("CONF", index, true).split(",") )
#								print(index)
			
			
			result = result_where_search
#			print("DB_get_where NO search: ", result)


	return result
















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
