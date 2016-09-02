socket = io.connect()

#////////////////////////////// socket emit ////////////////
emit = (type, msg)-> #イベント発信
  console.log "socket emit:'notice'"
  socket.emit('notice', {type:type, value:msg} )


$(document).ready ()->
  $(window).on 'beforeunload', (e)->
    #saveDataInMongo()
    emit('logout')
    e.preventDefault()

  #送信ボタンのコールバック設定
  #$('#send').click sendMessage
  #$('#client').click sendPlayerPositionToSocket

# =====================================================
socket.on "log", (array)-> console.log.apply(console, array)
socket.on 'disconnect', (client)->
socket.on 'connect', ()-> emit('login')

window.emit = emit