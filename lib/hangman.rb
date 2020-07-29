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

    @@secret_word = hidden_word_list.sample

    @@guess_word = @@secret_word.strip.split("")
    
    @@blank_word = Array.new(@@guess_word.length, "_".strip)

    @@letter_guess = ""

    @@guessed_letters = []

    puts @@guess_word
    puts @@blank_word.join(" ")

  end

  def letter_check(lett)
    j=0
    if @@guess_word.include?(lett)
      puts "included"
      while j < @@guess_word.length
        if @@guess_word[j] == lett
          @@blank_word[j] = lett
        end
        j+=1
      end
      puts @@blank_word.join(" ")
    else 
      puts "not included"
    end
    @@guessed_letters.push(lett)
  end
end

class Hangman 
include HangmanForms
  def initialize
    start
    guess
  end

  def guess
    i = 1
    puts "Please input a letter"
    letter_input = gets.strip
    case letter_input
    when /[a-zA-Z]/
      if letter_input.length != 1
        puts "don't"
        guess
      else
        puts "ok"
        @@letter_guess = letter_input
        letter_check(@@letter_guess)
      end
    else 
      puts "please input letter"
    end
  end

end

Hangman.new