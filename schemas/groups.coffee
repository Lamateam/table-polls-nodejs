AbstractSchema = require './abstract.coffee'

class GroupsSchema extends AbstractSchema
  name: "groups"
  initTable: (table, callback)->
    table.string('name').collate "utf8_general_ci"
    table.string("owner").collate "utf8_general_ci"

    callback()
  list: (filters, callback)->
    @knex.select('*').from(@name).where(filters).then (rows)=>
      ids = [ ]
      ids.push row.id for row in rows
      @knex.select('*').from('tabletgroups').whereIn('group_id', ids).then (tablets)->
        for row in rows
          row.tablets = [ ]
          for tablet in tablets
            row.tablets.push tablet.tablet_link if tablet.group_id is row.id
        callback null, rows
    .catch (err)=>
      callback err, null
      console.error "Error in " + @name + " schema! Method 'list':\n", err

module.exports = GroupsSchema