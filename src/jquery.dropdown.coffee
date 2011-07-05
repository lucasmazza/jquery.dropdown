## [jquery.dropdown](https://github.com/lucasmazza/jquery.dropdown)
# jQuery plugin for `<select />` elements customization.

# The plugin itself has almost no opinion on styling and CSS - this is
# application specific. The plugin goal is to support a simple html structure
# and some custom events to integrate the actual `<select />` element and
# the custom list.

# You can grab the latest required sources (a `.js` and a `.css` file) from the
# [GitHub repo](https://github.com/lucasmazza/jquery.dropdown).

# This code is licensed with the MIT License.
# [https://github.com/lucasmazza/jquery.dropdown](https://github.com/lucasmazza/jquery.dropdown)

$ = jQuery

$.fn.extend {}=
  dropdown: (options) ->
    # ## Configuration options
    defaults =
      # **slide** - Enables the `slide` effect instead of a `fade` one.
      slide: true
      # **classes** - Custom CSS class(es) to use together with the plugin markup.
      classes: false
      # **template** - Function responsible for building the plugin markup.
      template: template

    settings = $.extend {}, defaults, options

    return (@each () ->
      element = $ this
      # Hides the element and Inserts the plugin markup **after** it.
      container = init element, settings
      # Binds all the plugin events to the current element.
      bind element, container, settings
      # Creates the associated list inside the dropdown.
      element.trigger 'dropdown.refresh'
      ).next()

# Default markup used by the plugin.
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

# Creates a `<li />` with an `<a />` for a given `<option />` element.
createLine = (option) ->
  option = $ option
  $ "<li data-value='#{option.val()}'><a href='javascript:;' data-value='#{option.val()}'>#{option.text()}</a></li>"

init = (element, settings) ->
  $(settings.template(settings.classes)).insertAfter(element.hide())

bind = (element, container, settings) ->
  # Closes the open dropdowns when the user clicks outside.
  $(document).bind 'click', ->
    container.trigger 'dropdown.hide'

  # Recreates the dropdown list with a `<li />` for each `<option />` element.
  element.bind 'dropdown.refresh', ->
    list = container.find('ul').empty()
    element.find('option').each ->
      entry = createLine this
      entry.bind 'click.dropdown', ->
        container.trigger 'dropdown.select', $(this).attr 'data-value'
      list.append entry
    container.trigger 'dropdown.select', element.find(':selected').val()

  # Selects the given `value` in both the dropdown and the `<select />` element.
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

  # Displays (or hide) the given dropdown.
  container.bind 'dropdown.move', ->
    items = container.find '.dropdown-items'
    success = () -> container.toggleClass 'expanded'
    if settings.slide then items.slideToggle(success) else items.fadeToggle(success)

  # Forces the dropdown to hide
  container.bind 'dropdown.hide', ->
    items = container.find '.dropdown-items'
    success = () -> container.removeClass 'expanded'
    if settings.slide then items.slideUp(success) else items.fadeOut(success)

  # Expands or retracts the dropdown based on it's current status.
  container.find('.dropdown-current, .dropdown-expand').bind 'click', (event) ->
    event.stopPropagation()
    event.preventDefault()
    container.trigger 'dropdown.move'