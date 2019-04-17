require "erb"
require_relative "./game"

class Application
  def initialize
    @template = File.read("./lib/start.html.erb")
    self.reset
  end

  def call(env)
    req = Rack::Request.new(env)
    res = Rack::Response.new

    unless req.params.empty?
      play = req.params["play"].to_i
      if play == -1
        self.reset
      else
        move(@board, play, current_player(@board))
      end
    end

    if over?(@board)
      if draw?(@board) then @game_over_message = "Draw" end
      if won?(@board) then @game_over_message = "#{winner(@board)} Wins!" end
    end

    res.write ERB.new(@template).result(binding)
    res.finish
  end

  def reset
    @board = (0..8).to_a
    @game_over_message = ""
  end
end
