# @cjsx React.DOM

{div, ul, li, input, form} = React.DOM

@TodoList = React.createClass
  getInitialState: ->
    items: @props.items

  handle_submit: (e) ->
    e.preventDefault()
    name = $('#item_name').val()
    $.ajax(
       url: "/items.json"
       data: {item: {name: name, done: false}}
       type: "POST"
    ).done (item) =>
      @setState items: (@state.items.concat [item])

  render: ->
    todo_items =
      for item in @state.items
        Item
          item:item
    div {},
      ul {},
        todo_items
      form { onSubmit: @handle_submit },
        input {
          type: 'text'
          name: 'item[name]'
          id: 'item_name'
        }
        input {
          type: 'submit'
        }
