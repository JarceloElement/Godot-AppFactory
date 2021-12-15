extends HTTPRequest

var ruta = Directory.new()
var dir_new = Directory.new()
var Home = ""
var dir_name_media = ""
var dir_name_image = ""

export var Url = "oc-content/uploads/0/"
export var Name = "1_preview.jpg"

var imagetexture = ImageTexture.new()
var size_imag = "0,0"


func _ready():

	# --- PATH CONF ---
	Home = get_node("/root/FuncApp").Home
	dir_name_media = str(Home) + get_node("/root/FuncApp").dir_name_media
	dir_name_image = dir_name_media + get_node("/root/FuncApp").dir_name_image

	# ruta donde sera guardada
	var image_path = str(dir_name_image + "/" + Name)
	# print("Image_path: ",image_path)


	if ruta.file_exists(str(image_path)):
		imagetexture.load(image_path)
		size_imag = str(imagetexture.get_size()).replace("(","").replace(")","").replace(" ","")
	#	print("size_imag:",size_imag)

	if !ruta.file_exists(str(image_path)) or size_imag == "0,0":
		set_download_file(image_path)
	#	print("Image downloading...")
	
		var image_url = get_node("/root/FuncApp").HOST+Url+Name # URL de la imagen web
		# print("Request_Dowl_image: ",image_url)
		request(image_url)
		connect("request_completed", self, "_on_HTTPRequest_request_completed")



func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	
	if(result == HTTPRequest.RESULT_SUCCESS):
	#	print("response_code ",response_code)
		
		if response_code == 200:

			var param = ["1",get_name()]
			var mensajes = get_tree().get_nodes_in_group("click_awesome")

			if get_node("/root/FuncApp").preview_active == 0:
				for i in mensajes:
					i.click_awesome("image_download",param) # envia a los botones para saber el id del producto

			if get_node("/root/FuncApp").preview_active == 1:
				for i in mensajes:
					i.click_awesome("image_download_preview",param) # envia a los botones para saber el id del producto

		#	print("Image_downloaded: ", param)
			queue_free()
		else:
			print("Imagen download error ",response_code)


	if(result == HTTPRequest.RESULT_CANT_CONNECT):
		print("Download error: RESULT_CANT_CONNECT ",response_code)
		queue_free()

