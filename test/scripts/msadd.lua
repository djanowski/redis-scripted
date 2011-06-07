local count = 0

for i,value in ipairs(ARGV) do
  count = count + redis.call("sadd", KEYS[1], value)
end

return n
