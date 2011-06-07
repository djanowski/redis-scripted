require "redis"
require "digest/sha1"

class Redis::Scripted < Redis
  def initialize(options = {})
    path = options.delete(:scripts_path)

    super(options)

    if path
      Dir["#{path}/*.lua"].each do |file|
        name = File.basename(file, ".lua")
        _define_script_method(name, File.read(file))
      end
    end
  end

  def evalsha(sha, keys = [], values = [])
    synchronize do
      @client.call(:evalsha, sha, keys.size, *keys, *values)
    end
  end

  def eval(script, keys = [], values = [])
    synchronize do
      @client.call(:eval, script, keys.size, *keys, *values)
    end
  end

private

  def _define_script_method(name, script)
    sha = Digest::SHA1.hexdigest(script)

    self.class.send(:define_method, name) do |keys, values = []|
      synchronize do
        begin
          evalsha(sha, keys, values)
        rescue RuntimeError => e
          if e.message =~ /^NOSCRIPT/
            eval(script, keys, values)
          else
            raise e
          end
        end
      end
    end
  end
end
