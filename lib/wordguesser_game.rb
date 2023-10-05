class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

attr_reader :word, :guesses, :wrong_guesses

  def initialize(word) #Constructor
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter) # letter representa la letra que se está adivinando.
    raise ArgumentError, 'Invalid guess' unless letter =~ /^[a-zA-Z]$/
    letter.downcase!
    
    if @word.include?(letter)
      return false if @guesses.include?(letter)
      @guesses << letter
    else 
      return false if @wrong_guesses.include?(letter)
      @wrong_guesses << letter
    end
    
    true
     
  end 
  
  def word_with_guesses
    result = ''
    @word.chars do |letter|
      if @guesses.include?(letter)
        result << letter
      else
        result << '-'
      end
    end
    result
  end
  
  
  def check_win_or_lose
    return :win if word_with_guesses == @word
    return :lose if @wrong_guesses.length >= 7
    :play
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
