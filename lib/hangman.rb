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

    @@turn = 1

    @@tries = 5

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
    else 
      puts "not included"
      @@tries -= 1
    end
    @@guessed_letters.push(lett)
    puts "\n#{@@blank_word.join(" ")}"
  end
end

class Hangman 
include HangmanForms
  def initialize
    start
    status
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
      elsif @@guessed_letters.include?(letter_input)
        puts "try a different letter"
      else
        puts "ok"
        @@letter_guess = letter_input
        letter_check(@@letter_guess)
        @@turn += 1
      end
    else 
      puts "please input letter"
    end
    status
    gameOver == true ? gameOver : guess
  end

  def status
    puts "Guessed Letters: #{@@guessed_letters.sort.join(", ")}"
    puts "Turn: #{@@turn}"
    puts "Incorrect Tries Remaining: #{@@tries}"
  end

  def gameOver
    if @@blank_word == @guess_word
      puts "YOU WIN"
      return playAgain
    elsif @@tries == 0
      puts "YOU LOSE"
      return playAgain
    end
  end

  def playAgain
    puts "Play again? (Y/N)"
    loop do
      case (gets.chomp.downcase)
      when 'y' 
        Hangman.new
      when 'n' 
        exit!
      else 
        puts "Please input Y or N"
      end
    end
  end

end

Hangman.new