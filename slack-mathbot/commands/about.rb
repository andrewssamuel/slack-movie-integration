require 'mongoid'
require './slack-mathbot/models/movie_finder'
require './slack-mathbot/models/message_formatter'

module SlackMathbot
  module Commands
    class Default < SlackRubyBot::Commands::Base
      match(/(.*)/) do |client, data, _match|
        begin
          if (/detail/.match(_match.to_s))
            if (match = /(.*):\d{4}/.match(_match.to_s))
              match_str = match.to_s
              _year = match_str.split(':')[1]
              _search_title = match_str.split(':')[0]

              client.say(channel: data.channel, text: messageFormatter.genericMessage(movieFinder.findAllMoviesWithYear(_search_title, _year, _limit=5)))
            elsif (match = /^find all the movies of (?<selector>.*)\sdetail/i.match(_match.to_s))
              _select = match[:selector].to_s
              puts "----distributor #{_select}"
              if (/\d{4}/.match(_select))
                client.say(channel: data.channel, text: messageFormatter.genericMessage(movieFinder.findAllMoviesByYear(_select, _limit=5)))
              else
                puts "----distributor #{_select}"
                client.say(channel: data.channel, text: messageFormatter.genericMessage(movieFinder.findAllMoviesByDistributor(_select, _limit=5)))
              end
            else
              rematch = /(?<movie>.*)\sdetail/.match(_match.to_s)
              client.say(channel: data.channel, text: messageFormatter.genericMessage(movieFinder.findAllMovies(rematch[:movie], _limit=5)))
            end
          elsif (/(.*):\d{4}/.match(_match.to_s))
            match_str = _match.to_s
            _year = match_str.split(':')[1]
            _search_title = match_str.split(':')[0]

            client.say(channel: data.channel, text: messageFormatter.titleMessage(movieFinder.findAllMoviesWithYear(_search_title, _year, _limit=20)))
          elsif (match = /^find all the movies of (?<selector>.*)/i.match(_match.to_s))
            _select = match[:selector].to_s
            if (/\d{4}/.match(_select))
              client.say(channel: data.channel, text: messageFormatter.titleMessage(movieFinder.findAllMoviesByYear(_select, _limit=20)))
            else
              client.say(channel: data.channel, text: messageFormatter.titleMessage(movieFinder.findAllMoviesByDistributor(_select, _limit=20)))
            end
          else
            client.say(channel: data.channel, text: messageFormatter.titleMessage(movieFinder.findAllMovies(_match, _limit=20)))
          end

        rescue Exception => msg
          if(/^*help/.match(_match.to_s))
            client.say(channel: data.channel, text: "1. <title name>=> Full text search with title field & result limit 20 records sort_by { |release year | descending  } ex: `Ted 2`
                                                    \n 2. <title name> detail => (Detail View) Full text search with title field & result limit 5 records sort_by { |release year| descending  } ex: `Ted 2 detail`
                                                    \n 3. <title name>:<year(YYYY)> => Full text search with title & release year and result limited 20 records sort_by { |release year| decending } ex:`Ted 2:2015`
                                                    \n 4. <title name>:<year(YYYY)> => (Detail View) Full text search with title & release year and result limited 20 records sort_by { |release year| decending } ex:`Ted 2:2015 detail`
                                                    \n 5. find all the movies of <distributor name> => Full text search with distributor and result limited 20 records sort_by { |release year| decending } ex:`find all the movies of universal`
                                                    \n 6. find all the movies of <distributor name> detail => (Detail View) Full text search with distributor and result limited 20 records sort_by { |release year| decending } ex:`find all the movies of universal detail`
                                                    \n 7. find all the movies of <Year(YYYY) => Filter the titles with year and result limited 20 records sort_by { |release year| decending } ex:`find all the movies of 2016`
                                                    \n 8. find all the movies of <Year(YYYY) detail => (Detail View) Filter the titles with year and result limited 20 records sort_by { |release year| decending } ex:`find all the movies of 2016 detail`
                                                    ")
            else
            client.say(channel: data.channel, text: "Sorry, I am not able to transcript your query. Please validate your query with '*help' command")
          end
        end
      end

      def self.messageFormatter
        MessageFormatter.new
      end

      def self.movieFinder
        MovieFinder.new
      end

    end

  end
end


