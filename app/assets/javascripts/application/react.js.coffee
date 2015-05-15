#$ ->
  #if (document.body.className == "pages-react")
    ##React.DOM.tagName(properties, children)
    ##React.renderComponent(what, where)
    #React.render(
      #React.DOM.div({}, "Hello world!"),  #What you want to render, here we create a VIRTUAL div tag without any attributes
      #document.body #Where to render
    #)

    ##Nested HTML
    #virtualDom = React.DOM.div(
      #{id: "react-render-me-please"},
      #React.DOM.a(
        #{href:"javascript:void(0)", id: "do-nothing-link"},
        #"Click me"
      #)
    #)

    #React.render(
      #virtualDom,
      #document.body
    #)

    ##Responding to click events
    #linkClicked = (event) ->
      #console.log(event)
      #console.log(event.target)
      #alert("You clicked me")

    #virtualDom = React.DOM.div(
      #{id: "react-render-me-please"},
      #React.DOM.a(
        #{href:"javascript:void(0)", onClick: linkClicked},
        #"Click Me"
      #)
    #)

    #React.render(
      #virtualDom,
      #document.body
    #)

    ##Changing html content manually
    #virtualDomAfterClick = React.DOM.div(
      #{id: "after-click"},
      #React.DOM.span({}, "You clicked the link")
    #)

    #linkClicked = (event) ->
      #React.render(
        #virtualDomAfterClick,
        #document.body
      #)

    #virtualDomBeforeClick = React.DOM.div(
      #{id: "before-click"},
      #React.DOM.a(
        #{href: "javascript:void(0)", onClick: linkClicked},
        #"Click me"
      #)
    #)

    #React.render(
      #virtualDomBeforeClick,
      #document.body
    #)

## Creating component
#$ ->
  #OneTimeClickLink = React.createClass
    #getInitialState: ->
      #{clicked: false}
    #linkClicked: (event) ->
      #@setState(clicked: true) #set state of component using @setState(key-value pair)
    #child: ->
      #{
        #true: React.DOM.span({}, "You clicked the link"),
        #false: React.DOM.a({href: "javascript:void(0)", onClick: @linkClicked}, "Click Me")
      #}[@state.clicked]
    #render: ->
      #React.DOM.div({id: "one-time-click-link"}, @child())

  #test = React.createElement(OneTimeClickLink)

  #React.render(
    #test,
    #document.body
  #)
