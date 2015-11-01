class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pas
  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  attr_accessor :word_with_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)

    raise ArgumentError if letter == ''
    raise ArgumentError if !letter
    raise ArgumentError if letter.upcase == letter.downcase  # raise if not a letter a, ..., z || A, ..., Z

    puts "BEFORE @word: #{@word}, letter: #{letter}, found: NA, @structure: #{@structure}, @guesses: #{@guesses}, @wrong_guesses: #{@wrong_guesses}"

    if @guesses.downcase.include?(letter.downcase)
      puts "letter: #{letter}, @guesses: #{@guesses} @wrong_guesses: #{@wrong_guesses} return"
      return true
    end

    if @wrong_guesses.downcase.include?(letter.downcase)
      puts "letter: #{letter}, @guesses: #{@guesses}, @wrong_guesses: #{@wrong_guesses} return"
      return true
    end

    if @word_with_guesses == ''
      @word.each_char do |l|
        @word_with_guesses += '-'
      end
    end

    found = false
    index = 0
    @word.each_char do |l|
      if l.downcase == letter.downcase
        found = true
        @word_with_guesses[index] = letter
      end
      index += 1
    end

    if found
      @guesses += letter.downcase
    else
      @wrong_guesses += letter.downcase
    end

    puts "AFTER @word: #{@word}, letter: #{letter}, found: #{found}, @structure: #{@structure}, @guesses: '#{@guesses}', @wrong_guesses: '#{@wrong_guesses}', @wrong_guesses.length: #{@wrong_guesses.length}"
    puts

    return true

  end

  def check_win_or_lose

     if !@word_with_guesses.include?('-')
       puts "win"
       return :win
     elsif @wrong_guesses.length >= 7
       puts "lose"
       :lose
     else
       puts "play"
       :play
     end
  end

end
