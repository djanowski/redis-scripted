task default: :test

desc "Run suite"
task :test do
  require "cutest"

  Cutest.run(Dir["test/*.rb"])
end
