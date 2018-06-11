# POC for handling critial subsystem failures

## Introduction
(copied from )

> When the application loses connection to the database it
> becomes unusable and unstable. The solution implemented
> consists in forcefully shut down the application when a
> Postgres connection error happens.
> 
> Since puma is designed to recuperate from any kind of runtime
> errors, there was a need to use Kernel.exit! to terminate
> the application. This method does not run any of the exit
> handlers registered. To address this, the ExitApp module
> was developed.
> 
> This module wraps the Kernel.at_exit method, storing the
> block provided to it. To forcefully terminate the application,
> just call ExitApp.exit_app. It runs all the exit handlers
> and then exits the application.

## How to run

1. Set DB url in `config.ru`
2. Run as with `bundle exec puma -b tcp://0.0.0.0:9292 config.ru` (like in Procfile)

## What I have done 

1. Replicated the problem currently affecting our components
2. Roughly implemented a "retry & reconnect" for DB operations
3. Roughly implemented a strategy where:
    - It spawns a thread trying to reconnect
    - While it's reconnecting, it returns to the client an error, explaining that it's having DB problems

## Endpoints

The corresponding endpoints for the above implementations:

1. `curl -X GET localhost:9292/test/:interaction_id`
2. `curl -X GET localhost:9292/test_retries/:interaction_id`
3. `curl -X GET localhost:9292/test_thread/:interaction_id`




