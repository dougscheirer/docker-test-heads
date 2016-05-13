#!/bin/bash
bundle exec rake db:create db:migrate
bundle exec unicorn -c config/unicorn.rb -p 9292
