@RecordForm = React.createClass
  getInitialState: ->
    title: ""
    date: ""
    amount: ""
  handleSubmit: (e) ->
    e.preventDefault()
    $.post "", { record: @state }, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    , "JSON"
  handleChange: (e) ->
    name = e.target.name # use 'name' attribute to detech which input triggered the event
    @setState "#{ name }": e.target.value
  valid: ->
    @state.title && @state.date && @state.amount
  render: ->
    React.DOM.form
      className: "form-inline"
      onSubmit: @handleSubmit
      React.DOM.div
        className: "form-group"
        React.DOM.input
          type: "text"
          className: "form-control"
          placeholder: "Date"
          name: "date"
          value: @state.date
          onChange: @handleChange
      React.DOM.div
        className: "form-group"
        React.DOM.input
          type: "text"
          className: "form-control"
          placeholder: "Title"
          name: "title"
          value: @state.title
          onChange: @handleChange
      React.DOM.div
        className: "form-group"
        React.DOM.input
          type: "number"
          className: "form-control"
          placeholder: "Amount"
          name: "amount"
          value: @state.amount
          onChange: @handleChange
      React.DOM.button
        type: "submit"
        className: "btn btn-primary"
        disabled: !@valid()
        "Create Record"
