extends MarginContainer

export var scn_path = "res://app_core/modules/responsiveApp/Dashboard.tscn"

var timer = 0
var scene_Loader = null
var progressbar = null
var stagecount = 0
var minTimeToShow = 2
var has_scn = false
var activeScene = ""
var resource
var percent



func _ready():
	
	Loading.goto_scene(scn_path,"in")
