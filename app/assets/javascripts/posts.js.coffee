$ ->
  split = (val) ->
    val.split /,\s*/

  extractLast = (term) ->
    split(term).pop()

  availableTags = $('#post_categories_string').data('autocomplete-source')

  $("#post_categories_string").autocomplete
    minLength: 0
    source: (request, response) ->
      response $.ui.autocomplete.filter(availableTags, extractLast(request.term))

    focus: ->
      false

    select: (event, ui) ->
      terms = split(@value)
      terms.pop()
      terms.push ui.item.value
      terms.push ""
      @value = terms.join(", ")
      false
