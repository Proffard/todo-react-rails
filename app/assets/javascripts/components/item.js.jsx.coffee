# @cjsx React.DOM

{a, i, label, div, ul, li, input} = React.DOM

@Item = React.createClass
  getInitialState: ->
    item: @props.item

  render: ->
    div {className: 'ui attached segment'},
      div {className: "ui ten columns grid" },
        div {className: "left floated nine wide column" },
          div {className: 'ui big checkbox input'},
            input {
              onChange: @handle_change,
              type: 'checkbox',
              id: @state.item.id,
              name: @state.item.id,
              checked: (@state.item.done ? 'checked' : '') }
            label {htmlFor: @state.item.id},
              @state.item.name
        div {className: "right floated column" },
          i {
            className: 'red remove circle large link icon',
            onClick: @delete_me }

  clean_object: (o) ->
    for key in ['id', 'created_at', 'updated_at']
      delete o[key]
    return o

  handle_change: (e) ->
    item = @state.item
    item.done = e.target.checked
    
    $.ajax(
       url: "/items/#{@state.item.id}.json"
       data: {item: @clean_object(item)}
       type: "PUT"
    ).done (item) =>
      @setState item: item

  delete_me: ->
    $.ajax(
       url: "/items/#{@state.item.id}.json"
       type: "DELETE"
    ).done (item) =>
      @props.handle_delete()
