require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @players = []
    @board = Board.new
    @current_player = nil
  end

  def create_player
    print 'Enter a player\'s name and desired color seperated by a space ("Bob white"): '
    player_attributes = gets.chomp.split(' ')
    Player.new(player_attributes[0], player_attributes[1])
  end

  def get_move
    print "#{@current_player.name} (#{@current_player.color}), enter coordinants of your desired piece and the the coordinates of your desired move seperated by a space (c2 c4): "
    gets.chomp.split(' ')
  end

  def setup
    @players << create_player
    @players << create_player
    @current_player = @players.find { |player| player.color == 'white' }
  end

  def switch_players
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end

  def game_over?
    @board.checkmate?(@current_player.color.to_sym) || @board.stalemate?(@current_player.color.to_sym)
  end

  def play
    setup
    @board.display

    until game_over? do
      begin
        puts 'Check!' if @board.check?(@current_player.color.to_sym)
        move = get_move
        start_position = move.first
        end_position = move.last
        @board.move_piece(start_position, end_position)

      rescue => e
        puts e.message
        retry
      end

      @board.display
      switch_players
    end

    checkmate = @board.checkmate?(@current_player.color.to_sym)
    stalemate = @board.stalemate?(@current_player.color.to_sym)
    
    switch_players
    puts "Checkmate! #{@current_player.name} won!" if checkmate
    puts "Stalemate. Play again!" if stalemate
  end
end
