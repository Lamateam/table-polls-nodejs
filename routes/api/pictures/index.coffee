async  = require 'async'
Busboy = require 'busboy'
fs     = require 'fs'

exports.init = (app)->
  app.get '/api/v1/pictures', (req, res, next)->
    app.get('connector').pictures().list { owner: req.session.user.login }, (err, pictures)->
      if err isnt null
        res.status(400).send { message: err }
      else 
        res.send { pictures: pictures }

  app.post '/api/v1/pictures', (req, res, next)->
    console.log 'here'
    busboy = new Busboy { headers: req.headers }

    busboy.on "file", (fieldname, file, filename, encoding, mimetype)->
      console.log 'File [' + fieldname + ']: filename: ' + filename + ', encoding: ' + encoding + ', mimetype: ' + mimetype

      arr = filename.split '.'
      extension = arr[arr.length-1]
      file_name = 'uploaded_images/image-' + Date.now() + "." + extension

      stream = file.pipe fs.createWriteStream("./dist/" + file_name)

      stream.on 'finish', ->
        app.get('connector').pictures().create { owner: req.session.user.login, url: '/static/' + file_name }, (err, pictures)->
          if err isnt null
            res.status(400).send { message: err }
          else 
            res.send { picture: '/static/' + file_name }

    req.pipe busboy