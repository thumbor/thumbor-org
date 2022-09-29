class BreakpointsCtrl extends Ctrl
    gatherElements: ->
        @availableBreakpoints = [
            1,
            601,
            801,
            1281,
            1441,
            1681,
            1921
        ]
        @window = $(window)
        @breakpoints = {}

    getNextPicture: ->
        imageIndex = window.sessionStorage.__nextThumborImage
        imageIndex = 0 unless imageIndex?
        imageIndex = parseInt(imageIndex, 10) + 1
        if imageIndex > 8
            imageIndex = 1
        window.sessionStorage.__nextThumborImage = imageIndex
        return imageIndex

    bindEvents: ->
        @window.setBreakpoints(
            distinct: true
            breakpoints: @availableBreakpoints
        )

        for breakpoint in @availableBreakpoints
            do (breakpoint) =>
                @window.bind("enterBreakpoint#{ breakpoint }", =>
                    return unless @breakpoints[breakpoint]

                    for pair in @breakpoints[breakpoint]
                        element = pair[0]
                        image = pair[1]
                        if image instanceof Array
                            imgIndex = @getNextPicture()
                            img = image[imgIndex - 1]
                            element.css('background-image', "url(#{ @thumborServerUrl}/#{ img })")
                        else
                            element.css('background-image', "url(#{ @thumborServerUrl}/#{ image })")
                )

        return

    setThumborServer: (serverUrl) ->
        @thumborServerUrl = serverUrl

    addBreakpoint: (breakpoint, element, image) ->
        @breakpoints[breakpoint] = [] unless @breakpoints[breakpoint]?
        @breakpoints[breakpoint].push([element, image])
