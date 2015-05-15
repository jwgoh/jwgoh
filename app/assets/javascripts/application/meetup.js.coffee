$ ->
  DOM = React.DOM

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
          className: "col-lg-10"
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
  
  CreateNewMeetupForm = React.createClass
    getInitialState: ->
      {
        title: ""
        description: ""
      }

    fieldChanged: (fieldName, event) ->
      stateUpdate = {}
      stateUpdate[fieldName] = event.target.value
      @setState(stateUpdate)

    render: ->
      DOM.form
        className: "form-horizontal"
        method: "post"
        action: "meetups"
        DOM.fieldset null,
          DOM.legend null, "New Meetup"

          React.createElement(FormInputWithLabel, {
            id: "title"
            value: @state.title
            onChange: @fieldChanged.bind(null, "title")
            placeholder: "Meetup title"
            labelText: "Title"
          })

          React.createElement(FormInputWithLabel, {
            id: "description"
            value: @state.description
            onChange: @fieldChanged.bind(null, "description")
            placeholder: "Meetup description"
            labelText: "Description"
            elementType: "textarea"
          })

          DOM.div
            className: "form-group"
            DOM.div
              className: "col-lg-10 col-lg-offset-2"
              DOM.input
                type: "Submit"
                className: "btn btn-primary"
                value: "Save"
  
  React.render(
    React.createElement(CreateNewMeetupForm),
    document.getElementById("CreateNewMeetup")
  )
