AbstractSchema = require './abstract.coffee'

class TabletGroupsSchema extends AbstractSchema
  name: "tabletgroups"
  initTable: (table, callback)->
    table.string("tablet_link").collate "utf8_general_ci"
    table.integer "group_id"

    callback()

module.exports = TabletGroupsSchema