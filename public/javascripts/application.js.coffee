$ ->
  sp_form         = $("#suggest_project_form")
  sp_link         = $("a#suggest_project")
  attendance_box  = $("#attendance")

  sp_link.click (e) ->
    e.preventDefault()
    sp_link.hide()
    sp_form.show()
    $("input[type=text]", sp_form).focus();

  $("a", sp_form).click (e) ->
    e.preventDefault()
    sp_link.show()
    sp_form.hide()

  $(".reconsider", attendance_box).click (e) ->
    e.preventDefault()
    $(".decide", attendance_box).show()
    $(this).hide()
