$ = jQuery

template = (klasses) ->
  css = if klasses then ' ' + klasses else ''
  "
  <div class='dropdown-container#{css}'>
    <span class='dropdown-header'>
    <span class='dropdown-current' />
      <a href='javascript:;' class='dropdown-expand'>&darr;</a>
    </span>
    <div class='dropdown-items'>
      <ul />
    </div>
  </div>"

createLine = (option) ->
  option = $ option
  $ "<li data-value='#{option.val()}'><a href='javascript:;' data-value='#{option.val()}'>#{option.text()}</a></li>"

###
Creates the related container
###
init = (element, settings) ->
  $(settings.template(settings.classes)).insertAfter(element.addClass('dropdown-replaced'))

###
Binds all the available events on both element and container
###
bind = (element, container, settings) ->
  $(document).bind 'click', ->
    container.trigger 'dropdown.hide'

  # Recreates the dropdown list with the element options
  element.bind 'dropdown.refresh', ->
    list = container.find('ul').empty()
    element.find('option').each ->
      entry = createLine this
      entry.bind 'click.dropdown', -> container.trigger 'dropdown.select', $(this).attr 'data-value'
      list.append entry
    container.trigger 'dropdown.select', element.find(':selected').val()

  # Selects the given value in both the dropdown and the select
  container.bind 'dropdown.select', (event, value) ->
    selected = container.find "a[data-value=#{value}]"
    placeholder = container.find '.dropdown-current'

    placeholder.text ''
    element.val ''

    if selected.size()
      placeholder.text selected.text()
      element.val value
      selected.addClass 'selected'
    container.trigger 'dropdown.hide'

  # Displays (or hide) the container
  container.bind 'dropdown.move', ->
    items = container.find '.dropdown-items'
    success = () -> container.toggleClass 'expanded'
    if settings.slide then items.slideToggle(success) else items.fadeToggle(success)

  # Hide the container
  container.bind 'dropdown.hide', ->
    items = container.find '.dropdown-items'
    success = () -> container.removeClass 'expanded'
    if settings.slide then items.slideUp(success) else items.fadeOut(success)

  # Expand or retract the container
  container.find('.dropdown-current, .dropdown-expand').bind 'click', (event) ->
    event.stopPropagation()
    event.preventDefault()
    container.trigger 'dropdown.move'

###
jquery.dropdown Plugin
copyright Lucas Mazza
https://github.com/lucasmazza/jquery.dropdown
###
$.fn.extend {}=
  dropdown: (options) ->
    defaults =
      slide: true
      classes: false
      template: template

    settings = $.extend {}, defaults, options

    return (@each () ->
      element = $ this
      container = init element, settings
      bind element, container, settings
      element.trigger 'dropdown.refresh'
      ).next()