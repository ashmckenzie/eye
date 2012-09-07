ENV['BUNDLE_GEMFILE'] = File.expand_path('../../Gemfile', __FILE__)

require "bundler/setup"
Bundler.require(:default, :development)

require File.expand_path('../ey', __FILE__)
require File.expand_path('../ey/config', __FILE__)
require File.expand_path('../ey/server', __FILE__)
require File.expand_path('../ey/servers', __FILE__)

require 'logger'
require 'net/ssh'
require 'yaml'
