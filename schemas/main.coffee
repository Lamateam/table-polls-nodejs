knex          = require 'knex'

Users         = require "./users.coffee"
Tablets       = require "./tablets.coffee"
Polls         = require './polls.coffee'
TabletPolls   = require './tabletpolls.coffee'
TabletAnswers = require './tabletanswers.coffee'

class Knex
  constructor: (config)->
    @knex = knex config
    @schemas = 
      users: new Users @knex
      tablets: new Tablets @knex
      polls: new Polls @knex 
      tabletpolls: new TabletPolls @knex
      tabletanswers: new TabletAnswers @knex 
  users: ->
    @schemas.users
  tablets: ->
    @schemas.tablets
  polls: ->
    @schemas.polls 
  tabletpolls: ->
    @schemas.tabletpolls
  tabletanswers: ->
    @schemas.tabletanswers

module.exports = Knex