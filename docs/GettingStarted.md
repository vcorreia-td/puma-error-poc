# Bootstraping your project from this template

This will guide through the process bootstraping your project from this template.

### Choose your project's name

Let assume you chose `awesome_api`.

### Clone the project

* `git clone git@github.com:Talkdesk/ruby-service.git awesome_api`.
* `cd awesome_api`

### Check if everything is running

* `rvm use jruby-9.1.12.0`
* `bundle install`

This should install all dependencies and create a `Gemfile.lock`.

* `./bin/pry`            # should be able to start a pry console
* `./bin/rspec`          # should be able to run rspec
* `./bin/puma config.ru` # should be able to start the web server

### Run the bootstrap rake task

* `bundle exec rake "ruby_service:bootstrap[awesome_api]"`

This will rename files and directories named `my_service_name`, which is the default name used in the template. All occurrences of `my_service_name` and `MyServiceName` inside all files will also be replaced by the new service name `awesome_api` and module name `AwesomeApi`.

The rake task also supports an optional second argument to control the camel-cased project name:

* `bundle exec rake "ruby_service:bootstrap[awesome_api,AwesomeAPI]"`

### Setting up your remote

Several files have been changed after this, I suggest you check if everything is as expected and commit the changes.

* `git add --all`
* `git commit -v` # check diff and add your commit message

Assuming you already created a git remote repository for your project

* `git remote set-url origin git@github.com:Talkdesk/awesome-api`
* `git push -u origin master`

Follow [Setup Tooling Guide](./SetupTooling.md) to setup different tools we use at Talkdesk.

### That's it! You're good to go :)
