extends VBoxContainer

var time = 0
var N_lista = 0

var menu_tipo = 0
var total_category = 0


func _ready():
	N_lista = 0
	add_to_group("add_category")
	# add_to_group("click_awesome")
#	get_parent().set_theme(get_node("/root/FuncApp").tema_awesome)


	# agrega los botones en la lista
	if get_owner().type == "locations":
		crear_boton_all_loc()

	if get_owner().type == "filter":
		add_filteBYturn_button()




	set_process(1)

func _process(delta):

	if get_owner().type == "locations":
	# if menu_tipo == 1:
		total_category = get_node("/root/FuncApp").HTTP_Request_result["locations_id"].size()

	if N_lista < total_category:
		time += 1
		if time == 1:
			if get_owner().type == "locations":
				add_locations_button()

			time = 0
			N_lista += 1
		
	if N_lista >= total_category:
		set_process(0)

	

func add_locations_button():

	var ping = get_node("/root/FuncApp").Category.instance()

	ping.set_name(str(int(N_lista)))
	ping.menu_type = 3
	ping.view_mode = get_node("/root/FuncApp").view_mode
	ping.close_menu = 1
	ping.Title = get_node("/root/FuncApp").HTTP_Request_result["locations_name"][int(N_lista)]
	ping.description = ""
	ping.ID_message = "set_location"
	ping.param = get_node("/root/FuncApp").HTTP_Request_result["locations_id"][int(N_lista)]

	ping.total_item = str(get_node("/root/FuncApp").HTTP_Request_result["locations_total_item"][int(N_lista)])
	ping.icon = "map-marker"

	if get_node("/root/FuncApp").location_active == get_node("/root/FuncApp").HTTP_Request_result["locations_id"][int(N_lista)]:
		ping.icon_color = "12a04f"
	else:
		ping.icon_color = "d2205d"

	add_child(ping)
	# print("ITEM-",get_node("/root/FuncApp").HTTP_Request_result["locations_id"][int(N_lista)])
	pass


func crear_boton_all_loc():

	var ping = get_node("/root/FuncApp").Category.instance()

	ping.set_name(str(int(N_lista)))
	ping.menu_type = 3
	ping.close_menu = 1
	ping.Title = str(get_node("/root/Messages").get("_all_regions"))
	ping.description = ""
	ping.ID_message = "set_location"
	ping.param = ""

	ping.total_item = str(get_node("/root/FuncApp").HTTP_Request_result["items_total_all"])
	ping.icon = "ico_all_region"

	if get_node("/root/FuncApp").location_active == "":
		ping.icon_color = "12a04f"
	else:
		ping.icon_color = "d2205d"

	add_child(ping)
	# print("ITEM-",get_node("/root/FuncApp").HTTP_Request_result["locations_id"][int(N_lista)])
	pass


func add_filteBYturn_button():

	var ping = get_node("/root/FuncApp").Category.instance()

	ping.set_name(str(int(N_lista)))
	ping.menu_type = 5
	ping.close_menu = 0
	ping.Title = str(get_node("/root/Messages").get("_on_turn"))
	ping.description = ""
	ping.ID_message = "set_global"
	ping.param = "turn,1"

	ping.total_item = ""
	ping.icon = "mobile"

	# if get_node("/root/FuncApp").location_active == "":
	# 	ping.icon_color = "12a04f"
	# else:
	# 	ping.icon_color = "d2205d"

	add_child(ping)
	# print("ITEM-",get_node("/root/FuncApp").HTTP_Request_result["locations_id"][int(N_lista)])
	pass
