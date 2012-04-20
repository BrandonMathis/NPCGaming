$ ->
  $(".destroy").click ->
    console.log 'hello hello'
    if confirm("Are you sure?")
      row = $(this).closest("tr").get(0)
      $.post @href,
        _method: "delete"
      , null, "script"
      $(row).hide()
      false
    else
      false
