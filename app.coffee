path = require 'path'

express = require 'express'
assets = require 'connect-assets'
jadeAssets = require 'connect-assets-jade'

app = express()

app
    .set('port', process.env.PORT)
    .set('views', path.join __dirname, 'views')
    .set('view engine', 'jade')
    .set('view options', {layout: false})
    
require('./routes')(app)
    
app
    .use(app.router)
    .use(assets
        jsCompilers:
            jade: jadeAssets())
    .use(express.logger 'dev')
    .use(express.bodyParser())
    
app.locals.basedir = '/'
    
module.exports = app.listen process.env.PORT