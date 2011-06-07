`Redis::Scripted`
===

A Ruby client that supports the experimental scripting feature in Redis.

Usage
---

Drop your Lua scripts in `./scripts`:

    scripts/
    ├── msadd.lua
    └── sintercard.lua

Then initialize the connection to Redis, passing the path where the
class should look for scripts:

    require "redis/scripted"

    redis = Redis.connect(scripts_path: "./scripts")

The scripts are defined as instance methods for convenience:

    redis.msadd(["foo"], ["s1", "s2", "s3"])

Note that `msadd` receives two arguments at most: one array for the keys
and another for the values. This is necessary because of [how `EVAL`
works](http://antirez.com/post/scripting-branch-released.html).

Acknowledgments
===

Code was inspired by [mkrecny](https://github.com/mkrecny/redis-extend)
and [catwell](https://github.com/catwell/redis-extend).
