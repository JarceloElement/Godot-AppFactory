extends MarginContainer

export var icon = "star"
export var icon_color = "ffa51a"
export var bg_color = "87e6f0"
export var score = 2500
export var position = 3
export var wallet = 0
export var set_background = 0
var opacity = 0.0




func _ready():
	get_node("HBoxContainer/position/position").text = (str(position))
#	get_node("HBoxContainer/Button_icon/HBoxContainer/MarginContainer2/icon").icon = icon
#	get_node("HBoxContainer/Button_icon/HBoxContainer/MarginContainer2/icon").set("custom_colors/font_color",icon_color)
	get_node("HBoxContainer/score/score").set_text(str(score))
	get_node("HBoxContainer/wallet/wallet").set_text(str(wallet))
	get_node("TextureRect").modulate.a = opacity 
	
	if wallet != 0:
		get_node("HBoxContainer/wallet").show()
		get_node("HBoxContainer/icon_cloud").show()
		
	if set_background == 1:
		set_process(1)
	
	if bg_color != "":
		get_node("TextureRect").set_modulate(Color(bg_color)) 
#		get_node("Panel").get("custom_styles/panel").set("bg_color", self.bg_color)
	else:
		get_node("Panel").hide()
	
	
func _process(delta):
	if opacity < 1:
		opacity += 0.01
		get_node("TextureRect").modulate.a = opacity 
	else:
		set_process(0)
		
