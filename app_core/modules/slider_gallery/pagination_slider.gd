extends HBoxContainer

var paginacion = load("res://app_core/modules/slider_gallery/Button_icon.tscn")
var N_lista = 0
var total_slider = 0

var icono = "circle"
var icono_size = 20
var icono_color = Color("ffffff")


func _ready():
	set_process(1)

func _process(delta):
	
	for i in get_tree().get_nodes_in_group("slider_view"):
		total_slider = i.get_node("ParallaxBackground/VBoxContainer/Items").get_child_count()
		icono_size = i.pag_icono_size
		icono_color = i.pag_icono_color
		
	if N_lista < total_slider:
		N_lista += 1
		var ping = paginacion.instance()
		ping.set_name(str(N_lista))
		ping.icon = icono
		ping.icon_size = icono_size
		ping.icon_color = icono_color
		ping.ID_message = "paginacion"
		ping.ID = 2
		ping.message_param = str(N_lista)
		add_child(ping)

	if N_lista > total_slider:
		set_process(0)

