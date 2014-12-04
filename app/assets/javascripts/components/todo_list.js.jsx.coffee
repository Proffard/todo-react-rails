# @cjsx React.DOM
{button,i, div, ul, li, input, form} = React.DOM

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
      div {className: "ui top attached segment"},
        div {className: "ui icon fluid input"},
          input {
            onChange: @handle_search
            value: @state.search
            id: 'search'
            placeholder: 'Search...' }
          i {className: 'search icon'}
      if items.length > 0
        for item in items
          Item
            item: item
            key: item.id
            handle_delete: @handle_delete
      else
        div {className: 'ui attached segment'},
          "Nothing..."
      div {className: "ui botoom attached segment"},
        form { onSubmit: @handle_submit},
          div {className: "ui action fluid input"},
            input {
              type: 'text'
              name: 'item[name]'
              placeholder: 'Task...'
              id: 'item_name' }
            div {
              className: 'ui teal left labeled button',
              onClick: @handle_submit},
              'Add'

  handle_submit: (e) ->
    e.preventDefault()
    name = $('#item_name').val()
    if name.length > 0
      $.ajax(
         url: "/items.json"
         data: {item: {name: name, done: false}}
         type: "POST"
      ).done (item) =>
        $('#item_name').val('')
        @setState items: (@state.items.concat [item])

  handle_search: (e) ->
    @setState search: e.target.value

  handle_delete: ->
    $.ajax(
       url: "/items.json"
       type: "GET"
    ).done (items) =>
      @setState items: items
