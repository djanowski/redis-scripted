require "cutest"

def root(path)
  File.expand_path("../#{path}", File.dirname(__FILE__))
end

require root("lib/redis/scripted")

redis = Redis::Scripted.new(port: 6399, scripts_path: root("test/scripts"))

prepare do
  Process.kill(:INT, File.read("test/redis.pid").to_i) if File.exist?("test/redis.pid")
  `redis-server test/redis.conf`
  sleep 0.1
end

test "runs Lua code" do
  redis.sadd("foo", "s1")
  redis.sadd("foo", "s2")
  redis.sadd("bar", "s1")

  assert_equal redis.sintercard(["foo", "bar"]), 1
end

test "sends keys and values" do
  redis.msadd(["foo"], %w(s1 s2 s3))

  assert_equal %w(s1 s2 s3), redis.smembers("foo").sort
end

test "uses EVALSHA" do
  redis.sadd("foo", "s1")
  redis.sadd("foo", "s2")
  redis.sadd("bar", "s1")

  redis.sintercard(["foo", "bar"])

  assert_equal Redis.new(port: 6399).client.call(:evalsha, "d76ce5687840f0436ae4c09c50564cf0e537395e", 2, "foo", "bar"), 1
end
