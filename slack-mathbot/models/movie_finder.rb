require 'mongoid'
require './slack-mathbot/models/Movie'

class MovieFinder

  def findAllMovies(_search,_limit)
    @titles = Movie.collection.find({"TITLE" => /#{_search}/i}).sort("YEAR":-1).projection({"_id":0}).limit(_limit);
    return convertJson(@titles)
  end

  def findAllMoviesWithYear(_search,_year,_limit)
    @titles_by_year = Movie.collection.find({"TITLE" => /#{_search}/i,:YEAR => _year.to_i }).sort("YEAR":-1).projection({"_id":0}).limit(_limit)
    return convertJson(@titles_by_year)
  end

  def findAllMoviesByDistributor(_search,_limit)
    @titles_by_distributor = Movie.collection.find({"DISTRIBUTOR" => /#{_search}/i}).sort("YEAR":-1).projection({"_id":0}).limit(_limit)
    return convertJson(@titles_by_distributor)
  end

  def findAllMoviesByYear(_year,_limit)
    @titles_by_distributor = Movie.collection.find({"YEAR" => _year.to_i}).sort("YEAR":-1).projection({"_id":0}).limit(_limit)
    return convertJson(@titles_by_distributor)
  end

  private

  def convertJson(_titles)
    JSON.parse(_titles.to_json)
  end

end
