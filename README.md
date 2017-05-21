# [Getting Started with ruby-service](docs/GettingStarted.md)

# MyServiceName

`Small description of the service, including its main objective and functionalities.`

* [MyServiceName](#myservicename)
* [Requirements](#requirements)
  * [Private dependencies](#private-dependencies)
* [Environment setup](#environment-setup)
* [Switching between Ruby Engines (MRI &amp; JRuby)](#switching-between-ruby-engines-mri--jruby)
  * [1. How to switch your ruby engine](#1-how-to-switch-your-ruby-engine)
  * [2. Replace the contents of .ruby-version](#2-replace-the-contents-of-ruby-version)
  * [3. Additional info](#3-additional-info)
* [JRuby](#jruby)
* [Debugging](#debugging)
* [Rubocop](#rubocop)
* [Run tests](#run-tests)
  * [Docker](#docker)
* [Start web server](#start-web-server)
  * [Docker](#docker-1)
* [Start console](#start-console)
  * [Docker](#docker-2)
* [Continuous Integration/Delivery (CI/CD)](#continuous-integrationdelivery-cicd)
* [Web API](#web-api)
* [Architectural Overview](#architectural-overview)

<sub><sup>ToC created with [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)</sup></sub>

# Requirements

To run this system, the following tools are required:

* JRuby 9.1 or Ruby 2.4
* Bundler

## Private dependencies

To install the private dependencies on talkdesk's github repositories, you need to configure bundler to use a github oauth token.

To do so, go to https://help.github.com/articles/creating-an-access-token-for-command-line-use/ to create a new token, and then define the BUNDLE_GITHUB__COM environment variable using the resulting token:

```
# add this to your .bashrc or .zshrc
export BUNDLE_GITHUB__COM=github-oauth-token-you-just-generated:x-oauth-basic
```

This will work both for installing and running the gem dependencies locally, and for doing development inside docker. Do note that just configuring bundler (e.g. as described here) is NOT ENOUGH to get the docker environment working.

# Environment setup

Required environment variables:

`List here ENV vars which the service will not function without`

* `API_KEYS`: Used to validate authentication keys submitted in requests (Can be not set when `RACK_ENV=development`)

Optional knobs:

`List here ENV vars that do not need to be set and their defaults`

* `RACK_ENV`: Used to configure the current application environment, e.g. `production`, `qa`, `staging`, `test` or `development` (defaults to `development`)
* `APP_NAME`: Application name, used in reporting and logging (defaults to `my_service_name`)
* `APP_VERSION`: Application version for logging (defaults to heroku metadata if available, else `ENV['RACK_ENV']`)
* `BUGSNAG_API_KEY`: Bugsnag Notifier API Key will configure bugsnag notifier to emit all notifications to the bugsnag application represented by this key (no default)
* `PUMA_PROCESS_THREADS`: Number of threads per puma process (defaults to `16`)
* `LOG_LEVEL`: severity level for logs (defaults to `info`, when `RACK_ENV`=`test` defaults to `warn`)

# Switching between Ruby Engines (MRI & JRuby)

## 1. How to switch your ruby engine

JRuby: `rvm use jruby-9.1.9.0`

MRI: `rvm use ruby-2.4.1`

then:
```
$ gem install bundler
$ bundle update --ruby
```

## 2. Replace the contents of `.ruby-version`

JRuby: `jruby-9.1.9.0`

MRI: `ruby-2.4.1`

This way, tools like `rvm` will automatically switch to the specified version when you `cd` into your project directory.

To check which version you are on do: `ruby -v`

## 3. Additional info

* Your `bin/` executables run regardless of the engine.
* Although you can specify the jruby engine in the Gemfile it is not necessary. It will use its environments engine. This way you don't need to change the Gemfile everytime you switch versions.
* JRuby 9.1.9.0 targets the `2.3.3` ruby version. JRuby will not work if you change it.

# JRuby

* [JRuby guide](docs/JRUBY.md)

# Debugging

This project includes the `pry-debugger` gem, so you can use `next`/`step`/`finish`/`continue` inside of pry, but you'll need to add `--debug` to your `JRUBY_OPTS` for these to work.

I recommend only adding that environment variable when you really want to debug something in this way, as it otherwise slows JRuby down **a lot**.

# Rubocop

Check for style offenses by running: `./bin/rubocop`

# Run tests

`./bin/rspec`

## Docker

* jruby: `docker-compose build tests-jruby && docker-compose run tests-jruby`
* mri: `docker-compose build tests-mri && docker-compose run tests-mri`

# Start web server

`./bin/puma config.ru`

## Docker

* jruby: `docker-compose build dev-jruby && docker-compose up dev-jruby`
* mri: `docker-compose build dev-mri && docker-compose up dev-mri`

# Start console

`./bin/console`

## Docker

* jruby: `docker-compose build console && docker-compose run console`
* mri: `docker-compose build console-mri && docker-compose run console-mri`

# Continuous Integration/Delivery (CI/CD)

1. Go to: https://github.com/Talkdesk/jenkins-jobs
2. Read the docs and/or talk to @punnie
3. Open PR to add your project to automatic CI/CD pipeline

# Web API

`Point to your API documentation, ideally auto-generated with Swagger`

# Architectural Overview

```
Description of the service architecture or link to it
Example: https://github.com/Talkdesk/contacts-intake-worker#architecture
```
