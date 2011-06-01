version = "0.0.1"

coffee_path = File.expand_path("../src/jquery.dropdown.coffee",   __FILE__)
stylus_path = File.expand_path("../src/jquery.dropdown.styl",     __FILE__)
css_path    = File.expand_path("../dist/jquery.dropdown.min.css", __FILE__)
js_path     = File.expand_path("../dist/jquery.dropdown.min.js",  __FILE__)

desc 'Builds both the CoffeeScript and Stylus sources to dist/'
task :build do
  require 'bundler/setup'
  Bundler.require

  puts "Building #{js_path} [version #{version}]"
  File.open(js_path, 'w') do |io|
    js = CoffeeScript.compile(File.read(coffee_path))
    io.write(Uglifier.new.compile(js))
  end

  puts "Building #{css_path} [version #{version}]"
  File.open(css_path, 'w') do |io|
    css = Stylus.compile(File.read(stylus_path), :compress => true)
    io.write(css)
  end
end