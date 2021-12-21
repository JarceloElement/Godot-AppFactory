extends Control


# THEME COLORS
export var color_option_field_head = Color("c90045")
export var color_option_field_body = Color("404040")
export var color_show_pass_icon_act = Color("d2205d")
export var color_show_pass_icon_inact = Color("c3c3c3")




var scroll_top = 1


# mobile | telefono
# map-marker | direccion
# pencil | editar
# bar-chart | indicadores
# bar-chart-o | indicadores
# user-circle-o | usuario circular
# address-book-o | cuaderno de usuario
# id-card-o | credencial DNI

# list-alt|| listas
# list-ol
# list-ul

# cloud-download
# cloud-upload
# sign-in
# user-plus
# user-times
# id-badge | carnet

# sun-o
# commenting
# sellsy | nube wifi
# comments

# GLOBAL VARS
var menu_hide = 1
var anime_menu = 0

var config = ConfigFile.new()
var result = ""
var result_search = Array()
var result_where_search = Array()
var pos_section = 0
var i_where = 0


# VARS
var GLOBAL = {}
var PopUp_contact_var = 1
var Total_list_field = 0
var field_instance_name = "" # viene de DB_control







# ---- DB ----
var dir_new = Directory.new()
var export_DB_to_user = true

# path
var Local_img_path = "res://images/products/"
var dir_name_home = "/InfoApp"
var dir_name_media = "/Media"
var dir_name_image = "/Images"
var dir_name_data = "/Data"
var dir_name_user = OS.get_user_data_dir()+"/DB"
var path



	# OS.get_system_dir(_OS.SYSTEM_DIR_DOWNLOADS)
	# OS.get_system_dir(NOTIFICATION_WM_GO_BACK_REQUEST

#var Home = OS.get_system_dir(2) # PC= Mis documentos | Android= Download
var path_res = "res://DB/"
var Home = str(OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)) + dir_name_home
var path_media = str(Home) + dir_name_media
var path_image = path_media + dir_name_image
var path_data = path_media + dir_name_data+"/"
var path_user = dir_name_user+"/"
#-------------
var leader_conf_path = path_user+"/leader_conf.cfg"

# PATH DATABASE
var DB_control_priority = 1
var ACTIVE_DB_PATH = {"path":"","table_name":""} # [path,table_name]
var post_request_dicc = {}
var session_path = [path_user,"USERS"]
var city_DB = "res://DB/tools_city.cfg"









# INSTANCES
#var PopUp_contact = preload("res://app_core/modules/popup/PopUp_contact.tscn")
var HTTPRequest_form = preload("res://app_core/modules/http/DB_form_request.tscn")
#var register_category = preload("res://app_core/modules/buttons/Category.tscn")
var line_edit_panel = preload("res://app_core/modules/form/line_edit_panel.tscn") # change
#var PopUp_field_edit = preload("res://SocialApp/PopUp_field_edit.tscn")
#var Field_conf = preload("res://SocialApp/field_conf.tscn")

# POPUP
#var PopUp_login = preload("res://app_core/modules/popup/PopUp_login.tscn")






# THEMES
var theme_city_tools = load("res://trivie_game/gui_theme/scroll.tres")
var text_theme = load("res://app_core/themes/text_edit_theme.tres")








var file_path = "res://examples/file.txt"
var conf_path = "res://DB/vocabulario.cfg"
var csv_path = "res://DB/vocabulario.csv"
var JSON_path = "res://examples/file.json"





var line = []

var data_string = " "







var tts_type = 0
var output = []
var npc_dialog_str = "Hello, hola, welcome, bienvenido"




























# HTTP
var conexion_status = 1
var HOST = "http://10.42.0.1/anuncios/"
#var URL_POST = "http://infoapp.lanube.com.ve/consulta.php"
var URL_POST = "http://10.42.0.1/nube_app/index.php?page=app&"
# var URL_POST = "http://10.42.0.1/nube_app1/consulta_app.php"
#var URL_POST = "http://192.168.1.11/infocentro/consulta.php"
var Request_status = 0


# slider | scroll
# var slider_x = 0
# var slider_y = 0
# var slider_y_positivo = 0
# var slider_pos_global = 0
var scroll_top_end = 0
var temp_total_show = 0
var temp_pos_scroll = 0
# var x_posi = 0
# var y_posi = 0
# var blok = 0
# var eje_activo = 0
# var rel_y = 0

