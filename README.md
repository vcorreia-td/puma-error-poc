# MyServiceName

`Small description of the service, including its main objective and functionalities.`

## Requirements

To run this system, the following tools are required:

* JRuby 9.1.7.0 or Ruby 2.3.1
* Bundler

### Private dependencies

To install the private dependencies on talkdesk's github repositories, you need to configure bundler to use a github oauth token.

To do so, go to https://help.github.com/articles/creating-an-access-token-for-command-line-use/ to create a new token, and then define the BUNDLE_GITHUB__COM environment variable using the resulting token:

```
# add this to your .bashrc or .zshrc
export BUNDLE_GITHUB__COM=github-oauth-token-you-just-generated:x-oauth-basic
```

This will work both for installing and running the gem dependencies locally, and for doing development inside docker. Do note that just configuring bundler (e.g. as described here) is NOT ENOUGH to get the docker environment working.

## Environment setup

Required environment variables:

`List here ENV vars which the service will not function without`

Optional knobs:

`List here ENV vars that do not need to be set and their defaults`

* `RACK_ENV`: Used to configure the current application environment, e.g. `production`, `qa`, `staging`, `test` or `development` (defaults to `development`)
* `APP_NAME`: Application name, used in reporting and logging (defaults to `?????????`)
* `APP_VERSION`: Application version for logging (defaults to heroku metadata if available, else `ENV['RACK_ENV']`)
* `BUGSNAG_API_KEY`: Bugsnag Notifier API Key will configure bugsnag notifier to emit all notifications to the bugsnag application represented by this key (no default)
* `PUMA_PROCESS_THREADS`: Number of threads per puma process (default to `16`)
* `LOG_LEVEL`: severity level for logs (defaults to `info`, when `RACK_ENV`=`test` defaults to `warn`)

## Run tests

`./bin/rspec`

### Docker

* jruby: `docker-compose build tests && docker-compose run tests`
* mri: `docker-compose build tests-mri && docker-compose run tests-mri`

## Start web server

`./bin/puma config.ru`

### Docker

* jruby: `docker-compose build dev && docker-compose run dev`
* mri: `docker-compose build dev-mri && docker-compose run dev-mri`

## Web API

`Point to your API documentation, ideally auto-generated with Swagger`

## Architectural Overview

```
Description of the service architecture or link to it
Example: https://github.com/Talkdesk/contacts-intake-worker#architecture
```
