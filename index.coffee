server = require "./server"
router = require "./router"
reqHandler = require "./requestHandler"

handle = {
	"/" : reqHandler.start,
	"/start" : reqHandler.start,
	"/upload" : reqHandler.upload,
	"/show" : reqHandler.show
}

server.start router.route, handle