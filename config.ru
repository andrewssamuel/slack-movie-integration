$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'slack-mathbot'
require 'web'
require './app'

Thread.new do
  begin
    SlackMathbot::Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

module BSON
  class ObjectId
    def to_json(*args)
      to_s.to_json
    end

    def as_json(*args)
      to_s.as_json
    end
  end
end


run SlackMathbot::Web
