class AbstractSchema
  isIncrements: true
  isTimestamps: true
  constructor: (@knex)->
    console.log @name + " schema creating!"

    @pull    = []
    @isReady = false

    @knex.schema.hasTable(@name).then (exists)=>
      if exists then @ready() else @knex.schema.createTable @name, (table)=>
        table.timestamps() if @isTimestamps
        table.increments() if @isIncrements
        @initTable table, @ready.bind(@)

  ready: ->
    console.log @name + " schema ready!"
    @isReady = true
    fn() for fn in @pull
  onReady: (fn)->
    if @isReady then fn() else @pull.push(fn)
  initTable: (table, callback)->
    console.log @name + " doesn't implement initTable method!"
    callback()
  create: (data, callback)->
    data.created_at = new Date()
    data.updated_at = new Date()
    @knex(@name).insert(data)
      .then (err)->
        callback null, data
      .catch (err)->
        callback err, null
        console.error "Error in " + @name + " schema! Method 'create':\n", err
  list: (filters, callback)->
    @knex.select('*').from(@name).where(filters).then (rows)->
      callback null, rows
    .catch (err)->
      callback err, null
      console.error "Error in " + @name + " schema! Method 'list':\n", err

module.exports = AbstractSchema