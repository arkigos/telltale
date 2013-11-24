mongo = require 'mongoskin'

db = mongo.db('mongodb://apiuser:23wesdxccxdsew32@paulo.mongohq.com:10029/typequiz')

module.exports = (app) ->
    
    app
        .get '/', (req, res) ->
            res.render 'index'
        .get '/partials/:page', (req, res) ->
            res.render 'partials/'+req.params.page
        .get '/test', (req, res) ->
            res.render 'test'
        .get '/favicon.ico', (req, res) ->
            res.status(404)
            res.send('No page here.')
        .get '/questions', (req, res) ->
            res.header 'Content-Type', 'application/json'
            db.collection('questions').find().toArray( (err, questions) ->
                res.send questions
            )
        .get '/users/:user', (req, res) ->
            res.header 'Content-Type', 'application/json'
            db.collection('users').find({name: req.params.user}).toArray( (err, users) ->
                res.send users
            )