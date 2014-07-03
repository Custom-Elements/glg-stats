#glg-stats
Pull in statistics for the current user and display them with fun sparklines.

    _ = require 'lodash'

    Polymer 'glg-stats',

##Events

##Attributes and Change Handlers

      currentuserChanged: ->
        console.log 'hi', @currentuser

##Methods

##Event Handlers

      onuser: (evt, detail) ->
        @currentuser = detail

      onquery: (evt, detail) ->
        console.log 'goop', detail
        @gtc_rates = _(detail.response)
          .map (give) ->
            give_to_client_date: give.give_to_client_date.slice(0, 10)
            rate_amount: give.rate_amount
          .groupBy (give) -> give.give_to_client_date
          .values()
          .map (day_values, i, all_values) ->
            period = 7
            if i + 7 > all_values.length
              null
            else
              _(all_values.slice(i, i+period))
                .flatten()
                .reduce (acc, value, i, all) ->
                  acc += value.rate_amount / (all.length or 1)
                , 0
          .compact()
          .value()
        @most_recent_gtc_rate = Math.floor _.last @gtc_rates

##Polymer Lifecycle

      created: ->
        @currentuser = null

      ready: ->

      attached: ->
        console.log "let's get statty"

      domReady: ->

      detached: ->
