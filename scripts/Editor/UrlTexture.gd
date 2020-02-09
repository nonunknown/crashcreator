extends TextureRect
class_name UrlTexture

func request(url:String):
	var req:HTTPRequest = $HTTPRequest
	req.request(url,["content-type: image/jpg"])

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var img = Image.new()
	img.load_jpg_from_buffer(body)
	var t = ImageTexture.new()
	t.create_from_image(img)
	texture = t

export var build_path:NodePath
func _on_Button_pressed():
	request(get_node(build_path).le_url.text)
	pass # Replace with function body.
