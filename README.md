# Rails 4.0 Live Chat Example
-----------

##Overview
A Simple Rails 4.0 chatting exmple.

## Requirements

- Ruby ~> 1.9.3
- Ruby On Rails => 4.0beta1
- preinstalled Redis

## installation

    $ git clone https://github.com/kssminus/rails4-live.git
    $ cd rails4-live
    $ bundle install
    $ rails server -d

## Configuration
You may configure redis client from config/initializers/redis.rb(default: "http://localhost:6379")

    redis = Redis.new(:host => "10.0.1.1", :port => 6380)
