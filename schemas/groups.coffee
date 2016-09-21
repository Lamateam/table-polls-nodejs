AbstractSchema = require './abstract.coffee'

class GroupsSchema extends AbstractSchema
  name: "groups"
  initTable: (table, callback)->
    table.string('name').collate "utf8_general_ci"
    table.string("owner").collate "utf8_general_ci"

    callback()
  link: (data, callback)->
    @knex('tabletgroups')
      .where 'tablet_link', data.tablet_link
      .del()
      .then =>
        if data.group_id isnt undefined
          data.created_at = new Date()
          data.updated_at = new Date()
          @knex('tabletgroups').insert(data)
            .then (ids)->
              callback null, ids
            .catch (err)->
              callback err, null
              console.error "Error in " + @name + " schema! Method 'create':\n", err

module.exports = GroupsSchema