AbstractSchema = require './abstract.coffee'

class TabletsSchema extends AbstractSchema
  name: "tablets"
  initTable: (table, callback)->
    table.boolean("is_active").default false
    table.boolean("is_online").default false
    table.string("link").collate "utf8_general_ci"
    table.string("name").collate "utf8_general_ci"
    table.string("owner").collate "utf8_general_ci"

    callback()
  link: (link, callback)->
    @knex("tablets")
      .where 'link', '=', link
      .where 'is_active', '=', false
      .update { is_active: true, updated_at: new Date() }
      .then (res)->
        callback null, res
      .catch (err)->
        callback err, null

module.exports = TabletsSchema