# vars
var screen_size = ""
var responsive_size = Vector2()
var responsive_margin_L = ""
var responsive_margin_R = ""
var responsive_pos = Vector2()
# var menu_tipo = 1
# var N_mostrar = 0
# #var Total_list_field = 0
# var activeScene = null
# var scene_tipo = 0
# var reporte_tipo = 0
# var escena_tipo = 0
var scene_ID = 1
# var number_pick_show = 0
# var visita = 1
# var notificar_en_dasboard = 1
# var buscar = 0
# #var menu_hide = 1
var number_pick_is_visible = 0
var preview_active = 0
var popup_list = 0
# var popup_contact = 0
var popup_login = 0
var popup_form_active = 0
var popup_active = 0
# var popup_tools_city = 0
# var location_active = ""
# var turn = ""
var is_empty_field = 0
var next_field_form = 1
var active_field = 0

# # animate | form
var size_list = 100
var scroll_D = 0
# var editando = 0
var visible_slider_list = 1
var visible_selec = 1
var mov_slider = 0

# var active_message_param = [] # 0=icon | 1=message
var array_form = []
var array_field_name = []
var array_field_data = []

# var array_form_request_response = []
# var estado_activo = 0
# var campo_form_vacio = 0
# var tipo_campo_editando = 0


#  param request
var HTTP_Request_result = {}
# var item_1 = []
# var item_2 = []
# var item_3 = []
# var item_4 = []
# var item_5 = []
# var item_6 = []
# var item_7 = []
# var item_8 = []
# var item_9 = []
# var item_10 = []
# var item_11 = []
# var item_12 = []
# var fecha_registros = []
# var total_hoy_registro = 1
# var estados_hoy = 0


# DB control
# var hacer_lista = 0
# var DB_control_priority = 1


# -- Instances --
# HTTPRequest
#var reporte_general = preload("res://app_core/scn/HTTPRequest_dashboard.scn")
#var HTTPRequest_form = preload("res://app_core/scn/http/HTTP_form.tscn")
#var HTTPRequest_form = preload("res://app_core/assets/http/DB_form_request.tscn")
#var HTTP_control = preload("res://app_core/scn/elements/HTTP_control.scn")
#var download_image = preload("res://app_core/scn/elements/Download_image.scn")
#
## SQL ITEM REPORT
#var message = preload("res://app_core/scn/elements/campo_reporte.scn")
# var product = preload("res://app_core/scn/elements/Product_1.scn")
#var Category = preload("res://app_core/scn/elements/category.scn")
#var product_image = preload("res://app_core/scn/elements/Image_preview.scn")
#var product_preview = preload("res://app_core/scn/elements/Preview.scn")
#var Combo_products = preload("res://app_core/scn/elements/Combo_products.scn")
#var DB_control = preload("res://app_core/scn/elements/DB_control.scn")
#var Top_search_bar = preload("res://app_core/scn/elements/Top_search_bar.scn")
#var PopUp_contact = preload("res://app_core/templates/english_trivie/elements/PopUp_contact.tscn")
#var PopUp_list = preload("res://app_core/scn/elements/PopUp_list.scn")
#var PopUp_signin = preload("res://app_core/scn/elements/PopUp_signin.scn")
#var PopUp_signup = preload("res://app_core/scn/elements/PopUp_signup.scn")
#var PopUp_user_edit = preload("res://app_core/scn/elements/PopUp_user_edit.scn")
#var PopUp_pass_recovery = preload("res://app_core/scn/elements/PopUp_pass_recovery.scn")
#var PopUp_score = preload("res://app_core/scn/pages/english_trivie/elements/PopUp_score.scn")
#var User_score = preload("res://app_core/scn/pages/english_trivie/elements/user_score.tscn")

## TRIVIE RESOURCE
var Word_button = preload("res://trivie_game/Word_button.tscn")

# # Post DB conf
# var INSTANCE = ""
# var ITEM_TYPE = ""
# var SQL_DB_NAME = ""
# var SQL_DB_NAME_score = ""
# # var DB_PATH = ""
# var SQL_TABLE_NAME = ""
# var SQL_PARAM = ""
# var TABLE_ITEM_REF = ""
# var ORDER_BY = ""
# var field_for_search = []
# var parent_category = 0

# var DB_ext = ".db"
var total_report = 0
var resul_report = ""
# var view_mode = 1
# var next_product = 1

# SESSION
var SESSION = {"user_id":"1","user_name":"Player","wallet":"0"}

# OPEN-GRAPH PRODUCTS
var p_id_product = ""
var p_category = ""
var p_category_ico = ""
var p_price = ""
var p_offer = ""
var p_title = ""
var p_description = ""
var p_location = ""
var p_seller = ""
var p_seller_type = ""
var p_contact = ""
var p_phone = ""
var p_condition = ""
var p_trans_type = ""
var p_turno = ""
var p_date_pub = ""
var p_images = []
var p_img_ext = ""
var p_image_name = ""
var p_image_path = ""
var p_image_url = ""
var p_url = ""



# datos de la partida
var total_answer_in_trivie = 0
var user_game_name = 0
var user_correct_answer = 0
var user_incorrect_answer = []
var user_game_time = 0




