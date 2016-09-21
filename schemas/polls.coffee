AbstractSchema = require './abstract.coffee'
moment         = require 'moment'

class PollsSchema extends AbstractSchema
  name: "polls"
  initTable: (table, callback)->
    table.string("question").collate "utf8_general_ci"
    table.string("success_text").collate "utf8_general_ci"
    table.string("answers").collate "utf8_general_ci"
    table.string("owner").collate "utf8_general_ci"
    table.boolean('is_active').default true
    table.integer 'next'
    table.timestamp 'start_date'
    table.timestamp 'end_date'

    callback()
  create: (data, callback)->
    @knex.select('*').from('groups').whereIn('id', data.groups).then (rows)=>
      is_owner = true
      for row in rows
        if row.owner isnt data.owner
          callback 'Вы не являетесь владельцем одного или нескольких планшетов'
          is_owner = false

      if is_owner
        @knex('polls')
          .insert 
            question: data.question
            success_text: data.success_text
            answers: data.answers
            owner: data.owner 
            start_date: new Date data.start_date
            end_date: new Date data.end_date
            created_at: new Date()
            updated_at: new Date()
            next: data.next
          .then (ids)=>
            for group in data.groups
              @knex('grouppolls')
                .insert 
                  group_id: group
                  poll_id: ids[0]
                  start_date: new Date data.start_date
                  end_date: new Date data.end_date
                  created_at: new Date()
                  updated_at: new Date()
                .then (id)->
                  console.log id
                .catch (err)->
                  console.log err
            callback null, ids[0]
          .catch (err)->
            callback err
  getActual: (link, callback)->
    today     = new Date()

    @knex.select('*').from('tabletgroups')
      .where 'tablet_link', link
      .then (rows)=>
        if rows.length isnt 0
          @knex.select('*').from('grouppolls')
            .where 'group_id', rows[0].group_id
            .where 'end_date', '>=', today
            .where 'start_date', '<=', today
            .then (rows)=>
              if rows.length isnt 0
                ids = [ ]
                ids.push poll.poll_id for poll in rows
                @knex.select('*').from('polls')
                  .whereIn 'id', ids
                  .where { is_active: true }
                  .then (rows)->
                    callback null, rows
                  .catch (err)->
                    console.log err
                    callback err
              else
                callback null, []
        else
          callback null, []
      .catch (err)->
        console.log 'error: ', err
        callback err
        
    @knex('tablets')
      .where { link: link }
      .update { last_active: new Date() }
      .then ->
        a = 1
      .catch (err)->
        console.log err
  listByTablet: (data, callback)->
    @knex
      .select('*').from('tabletgroups')
      .where 'tablet_link', '=', data.tablet_link
      .then (rows)=>
        @knex
          .join 'polls', 'grouppolls.poll_id', '=', 'polls.id'
          .select('*').from('grouppolls')
          .where 'grouppolls.group_id', '=', rows[0].id
          .where 'polls.owner', '=', data.owner
          .then (rows)->
            callback null, rows
          .catch (err)->
            callback err
      .catch (err)->
        callback err
  active: (data, callback)->
    @knex('polls')
      .where { owner: data.owner }
      .where { id: data.id }
      .update { is_active: data.is_active }
      .then ->
        callback()
  update: (data, callback)->
    if data.groups isnt undefined
      @knex.select('*').from('groups').whereIn('id', data.groups).then (rows)=>
        is_owner = true
        for row in rows
          if row.owner isnt data.owner
            callback 'Вы не являетесь владельцем одного или нескольких планшетов'
            is_owner = false

        if is_owner
          @knex('polls')
            .where { owner: data.owner }
            .where { id: data.id }
            .update 
              question: data.question
              success_text: data.success_text
              answers: data.answers
              start_date: new Date data.start_date
              end_date: new Date data.end_date
              updated_at: new Date()
            .then (res)=>
              @knex('grouppolls')
                .del()
                .where { poll_id: data.id }
                .then =>
                  for group in data.groups
                    @knex('grouppolls')
                      .insert 
                        group_id: group
                        poll_id: data.id
                        start_date: new Date data.start_date
                        end_date: new Date data.end_date
                        created_at: new Date()
                        updated_at: new Date()
                      .then (id)->
                        console.log id
                      .catch (err)->
                        console.log err
                  callback null
                .catch (err)->
                  console.log err
            .catch (err)->
              callback err
    else
      @knex('polls')
        .where { owner: data.owner }
        .where { id: data.id }
        .update data
        .then ->
          callback null
        .catch (err)->
          callback err

module.exports = PollsSchema