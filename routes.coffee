mongo = require 'mongoskin'
express = require 'express'

db = mongo.db('mongodb://apiuser:23wesdxccxdsew32@dharma.mongohq.com:10004/storyforge')

module.exports = (app) ->

    app   
        .put '/put/:collection', express.bodyParser(), (req, res) ->
            db.collection(req.params.collection)
                .insert req.body, (err, data) ->
                    if err
                        console.log(err)
                    res.send(data[0])
        .put '/save/:collection', express.bodyParser(), (req, res) ->
            console.log(req.body)
            db.collection(req.params.collection)
                .save req.body, {safe: true}, (err, data) ->
                    if err
                        console.log(err)
                    console.log(data)
                    res.send(data)
        .put '/updatebyid/:collection', express.bodyParser(), (req, res) ->
            console.log(req.body)
            theId = req.body._id
            console.log(theId)
            delete req.body['_id']
            console.log(req.body)
            db.collection(req.params.collection) 
                .updateById theId, req.body, (err, data) ->
                    if err 
                        console.log(err) 
                    console.log(data) 
                    res.send(data)
        .get '/get/:collection/:key/:value', express.bodyParser(), (req, res) ->
            key = req.params.key
            value = req.params.value
            findThis = {}
            findThis[key] = value
            db.collection(req.params.collection)
                .findOne(findThis, (err, data) ->
                    console.log(err)
                    console.log(data)
                    res.send data
                )
        .get '/getbyid/:collection/:id', express.bodyParser(), (req, res) ->
            db.collection(req.params.collection)
                .findById(req.params.id, (err, data) ->
                    console.log(err)
                    console.log(data)
                    res.send data
                )

        .get '/', (req, res) ->
            res.render 'index'
        .get '/partials/:page', (req, res) ->
            res.render 'partials/'+req.params.page
        .get '/test', (req, res) ->
            res.render 'test'
        .get '/writing', (req, res) ->
            res.render 'writing'
        .get '/favicon.ico', (req, res) ->
            res.status(404)
            res.send('No page here.')
        .get '/questions', (req, res) ->
            res.header 'Content-Type', 'application/json'
            db.collection('questions').find().toArray( (err, questions) ->
                res.send questions
            )
        .get '/user/:username', (req, res) ->
            res.header 'Content-Type', 'application/json'
            db.collection('users')
                .findOne({username: req.params.username}, (err, data) ->
                    res.send data
            )
        .get '/book/:bookId', (req, res) ->
            res.header 'Content-Type', 'application/json'
            db.collection('books')
                .findById(req.params.bookId, (err, data) ->
                    res.send data
                )
    