knex          = require 'knex'

Users         = require "./users.coffee"
Tablets       = require "./tablets.coffee"
Polls         = require './polls.coffee'
Groups        = require './groups.coffee'
TabletPolls   = require './tabletpolls.coffee'
TabletAnswers = require './tabletanswers.coffee'
TabletGroups  = require './tabletgroups.coffee'

class Knex
  constructor: (config)->
    @knex = knex config
    @schemas = 
      users: new Users @knex
      tablets: new Tablets @knex
      polls: new Polls @knex 
      tabletpolls: new TabletPolls @knex
      tabletanswers: new TabletAnswers @knex
      tabletgroups: new TabletGroups @knex 
      groups: new Groups @knex  
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
  groups: ->
    @schemas.groups
  tabletgroups: ->
    @schemas.tabletgroups

module.exports = Knex