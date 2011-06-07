require "cutest"
require "tmpdir"

test "gem" do
  Dir.mktmpdir do |path|
    file = `gem build redis-scripted.gemspec 2>/dev/null`[/File: (.*)$/, 1]

    `env GEM_HOME=#{path} gem install #{file}`

    assert_equal "Redis::Scripted", `env GEM_HOME=#{path} ruby -r redis/scripted -e 'puts Redis::Scripted'`.chomp
  end
end