# hacer captura de un nodo
#	img = get_viewport().get_screen_capture().get_rect(imagenode_rect)


# var array_scn_loaded = []
# var last_scn_path = ""







func _ready():


	# MOSTRAR ALERTAS
	# var param_1 = ["buy_from: "+get_name(),title,"icon_off","ff9500","ffffff"] # color:icon, color:title
	# for i in get_tree().get_nodes_in_group("alert"):
	# 	i.click_awesome("alert_show",param_1)

		#-------crear carpeta / DB--------
	if( !dir_new.dir_exists( Home ) ):
		dir_new.make_dir_recursive( Home )
		print( get_node("/root/FuncApp").dir_name_home + " | Folder created" )

	if( !dir_new.dir_exists( path_media ) ):
		dir_new.make_dir_recursive( path_media )
		print( get_node("/root/FuncApp").dir_name_media + " | Folder created" )

	if( !dir_new.dir_exists( path_image ) ):
		dir_new.make_dir_recursive( path_image )
		print( get_node("/root/FuncApp").dir_name_image + " | Folder created" )

	if( !dir_new.dir_exists( path_data ) ):
		dir_new.make_dir_recursive( path_data )
		print( get_node("/root/FuncApp").dir_name_data + " | Folder created" )

	if( !dir_new.dir_exists( dir_name_user ) ):
		dir_new.make_dir_recursive( dir_name_user )
		print( dir_name_user + " | Folder created" )

	# print("path_data: ",dir_name_user)

	pass




	# SPEAK TO TEXT
func speak(param):

	if OS.get_name() == "Android":
		if Engine.has_singleton("AndroidTTS"):
			tts_android(param)
	else:
		if param[1] == "male":
			tts_android(param)
			
		elif param[1] == "female":
			tts_espeak(param)

func tts_android(param):
	npc_dialog_str = param[0]
	TTS.speak(npc_dialog_str)
	
	
	
func tts_espeak(param): # 1: idioma, 2: frase
	tts_type = 1
	npc_dialog_str = param[0]
	_read()


func tts_pico(param):
	
	OS.execute("pico2wave", ["-w", "test.wav", param[0]], true, output)
	# reproduce el audio
	OS.execute("aplay", ["test.wav", "&"], false, output)


func _read():
#     -s 120  # velocidad
#     -a 40 # volumen
#     -p 0  # tono de la voz


		if tts_type == 1:
		
			# INGLES
			# hombre
#			OS.execute("espeak", ["-vm3", "-s 160", "-p 30", "-w", "test.wav", npc_dialog_str], true, output)
#			OS.execute("espeak", ["-vm3", "-s 160", "-p 60", npc_dialog_str], false, output)
			
			# mujer
		#	OS.execute("espeak", ["-vf3", "-s 150", "-p 60", "-w", "test.wav", npc_dialog_str], true, output)
			OS.execute("espeak", ["-vf3", "-s 160", "-p 60", npc_dialog_str], false, output)

			# CASTELLANO
			# hombre	
		#	OS.execute("espeak", ["-ves", "-s 160", "-p 60", "-w", "test.wav", npc_dialog_str], true, output)
		#	OS.execute("espeak", ["-vmb-es1", "-s 230", "-p 50", "-a 100", "-w", "test.wav", npc_dialog_str], true, output)
		#	OS.execute("espeak", ["-ves+m3", "-s 150", "-p 60", "-a 100", "-w", "test.wav", npc_dialog_str], true, output)
			
			# mujer
	#		OS.execute("espeak", ["-ves+f3", "-s 160", "-p 70", "-a 100", "-w", "test.wav", npc_dialog_str], true, output)
#			OS.execute("espeak", ["-ves+f3", "-s 160", "-p 70", npc_dialog_str], false, output)

			# OTROS
		#	OS.execute("gtts-cli", ["-l", "-o", "-w", "test.wav", npc_dialog_str], true, output)
		#	OS.execute("festival", ["-tts", "-w", "test.wav", npc_dialog_str], true, output)
			
#			OS.execute("espeak", ["-ves+f3", "-s 160", "-p 60", npc_dialog_str], false, output)
			
			# reproduce el audio
	#		OS.execute("aplay", ["test.wav", "&"], false, output)
			





func _date_dma(fecha):
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

func _date_Ymd(datetime):
	# --- formatear fecha a: Y-m-d (2020-01-01) DESDE Datetime 2020-04-26 00:18:41---
	var fecha_Ymd = datetime.split(" ")
	return fecha_Ymd[0]
	# -------------------


func _today_datetime():
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


func _today_date():
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


func _hour(datetime):
	var hora = datetime.split(" ")
	hora = hora[1].split(":")
	hora = hora[0]+":"+hora[1]
	return hora
