# @cjsx React.DOM

{div, ul, li, input, form} = React.DOM

@TodoList = React.createClass
  getInitialState: ->
    items: @props.items
    search: ''

  render: ->
    items = @state.items
    search_string = @state.search.trim().toLowerCase()

    if search_string.length > 0
      items = items.filter (item) ->
        item.name.trim().toLowerCase().match(search_string)

    div {},
      input {
        onChange: @handle_search
        value: @state.search
        id: 'search'
        placeholder: 'Search...'
      }
      ul {},
        for item in items
          Item
            item: item
            key: item.id
      form { onSubmit: @handle_submit },
        input {
          type: 'text'
          name: 'item[name]'
          id: 'item_name'
        }
        input {
          type: 'submit'
          value: 'add!'
        }

  handle_submit: (e) ->
    e.preventDefault()
    name = $('#item_name').val()
    $.ajax(
       url: "/items.json"
       data: {item: {name: name, done: false}}
       type: "POST"
    ).done (item) =>
      @setState items: (@state.items.concat [item])

  handle_search: (e) ->
    @setState search: e.target.value
