require 'rubygems'
require 'bundler'
Bundler.require(:default)

configure do
  Mongoid.load!("./database.yml", :development)
end