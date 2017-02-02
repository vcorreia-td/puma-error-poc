# JRUBY

Collection of important jruby development and production configuration information.

Original Author: @ivoanjo

## JRuby and JVM configuration

The `JRUBY_OPTS` environment variable can be used to configure JRuby and the JVM (when started implicitly via `jruby` or another ruby-based command). JVM options need to be prefixed with `-J`.

**By default, JRuby sets the JVM's maximum heap size to 500MiB.**

To raise this maximum to 2GiB, but to have the JVM start with only 1GiB, you can do:

```bash
export JRUBY_OPTS="-J-Xmx2g -J-Xms1g"
```

## Tuning JVM memory usage

The heap memory alluded to above is only one of several memory spaces that the JVM uses. In particular, you may want to:

* Tune the size of the code cache using `-XX:ReservedCodeCacheSize` (also `-XX:+PrintCodeCache` may be useful to tune this information)
* Tune the maximum size of the meta space using `-XX:MaxMetaspaceSize`
* Tune the stack size of threads using `-Xss` (e.g. `-Xss512k` for KiB per thread)

Other useful JVM flags:

* `-XX:+PrintGCDetails` prints garbage collection information
* `-XX:+CrashOnOutOfMemoryError` makes the JVM "abort" when it runs out of memory, instead of throwing out of memory exceptions

## Tuning JRuby for production performance

The `compile.invokedynamic` JRuby option is off by default as it causes slower application start-up and warm-up times, but benchmarking has shown a 26% speedup when using it: http://ivoanjo.me/blog/2017/01/29/benchmarking-jruby-invokedynamic/ .

Thus, it is strongly recommended that in a production environment this service be launched with `-Xcompile.invokedynamic=true`.

## Making JRuby startup time go away

When you start JRuby, it needs to boot the JVM and then load a lot of the JRuby code. Furthermore, JRuby and the JVM by default optimize for steady-state performance, not quick start-up time.
Altogether this makes the default JRuby startup time rather uncomfortable for development.

The [JRuby wiki](https://github.com/jruby/jruby/wiki/Improving-startup-time) contains several suggestions on how to speed up startup time.

In particular, the easiest is adding

```bash
export JRUBY_OPTS='--dev'
```

to your local shell configuration. This will ask the JRuby launcher to optimize for start-up time, instead of steady-state performance (e.g. long-running tasks will take longer).

In addition to the above configuration, running commands inside bundler with `bundle exec` generally takes longer. This happens because executing bundler loads up a new JVM with JRuby, but then `bundle exec` spawns a new JVM to execute the target application.

To work around this, the best solution is to use `bundle install --binstubs` when installing the dependencies using bundler. The `--binstubs` command instructs bundler to create in the `bin/` folder a small stub to execute the various ruby commands from the gems in use in the `Gemfile`.

By using a stub---for instance `bin/rspec` rather than `bundle exec rspec`---you avoid the extra JVM that has to be spun up via `bundle exec`, and still get the same enviroment (with the correct gems loaded, and only those) you would get with `bundle exec`.

So, when possible, instead of `bundle exec <command>` use just `bin/<command>`.

As an alternative, you can also use the command without `bundle exec` by using `<command>` or even better `jruby -S <command>` but you will not get the version checking and loading that bundler provides.

As a quick example, on my machine with a small test suite (e.g. just testing bootup):
* `bundle exec rspec` takes around ~11.5s
* `bundle exec rspec` with `JRUBY_OPTS='--dev'` defined takes around 6.1s
* `bin/rspec` with `JRUBY_OPTS='--dev'` defined takes around 4.3s

### TL;DR
* When running specs via docker you're all set (the best configuration is baked in our configs)
* When running outside of docker, `export JRUBY_OPTS='--dev'` and use `bin/<command>` to start ruby applications

## Cool things you can do with JRuby

Some self-promotion recommended reading:

* http://ivoanjo.me/blog/2016/07/16/down-the-jruby-rabbit-hole/
* http://ivoanjo.me/blog/2016/07/17/another-round-of-jruby-goodness/
