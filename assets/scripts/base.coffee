class Ctrl
    constructor: (@element, @options) ->
        @options = $.extend({}, @getClassVariable('defaults'), @options)
        @elements = {}
        @gatherElements()
        @bindEvents()

    getClassVariable: (prop) ->
        Object.getPrototypeOf(@).constructor[prop]

    gatherElements: ->

    bindEvents: ->
