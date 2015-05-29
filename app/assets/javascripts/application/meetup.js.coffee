$ ->
  DOM = React.DOM

  DateWithLabel = React.createClass
    getDefaultProps: ->
      date: new Date()
    onYearChange: (event) ->
      newDate = new Date(
        event.target.value,
        @props.date.getMonth(),
        @props.date.getDate()
      )
      @props.onChange(newDate)
    onMonthChange: (event) ->
      newDate = new Date(
        @props.date.getFullYear(),
        event.target.value,
        @props.date.getDate()
      )
      @props.onChange(newDate)
    onDateChange: (event) ->
      newDate = new Date(
        @props.date.getFullYear(),
        @props.date.getMonth()
        event.target.value,
      )
      @props.onChange(newDate)
    monthName: (monthNumberStartingFromZero) ->
      [
        "January", "February", "March" ,"April" ,"May" ,"June" ,"July" ,"August" ,"September" ,"October" ,"November" ,"December"
      ][monthNumberStartingFromZero]
    dayName: (date) ->
      dayNameStartingWithSundayZero = new Date(
        @props.date.getFullYear(),
        @props.date.getMonth(),
        date
      ).getDay()
      [
        "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
      ][dayNameStartingWithSundayZero]
    render: ->
      DOM.div
        className: "form-group"
        DOM.label
          className: "col-lg-2 control-label"
          "Date"
        DOM.div
          className: "col-lg-2"
          DOM.select
            className: "form-control"
            onChange: @onYearChange
            value: @props.date.getFullYear()
            DOM.option(value: year, key: year, year) for year in [2015..2020]
        DOM.div
          className: "col-lg-3"
          DOM.select
            className: "form-control"
            onChange: @onMonthChange
            value: @props.date.getMonth()
            DOM.option(value: month, key: month, "#{month+1}-#{@monthName(month)}") for month in [0..11]
        DOM.div
          className: "col-lg-2"
          onChange: @onDateChange
          DOM.select
            className: "form-control"
            value: @props.date.getDate()
            DOM.option(value: date, key: date, "#{date}-#{@dayName(date)}") for date in [1..31]

  FormInputWithLabel = React.createClass
    getDefaultProps: ->
      elementType: "input"
      inputType: "text"
    displayName: "FormInputWithLabel"
    render: ->
      DOM.div
        className: "form-group"
        DOM.label
          htmlFor: @props.id
          className: "col-lg-2 control-label"
          @props.labelText
        DOM.div
          className: React.addons.classSet('col-lg-10': true, 'has-warning': @props.warning)
          @warning()
          DOM[@props.elementType]
            className: "form-control"
            placeholder: @props.placeholder
            id: @props.id
            value: @props.value
            onChange: @props.onChange
            type: @tagType()
    tagType: ->
      {
        "input": @props.inputType,
        "textarea":  null,
      }[@props.elementType]
    warning: ->
      return null unless @props.warning
      DOM.label
        className: "control-label"
        htmlFor: @props.id
        @props.warning

  FormInputWithLabelAndReset = React.createClass
    displayName: "FormInputWithLabelAndReset"

    render: ->
      DOM.div
        className: "form-group"
        DOM.label
          htmlFor: @props.id
          className: "col-lg-2 control-label"
          @props.labelText
        DOM.div
          className: "col-lg-8"
          DOM.div
            className: "input-group"
            DOM.input
              className: "form-control"
              placeholder: @props.placeholder
              id: @props.id
              value: @props.value
              onChange: (event) =>
                @props.onChange(event.target.value)
            DOM.span
              className: "input-group-btn"
              DOM.button
                onClick: () =>
                  @props.onChange(null)
                className: "btn btn-default"
                type: "button"
                DOM.i
                  className: "fa fa-magic"
              DOM.button
                onClick: () =>
                  @props.onChange("")
                className: "btn btn-default"
                type: "button"
                DOM.i
                  className: "fa fa-times-circle"
  
  CreateNewMeetupForm = React.createClass
    getInitialState: ->
      {
        title: ""
        description: ""
        date: new Date()
        seoText: null
        warning: {
          text: null
        }
      }

    fieldChanged: (fieldName, event) ->
      stateUpdate = {}
      stateUpdate[fieldName] = event.target.value
      @setState(stateUpdate)
      @validateField(fieldName, event.target.value)

    validateField: (fieldName, value) ->
      validator = {
        title: (text) ->
          if /\S/.test(text) then null else "Cannot be blank"
      }[fieldName]
      return unless validator
      warnings = @state.warnings
      warnings[fieldName] = validator(value)
      @setState(warnings: warnings)

    seoChanged: (seoText) ->
      @setState(seoText: seoText)

    dateChanged: (newDate) ->
      @setState(date: newDate)

    computeDefaultSeoText: () ->
      #monthName: (monthNumberStartingFromZero) ->
        #[
          #"January", "February", "March" ,"April" ,"May" ,"June" ,"July" ,"August" ,"September" ,"October" ,"November" ,"December"
        #][monthNumberStartingFromZero]
      words = @state.title.toLowerCase().split(/\s+/)
      #words.push(monthName(@state.date.getMonth()))
      words.push(
        [
          "January", "February", "March" ,"April" ,"May" ,"June" ,"July" ,"August" ,"September" ,"October" ,"November" ,"December"
        ][@state.date.getMonth()]
      )
      words.push(@state.date.getFullYear().toString())
      words.filter( (string) -> string.trim().length > 0 ).join("-").toLowerCase()

    formSubmitted: (event) ->
      $.ajax
        url: "/meetups.json",
        type: "POST",
        dataType: "JSON",
        contentType: "application/json",
        processData: false,
        data: JSON.stringify( { meetup: {
          title: @state.title,
          description: @state.description,
          date: "#{@state.date.getDate()}-#{@state.date.getMonth()+1}-#{@state.date.getFullYear()}"
          seo: @state.seoText || @computeDefaultSeoText()
        } } )

    render: ->
      DOM.form
        className: "form-horizontal"
        method: "post"
        action: "/meetups"
        DOM.fieldset null,
          DOM.legend null, "New Meetup"

          React.createElement(FormInputWithLabel, {
            id: "title"
            value: @state.title
            onChange: @fieldChanged.bind(null, "title")
            placeholder: "Meetup title"
            labelText: "Title"
            #elementType defaults to text
            warning: @state.warnings.title
          })

          React.createElement(FormInputWithLabel, {
            id: "description"
            value: @state.description
            onChange: @fieldChanged.bind(null, "description")
            placeholder: "Meetup description"
            labelText: "Description"
            elementType: "textarea"
          })

          React.createElement(DateWithLabel, {
            onChange: @dateChanged
            date: @state.date
          })

          React.createElement(FormInputWithLabelAndReset, {
            id: "seo"
            value: if @state.seoText? then @state.seoText else @computeDefaultSeoText()
            onChange: @seoChanged
            placeholder: "SEO Text"
            labelText: "SEO"
          })

          DOM.div
            className: "form-group"
            DOM.div
              className: "col-lg-10 col-lg-offset-2"
              DOM.input
                type: "button"
                className: "btn btn-primary"
                value: "Save"
                onClick: @formSubmitted

 
  React.render(
    React.createElement(CreateNewMeetupForm),
    document.getElementById("CreateNewMeetup")
  )
