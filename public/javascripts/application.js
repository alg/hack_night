$(function() {

  var sp_form = $("#suggest_project_form");
  var sp_link = $("a#suggest_project");

  sp_link.click(function(e) {
    e.preventDefault();
    sp_link.hide();
    sp_form.show();
    $("input[type=text]", sp_form).focus();
  });

  $("a", sp_form).click(function(e) {
    e.preventDefault();
    sp_link.show();
    sp_form.hide();
  })

  $('#message_body').keypress(function(e) {
    if (e.which == 10) $('#new_message').submit()
  })
})
