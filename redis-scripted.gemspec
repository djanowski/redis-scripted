Gem::Specification.new do |s|
  s.name              = "redis-scripted"
  s.version           = "0.0.2"
  s.summary           = "A Ruby client that supports the experimental scripting feature of Redis"
  s.authors           = ["Damian Janowski"]
  s.email             = ["djanowski@dimaion.com"]
  s.homepage          = "http://github.com/djanowski/redis-scripted"

  s.add_dependency("redis")

  s.files = Dir[
    "LICENSE",
    "README*",
    "Rakefile",
    "bin/*",
    "*.gemspec",
    "test/*.*"
  ]
end
