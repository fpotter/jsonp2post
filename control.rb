#!/usr/bin/env ruby
require 'rubygems'
require 'daemons'

pwd = Dir.pwd
Daemons.run_proc('json2post.rb', { :dir_mode => :normal, :dir => "/opt/pids/sinatra"}) do
  Dir.chdir(pwd)
  exec "ruby jsonp2post.rb -p 5200"
end