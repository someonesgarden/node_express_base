'use strict'
#MIDDLEWARE =====================
express       = require 'express'
session       = require 'express-session'
favicon       = require 'serve-favicon'
path          = require 'path'
fs            = require 'fs'
logger        = require 'morgan'
cookieParser  = require 'cookie-parser'
bodyParser    = require 'body-parser'
multer        = require 'multer'

routes        = require './routes/index.coffee'

# view engine setup ====================================
app = express()
#app.set('views',path.join(__dirname, 'views'))
app.set('view engine','jade')

# USE middleware  =======================================
app.use favicon(__dirname + '/public/favicon.ico')
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded({ extended: false })
app.use cookieParser()
app.use session {
  secret: 'session_secret_key'
  resave: false
  saveUninitialized: true
}

app.use express.static(path.join(__dirname, 'public'))
app.use('/', routes)


# ERROR HANDLING =======================================================
app.use (req, res, next)->
  err = new Error('Not Found')
  err.status = 404
  next(err)

if app.get('env') is 'development'
  app.use (err, req, res, next)->
    res.status(err.status || 500)
    res.render('error', {message: err.message, error: err})

app.use (err, req, res, next)->
  res.status(err.status || 500)
  res.render('error', {message: err.message, error:{}})


#=================================================================
module.exports = app