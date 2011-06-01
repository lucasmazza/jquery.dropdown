# jquery.dropdown

Custom select elements without hassle (or tons of CSS).

## Usage

    $('#element').dropdown();

## Grab the code.

The plugin uses [CoffeeScript](http://jashkenas.github.com/coffee-script) and [Stylus](http://learnBoost.github.com/stylus). The generated Javascript and CSS is located at both `dist/` and `lib/`.

## Events

* `dropdown.move` - Hide or display the dropdown element.
* `dropdown.hide` - Hide the dropdown element.
* `dropdown.select` - Selects the given value in the dropdown and the associated element.
* `dropdown.refresh` - Recreates the dropdown list with the associated select options.

## TODO
* Support optgroups;
* Be aware of disabled selects;
* Fixed height support;
* More examples;
* Browser/CSS testing.

## License

(The MIT License)

Copyright (c) 2011 Lucas Mazza &lt;luc4smazza@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.