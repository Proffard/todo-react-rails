# @cjsx React.DOM

{ul, li, input} = React.DOM

@Item = React.createClass
  getInitialState: ->
    item: @props.item

  render: ->
    li {},
      input {
        onChange: @handle_change,
        type: 'checkbox',
        id: @state.item.id,
        checked: (@state.item.done ? 'checked' : '')
      }
      @state.item.name

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
