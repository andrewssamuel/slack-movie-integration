require 'mongoid'
require './slack-mathbot/models/Movie'

class MovieFinder

  def findAllMovies(_search,_limit)
    Movie.collection.find({"TITLE" => /#{_match}/i}).projection({"_id":0}).limit(/#{_limit}/);
  end


  def self.convertJson(_titles)
    JSON.parse(_titles.to_json)
  end

end
