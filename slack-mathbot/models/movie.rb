require 'rubygems'
require 'sinatra'
require 'mongoid'

class Movie
  include Mongoid::Document
  store_in collection: "industry_titles"

  index(search_field: 'text' )
end


