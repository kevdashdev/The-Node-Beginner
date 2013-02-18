http = require 'http'
url = require 'url'


start = (route, handle) ->
	onRequest = (req, res) ->
		postData = ""
		pathname = url.parse(req.url).pathname
		console.log "Request for #{pathname} received."
		route handle, pathname, res, req

	http.createServer(onRequest).listen 8888
	console.log "Server started at http://127.0.0.1:8888"

exports.start = start