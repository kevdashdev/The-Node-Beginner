# exec = require("child_process").exec
qs = require "querystring"
fs = require "fs"
formidable = require "formidable"

start = (response) ->
	console.log "Request handler 'start' was called"
	body = """
	<!doctype html>
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html" charset=UTF-8 />
	</head>
	<body>
	<form action="/upload" enctype="multipart/form-data" method="post">
	<input type="file" name="upload">
	<input type="submit" value="Upload" />
	</form>
	</body>
	</html>
	"""
	#exec "find /", (error, stdout, stderr) ->
	response.writeHead 200, { "Content-Type" : "text/html" }
	response.write body
	response.end()

upload = (response, request) ->
	console.log "Request handler 'upload' was called"

	form = new formidable.IncomingForm()
	console.log "about to parse"
	form.parse request, (error, fields, files) ->
		console.log "parsing done"

		fs.rename files.upload.path, "./tmp/test.png", (err) ->
			if err
				fs.unlink "./tmp/test.png"
				fs.rename files.upload.path, "./tmp/test.png"

	response.writeHead 200, { "Content-Type" : "text/html" }
	response.write "received image: <br/> <img src='/show' />"
	response.end()

show = (response) ->
	console.log "Request handler 'show' was called."
	fs.readFile "./tmp/test.png", "binary", (error, file) ->
		if error
			response.writeHead 500, {"Content-Type" : "text/plain" }
			response.write "WTF#{error} \n"
			response.end()
		else
			response.writeHead 200, { "Content-Type" : 'image/png' }
			response.write file, "binary"
			response.end()


exports.start = start
exports.upload = upload
exports.show = show