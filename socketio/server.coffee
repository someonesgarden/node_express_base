# roomへのbroadcastの場合、socket.broadcast.to('room') でうまく動かない。io.sockets.in('room')と書く

socketio      = require 'socket.io'
dateformat    = require 'dateformat'
jquery        = require 'jquery'
http          = require 'http'
fs            = require 'fs'

sioserver = (client)->
  #エラーを受け流す処理
  process.on 'uncaughtException', (_err)-> console.log(_err)

  sio = socketio.listen(client)
  sio.set('log level', 1)
  sio.set('transports',['websocket'])

  sio.sockets.on 'connection', (s)-> onConnectSuccess(s)
  sio.sockets.on 'connect_error', ()-> onConnectError()



# ON ============================================================
onConnectSuccess = (socketClient)->
  serverlog "sio.sockets.on('connection')"
  clientlog socketClient, "sio.sockets.on('connection')"
  onNotice(socketClient)

onConnectError = ()-> console.log('Connection Failed')

onNotice=(socket)->
  socket.on 'notice', (data)-> clientlog(socket, "socket.on('notice')", "data.type="+data.type)


#  UTILITY ============================================================
serverlog = (args) ->
  date = new Date()
  console.log "SOCKET["+date+"] ", args

clientlog = ()->
  date = new Date()
  array = ["SOCKET["+date+"] "]
  socket = arguments[0]
  for i in [1...arguments.length]
    array.push(arguments[i])
  socket.emit('log', array)

# ==================================================
module.exports = sioserver