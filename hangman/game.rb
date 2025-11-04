require_relative 'board'

class HangmanGame
  attr_reader :code_word
  def initialize
    @board = Board.new
    @all_words = File.read("./words.txt").split("\n")
    @code_word = nil
  end

  def get_word
    valid_words = []

    @all_words.each do |word|
      if word.length >= 5 && word.length <= 12
        valid_words << word
      end
    end

    @code_word = valid_words.sample
  end

  def create_board
    @code_word.chars.each_with_index do |char, i|
      @board.letters[i] = "_"
    end
  end

  def show_board
    system("clear")
    @board.show
  end

  def evaluate_guess(guess)
    if guess.length == 1
      if @code_word.include?(guess)
        @code_word.chars.each_with_index do |char, i|
          @board.letters[i] = char if char == guess
        end
      else
        @board.wrong_letters << guess
      end
    else
      if @code_word == guess
        @code_word.chars.each_with_index do |char, i|
          @board.letters[i] = char
        end
      end
    end
  end

  def game_won?
    @code_word == @board.letters.values.join
  end

  def turn
    @board.attempt_count -= 1

    print 'Enter letter guess (or full word when guessing): '
    guess = gets.chomp

    evaluate_guess(guess)

    show_board
  end

  def play
    get_word
    create_board
    show_board

    until @board.attempt_count == 0 || game_won?
      turn
    end

    if game_won?
      puts "Correct! The word was #{@code_word}. It took you #{(6 - @board.attempt_count)} guesses."
    else
      puts "You lose! The word was #{@code_word}. Try again!"
    end
  end
end
