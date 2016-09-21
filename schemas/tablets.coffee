AbstractSchema = require './abstract.coffee'

class TabletsSchema extends AbstractSchema
  name: "tablets"
  initTable: (table, callback)->
    table.boolean("is_active").default false
    table.boolean("is_online").default false
    table.string("link").collate "utf8_general_ci"
    table.string("name").collate "utf8_general_ci"
    table.string("owner").collate "utf8_general_ci"
    table.timestamp('last_active').default null

    callback()
  list: (filters, callback)->
    @knex.select('*').from(@name).where(filters).then (rows)=>
      links = [ ]
      links.push row.link for row in rows
      @knex.select('*').from('tabletgroups')
        .whereIn 'tablet_link', links
        .then (groups)->
          for tablet in rows 
            for group in groups
              tablet.group = { 'id': group.group_id } if tablet.link is group.tablet_link
          callback null, rows
    .catch (err)->
      callback err, null
      console.error "Error in " + @name + " schema! Method 'list':\n", err
  link: (link, callback)->
    @knex("tablets")
      .where 'link', '=', link
      .where 'is_active', '=', false
      .update { is_active: true, updated_at: new Date() }
      .then (res)->
        callback null, res
      .catch (err)->
        callback err, null
  listByPoll: (data, callback)->
    @knex
      .join 'groups', 'groups.id', '=', 'grouppolls.group_id'
      .select('*').from('grouppolls')
      .where 'grouppolls.poll_id', '=', parseInt(data.poll_id, 10)
      .where 'groups.owner', '=', data.owner
      .then (rows)->
        callback null, rows
      .catch (err)->
        callback err

module.exports = TabletsSchema