#!/usr/bin/env node

#MIDDLEWARE =====================
path    = require('path')
debug   = require('debug')('Docker_Node_Express')
http    = require('http')

# ================================
app     = require('../app.coffee')
io      = require(path.resolve(path.join('./socketio', 'server.coffee')))

app.set('port', parseInt(process.env.PORT, 10) || 8080)

server  = http.createServer(app)
onError = require('my/funcs.coffee').onError

onListening = ()-> debug('Listening on port ' + server.address().port)

# ================================
io(server)
server.listen app.get('port')
server.on 'error', onError
server.on 'listening', onListening
