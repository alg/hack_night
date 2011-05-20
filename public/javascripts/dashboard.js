var NewLinkSection = function(id) {
  var self = this;
  var sect = $(id);
  var form = $("form", sect);
  var link = $("a", sect);
  var btn  = $("input[type=submit]", form);
  var label = $("#link_label", form);
  var url  = $("#link_url", form);
  var cancel = true;
  
  link.click(function(e) {
    e.preventDefault();
    link.hide();
    form.show();
  });

  var updateButton = function() {
    cancel = ($.trim(label.val()) == '' && $.trim(url.val()) == '');
    if (cancel) {
      btn.attr('value', 'Hide');
    } else {
      btn.attr('value', 'Add');
    }
  };
  
  $("input[type=text]", form).change(updateButton).keyup(updateButton);
  form.submit(function(e) {
    if (cancel) {
      e.preventDefault();
      form.hide();
      link.show();
    }
  });
  
  updateButton();
};

$(function() {
  new NewLinkSection('#links .add');
});