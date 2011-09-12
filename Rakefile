version = "0.0.3"

coffee_path = File.expand_path("../src/jquery.dropdown.coffee",   __FILE__)
stylus_path = File.expand_path("../src/jquery.dropdown.styl",     __FILE__)
css_path    = File.expand_path("../dist/jquery.dropdown.min.css", __FILE__)
js_path     = File.expand_path("../dist/jquery.dropdown.min.js",  __FILE__)

desc 'Builds both the CoffeeScript and Stylus sources to dist/'
task :build do
  require 'bundler/setup'
  Bundler.require

  puts "Building #{js_path}"
  File.open(js_path, 'w') do |io|
    js = CoffeeScript.compile(File.read(coffee_path))
    io.write(Uglifier.new.compile(js))
  end

  puts "Building #{css_path}"
  File.open(css_path, 'w') do |io|
    css = Stylus.compile(File.read(stylus_path), :compress => true)
    io.write(css)
  end
  `zip jquery.dropdown.#{version}.zip #{js_path} #{css_path}`
  `git tag -a -m "Version #{version}" v#{version}`
end
desc 'builds docs using Docco'
task :docs do
  `docco src/*.coffee && mv docs/jquery.dropdown.html docs/index.html && open docs/index.html`
end