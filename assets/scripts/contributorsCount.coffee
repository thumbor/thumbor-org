class ContributorsCount extends Ctrl
    bindEvents: ->
        $.ajax
            url: 'https://api.github.com/repos/thumbor/thumbor/contributors?per_page=1'
            type: 'head'
        .done (response, info, headers) =>
            header = headers.getResponseHeader('Link')
            count = /&page=(\d+)>; rel="last"/g.exec(header)[1]
            @element.html(parseInt(count, 10) - 3)

new ContributorsCount($('.contributors-count'))
