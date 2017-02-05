# Bootstraping your project from this template

This will guide through the process bootstraping your project from this template.

### Choose your projects name

Let assume you chose `awesome_api`.

### Clone the project

* `git clone git@github.com:Talkdesk/ruby-service.git awesome_api`.
* `cd awesome_api`

### Check if everything is running

* `rvm use jruby-9.1.7.0`
* `bundle install`

This should install all dependencies and create a `Gemfile.lock`.

* `./bin/pry`            # should be able to start a pry console
* `./bin/rspec`          # should be able to run rspec
* `./bin/puma config.ru` # should be able to start the web server

### Run the bootstrap rake task

* `bundle exec rake "ruby_service:bootstrap[awesome_api]"`

This will rename and files and directories name `my_service_name`, which is the default name used in the template, as well as, replace all occurrences of `my_service_name` and `MyServiceName` inside all files. Inteads, the name you have as an argument will appear.

### Setting up your remote

Several files have been changed after this, I suggest you check if everything is as expected and commit the changes.

* `git add --all`
* `git commit -v` # check diff and add your commit message

Assuming you already created a git remote repository for your project

* `git remote add origin git@github.com:Talkdesk/awesome-api`
* `git push -u origin master`

### Thats it! You're good to go :)
