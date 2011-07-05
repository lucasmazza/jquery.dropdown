(function() {
  var $, bind, createLine, init, template;
  $ = jQuery;
  $.fn.extend({
    dropdown: function(options) {
      var defaults, settings;
      defaults = {
        slide: true,
        classes: false,
        template: template
      };
      settings = $.extend({}, defaults, options);
      return (this.each(function() {
        var container, element;
        element = $(this);
        container = init(element, settings);
        bind(element, container, settings);
        return element.trigger('dropdown.refresh');
      })).next();
    }
  });
  template = function(klasses) {
    var css;
    css = klasses ? ' ' + klasses : '';
    return "  <div class='dropdown-container" + css + "'>    <span class='dropdown-header'>    <span class='dropdown-current' />      <a href='javascript:;' class='dropdown-expand'>&darr;</a>    </span>    <div class='dropdown-items'>      <ul />    </div>  </div>";
  };
  createLine = function(option) {
    option = $(option);
    return $("<li data-value='" + (option.val()) + "'><a href='javascript:;' data-value='" + (option.val()) + "'>" + (option.text()) + "</a></li>");
  };
  /*
  Creates the related container
  */
  init = function(element, settings) {
    return $(settings.template(settings.classes)).insertAfter(element.addClass('dropdown-replaced'));
  };
  /*
  Binds all the available events on both element and container
  */
  bind = function(element, container, settings) {
    $(document).bind('click', function() {
      return container.trigger('dropdown.hide');
    });
    element.bind('dropdown.refresh', function() {
      var list;
      list = container.find('ul').empty();
      element.find('option').each(function() {
        var entry;
        entry = createLine(this);
        entry.bind('click.dropdown', function() {
          return container.trigger('dropdown.select', $(this).attr('data-value'));
        });
        return list.append(entry);
      });
      return container.trigger('dropdown.select', element.find(':selected').val());
    });
    container.bind('dropdown.select', function(event, value) {
      var placeholder, selected;
      selected = container.find("a[data-value=" + value + "]");
      placeholder = container.find('.dropdown-current');
      placeholder.text('');
      element.val('');
      if (selected.size()) {
        placeholder.text(selected.text());
        element.val(value);
        selected.addClass('selected');
      }
      return container.trigger('dropdown.hide');
    });
    container.bind('dropdown.move', function() {
      var items, success;
      items = container.find('.dropdown-items');
      success = function() {
        return container.toggleClass('expanded');
      };
      if (settings.slide) {
        return items.slideToggle(success);
      } else {
        return items.fadeToggle(success);
      }
    });
    container.bind('dropdown.hide', function() {
      var items, success;
      items = container.find('.dropdown-items');
      success = function() {
        return container.removeClass('expanded');
      };
      if (settings.slide) {
        return items.slideUp(success);
      } else {
        return items.fadeOut(success);
      }
    });
    return container.find('.dropdown-current, .dropdown-expand').bind('click', function(event) {
      event.stopPropagation();
      event.preventDefault();
      return container.trigger('dropdown.move');
    });
  };
}).call(this);
