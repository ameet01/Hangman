class Game
  WORD_BANK = ['astronaut', 'elephant', 'mongoose', 'vileplume',
    'learning', 'catastrophe', 'metamorphosis', 'cranium', 'bazooka']
  attr_accessor :word, :strikes, :fake_word, :input

  def initialize
    @word = random_word
    @strikes = 0
    @fake_word = Array.new(@word.length).map { |_| '_' }
  end

  def random_word
    WORD_BANK.sample
  end

  def play
    puts "\n\nHangman is now underway! Please guess letters. You have until 6 strikes!"

    until @fake_word.join('') == @word || strikes == 6
      guess_letter

      if !guess_is_a_single_letter(input)
        puts "\n"
        puts 'Please guess only one letter!!!!!!!!!!!!!!'
        next
      end

      compute_input
    end

    check_winner
  end

  def compute_input
    if is_inside_word(input)
      word_indices = indices(input)
      word_indices.each do |i|
        @fake_word[i] = input
      end
    else
      @strikes += 1
    end
  end

  def guess_letter
    puts "\n"
    puts 'Strikes: ' + strikes.to_s
    puts "\n"
    puts fake_word.join(' ')
    puts 'Please guess a letter in the word: '
    @input = gets.chomp
  end

  def check_winner
    if strikes == 6
      puts "\n\nYou Lose!"
    elsif @fake_word.join('') == @word
      puts "\n\nYOU WIN THE FUCKING GAME!"
    end
  end

  def is_inside_word(letter)
    return true if @word.include?(letter)
    false
  end

  def guess_is_a_single_letter(input)
    alphabet = ('a'..'z').to_a
    return true if alphabet.include?(input.downcase)
    false
  end

  def indices(letter)
    indexes = []
    (0...@word.length).each do |i|
      if @word[i] == letter
        indexes << i
      end
    end
    indexes
  end

end



game = Game.new
game.play
