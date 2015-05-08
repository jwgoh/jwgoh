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
