jQuery ->
  $('#post_category_name').autocomplete
    source: $('#post_category_name').data('autocomplete-source')
