module HangmanForms
  def start
    original_list = File.open("5desk.txt")
    hidden_word_list = []

    original_list.each do |line|
      line.strip
        if line.length > 4 && line.length < 13
        hidden_word_list.push(line)
        end
    end

    secret_word = hidden_word_list.sample

    guess_word = secret_word.strip.split("")
    
    blank_word = Array.new(guess_word.length, "_".strip)

    puts blank_word
  end
end

class Hangman 
include HangmanForms
  def initialize
    start
  end

  def guess
    case gets.strip
      if 
  end

end

Hangman.new