AbstractSchema = require './abstract.coffee'

class TabletAnswersSchema extends AbstractSchema
  name: "tabletanswers"
  initTable: (table, callback)->
    table.string("tablet_link").collate "utf8"
    table.integer "poll_id"
    table.boolean "person_male"
    table.float "person_smile"
    table.float "person_age"
    table.string("answers").collate "utf8"

    callback()

module.exports = TabletAnswersSchema