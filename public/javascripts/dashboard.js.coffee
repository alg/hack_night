class NewLinkSection
  constructor: (id) ->
    @sect    = $(id)
    @form    = $("form", @sect)
    @link    = $("a", @sect)
    @btn     = $("input[type=submit]", @form)
    @label   = $("#link_label", @form)
    @url     = $("#link_url", @form)
    @cancel = true
    @init()
  
  updateButton: =>
    @cancel = $.trim(@label.val()) is '' and $.trim(@url.val()) is ''
    @btn.attr 'value', (if @cancel then 'Hide' else 'Add')

  init: ->
    @link.click (e) =>
      e.preventDefault()
      @link.hide()
      @form.show()

    $("input[type=text]", @form).change(@updateButton).keyup(@updateButton)
    @form.submit (e) =>
      if @cancel
        e.preventDefault()
        @form.hide()
        @link.show()
  
    @updateButton()

$ ->
  new NewLinkSection('#links .add')
