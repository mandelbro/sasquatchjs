# A new instance of class Specification is created
# The class is namespaced to Gem to avoid collision
# A block is passed to the new method, the instance is passed to the block
Gem::Specification.new do |s|
  s.name        = 'SasquatchJS'
  s.version     = '0.1.0' # major-version.minor-version.patch
  s.date        = '2013-11-19'
  s.summary     = "It's like SASS Watch for JavaScript"
  s.description = "Incredibly new test gem that tests gem mandelbro!"
  s.authors     = ["Mandelbro"]
  s.email       = 'chrismontes@about.me'
  s.files       = ["lib/sasquatchjs.rb"]
  s.homepage    = 'https://rubygems.org/gems/sasquatchjs'
  s.executables << 'sasquatch'
end