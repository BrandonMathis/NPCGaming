jQuery ->
  $('#post_tag_name').autocomplete
    source: $('#post_tag_name').data('autocomplete-source')
