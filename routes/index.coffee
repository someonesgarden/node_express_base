express       = require 'express'
http          = require 'http'
router        = express.Router()

router.get('/', (req, res)-> res.render('index', {title:'TITLE'}))


#=================================================================
module.exports = router