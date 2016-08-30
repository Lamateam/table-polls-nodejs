express      = require 'express'
session      = require 'express-session'
body_parser  = require 'body-parser'
jade_amd     = require "jade-amd"

config       = require "./config.json"

connector    = require './schemas/main.coffee'

app = express()

# jade config
app.set "views", "src/views"
app.set 'view engine', 'jade'

# session
app.use session config.session

# static
app.use "/static", express.static("dist")
app.use "/static/html", jade_amd.jadeAmdMiddleware({})


# bodyparser for json
app.use body_parser.json({ type: 'application/json' })

# database
app.set "connector", new connector(config.connector)

# routes
require("./routes/main.coffee").init app

app.listen config.port, ->
  console.log 'App listening on port ' + config.port + '!'
