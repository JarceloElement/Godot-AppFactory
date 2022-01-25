extends MarginContainer

export var scn_path = "res://app_core/modules/responsiveApp/Dashboard.tscn"




func _ready():
	
	Loading.goto_scene(scn_path,"in")
