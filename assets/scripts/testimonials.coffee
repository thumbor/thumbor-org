class TestimonialsCtrl extends Ctrl
    gatherElements: ->
        @elements.username = $('#user-name')
        @elements.email = $('#user-email')
        @elements.companyName = $('#company-name')
        @elements.companyUrl = $('#company-website')
        @elements.testimonial = $('#testimonial')
        @elements.submit = @element.find('.submit a')

        @elements.new = @element.find('.new')
        @elements.success = @element.find('.success')

    bindEvents: ->
        @elements.submit.on('click', (ev) =>
            @clearValidation();
            ev.preventDefault()
            if @validate()
                data =
                    sender_name: @elements.username.val()
                    email: @elements.email.val()
                    company_name: @elements.companyName.val()
                    company_url: @elements.companyUrl.val()
                    testimonial: @elements.testimonial.val()

                $.ajax(
                    type: "POST"
                    url: '/new-testimonial'
                    data: data
                    success: @testimonialSaved
                )
        )

    testimonialSaved: =>
        window.scrollTo(0, 0)
        @elements.new.addClass('hidden')
        @elements.success.removeClass('hidden')

    clearValidation: ->
        @elements.username.removeClass('error')
        @elements.email.removeClass('error')
        @elements.companyName.removeClass('error')
        @elements.companyUrl.removeClass('error')
        @elements.testimonial.removeClass('error')

    validate: ->
        isValid = true

        if @elements.username.val() == ''
            isValid = false
            @elements.username.addClass('error')

        if @elements.email.val() == ''
            isValid = false
            @elements.email.addClass('error')

        if @elements.companyName.val() == ''
            isValid = false
            @elements.companyName.addClass('error')

        if @elements.companyUrl.val() == ''
            isValid = false
            @elements.companyUrl.addClass('error')

        if @elements.testimonial.val() == ''
            isValid = false
            @elements.testimonial.addClass('error')

        return isValid


class TestimonialsMobileCtrl extends Ctrl
    gatherElements: ->
        @testimonialsScroll = new IScroll(
            @element[0],
            scrollX: true
            scrollY: false
            eventPassthrough: true
            snap: 'li'
            momentum: false
            freeScroll: true
        )

        @elements.pagerList = $('.testimonials-pager ul')
        @elements.testimonials = @element.find('li')

        lis = []
        for i in [1..@testimonialsScroll.pages.length]
            lis.push('<li class="ib"></li>')

        @elements.pagerList.html(lis.join(''))
        @elements.pagerItems = @elements.pagerList.find('li')
        @elements.pagerItems.eq(0).addClass('selected')
        @elements.testimonials.eq(0).addClass('selected')

        @testimonialsScroll.goToPage(0, 0, 0)

    bindEvents: ->
        @testimonialsScroll.on('scrollStart', @handleScrollStart)
        @testimonialsScroll.on('scrollEnd', @handleScrollEnd)

        @elements.pagerItems.on('click', (ev) =>
            item = $(ev.currentTarget)
            @elements.pagerItems.removeClass('selected')
            @testimonialsScroll.goToPage(item.index(), 0)
        )

    handleScrollStart: =>
        @elements.pagerItems.removeClass('selected')

    handleScrollEnd: =>
        currPage = @testimonialsScroll.currentPage.pageX
        @elements.testimonials.removeClass('selected').eq(currPage).addClass('selected')
        @elements.pagerItems.eq(currPage).addClass('selected')
