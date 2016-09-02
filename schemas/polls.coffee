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
    table.timestamp 'start_date'
    table.timestamp 'end_date'

    callback()
  create: (data, callback)->
    @knex.select('*').from('tablets').whereIn('link', data.tablets).then (rows)=>
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
          .then (ids)=>
            for tablet in data.tablets
              @knex('tabletpolls')
                .insert 
                  tablet_link: tablet
                  poll_id: ids[0]
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
            callback err
  getActual: (link, callback)->
    today     = new Date()
    prev_date = moment().add(1, 'days').toDate()
    @knex.select('*').from('tabletpolls')
      .where 'tablet_link', link
      .where 'end_date', '>=', prev_date
      .where 'start_date', '<=', today
      .then (rows)=>
        if rows.length isnt 0
          @knex.select('*').from('polls')
            .where { id: rows[0].poll_id }
            .where { is_active: true }
            .then (rows)->
              callback null, rows
            .catch (err)->
              console.log err
              callback err
        else
          callback null, []
      .catch (err)->
        console.log 'error: ', err
        callback err
  listByTablet: (data, callback)->
    @knex
      .join 'polls', 'tabletpolls.poll_id', '=', 'polls.id'
      .select('*').from('tabletpolls')
      .where 'tabletpolls.tablet_link', '=', data.tablet_link
      .where 'polls.owner', '=', data.owner
      .then (rows)->
        callback null, rows
      .catch (err)->
        callback err
  update: (data, callback)->
    @knex('polls')
      .where { owner: data.owner }
      .where { id: data.id }
      .update data
      .then (res)->
        console.log res
        callback null
      .catch (err)->
        callback err

module.exports = PollsSchema