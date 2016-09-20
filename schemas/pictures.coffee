AbstractSchema = require './abstract.coffee'

class PicturesSchema extends AbstractSchema
  name: "pictures"
  initTable: (table, callback)->
    table.string('url').collate "utf8_general_ci"
    table.string("owner").collate "utf8_general_ci"

    callback()

module.exports = PicturesSchema