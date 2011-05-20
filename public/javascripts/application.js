$(function() {
  var sp_form = $("#suggest_project_form");
  var sp_link = $("a#suggest_project");
  var attendance_box = $("#attendance");

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
  });

  $(".reconsider", attendance_box).click(function(e) {
    e.preventDefault();
    $(".decide", attendance_box).show();
    $(this).hide();
  });
});
