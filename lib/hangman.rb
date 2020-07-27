
module HangmanFormulae
end

class Squares
end

class Hangman 

  def initialize
  end

end

original_list = File.open("5desk.txt")
hidden_word_list = []

original_list.each do |line|
  if line.strip.length > 4 && line.strip.length < 13
    hidden_word_list.push(line)
  end
end

secret_word = hidden_word_list.sample

puts secret_word
