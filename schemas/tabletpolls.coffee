AbstractSchema = require './abstract.coffee'

class TabletPollsSchema extends AbstractSchema
  name: "tabletpolls"
  initTable: (table, callback)->
    table.string("tablet_link").collate "utf8"
    table.integer "poll_id"
    table.timestamp 'start_date'
    table.timestamp 'end_date'

    callback()

module.exports = TabletPollsSchema