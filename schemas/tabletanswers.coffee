AbstractSchema = require './abstract.coffee'

class TabletAnswersSchema extends AbstractSchema
  name: "tabletanswers"
  initTable: (table, callback)->
    table.string("tablet_link").collate "utf8_general_ci"
    table.integer "poll_id"
    table.string("answers").collate "utf8_general_ci"

    callback()

module.exports = TabletAnswersSchema