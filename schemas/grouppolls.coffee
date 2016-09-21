AbstractSchema = require './abstract.coffee'

class TabletPollsSchema extends AbstractSchema
  name: "grouppolls"
  initTable: (table, callback)->
    table.integer "group_id"
    table.integer "poll_id"
    table.timestamp 'start_date'
    table.timestamp 'end_date'

    callback()

module.exports = TabletPollsSchema