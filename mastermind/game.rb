require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @board = Board.new
    @player = nil
    @start_time = nil
    @end_time = nil
  end

  def create_player
    print 'Please enter your name: '
    name = gets.chomp
    @player = Player.new(name)
  end

  def turn(turn_number)
    print "\nEnter your guess number #{turn_number}, #{@player.name} (R, G, B, Y, W, K): "
    combo_guess = gets.chomp.upcase.chars
    @board.combo_guess = combo_guess
    @board.give_combo_feedback
    puts "\n#{'⚫' * @board.black_pegs} #{'⚪' * @board.white_pegs}"
  end

  def print_instructions
    puts <<-INSTRUCTIONS

    ----------INSTRUCTIONS----------
    Welcome to mastermind!
    In this program the computer
    will create a secret code
    consisting of 4 colors.

    The color options are:
    Red - "R"
    Green - "G"
    Blue - "B"
    Yellow - "Y"
    White - "W"
    Black - "K"

    You have 12 tries to guess the
    secret code.

    Enter your input seperated by
    no spaces. -- "RBGK"

    The computer will return black &
    white pegs. 

    A black peg means that one of
    your suspected colors is correct
    AND in the CORRECT position.

    A white peg means that one of 
    your suspected colors is correct
    BUT in the INCORRECT position.

    Try to beat the computer!
    -------------ENJOY--------------
    
    INSTRUCTIONS
  end

  def win?
    @board.black_pegs == 4
  end

  def lose? (turn_number)
    turn_number == 12 && @board.black_pegs < 4
  end

  def play
    print_instructions
    create_player
    @start_time = Time.now
    puts "\nTimer started"

    (1..12).to_a.each do |turn_number|
      turn(turn_number)
      if win?
        @end_time = Time.now
        puts "Correct, the colors were #{@board.combo.join(' ')}! It took you #{(@end_time - @start_time).round(1)} seconds, and #{turn_number} turn#{turn_number > 1 ? 's' : ''}!"
        break
      elsif lose?(turn_number)
        @end_time = Time.now
        puts "You lose! The colors were #{@board.combo.join(' ')}. You spent #{(@end_time - @start_time).round(1)} seconds."
        break
      else
        next
      end
    end
  end
end
