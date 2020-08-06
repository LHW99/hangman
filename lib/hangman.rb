require 'json'

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

    @@secret_word = hidden_word_list.sample.strip.upcase

    @@guess_word = @@secret_word.split("")
    
    @@blank_word = Array.new(@@guess_word.length, "_".strip)

    @@letter_guess = ""

    @@guessed_letters = []

    @@turn = 1

    @@tries = 5

    puts @@blank_word.join(" ")
  end

  def letter_check(lett)
    j=0
    if @@guess_word.include?(lett)
      while j < @@guess_word.length
        if @@guess_word[j] == lett
          @@blank_word[j] = lett
        end
        j+=1
      end
    else 
      @@tries -= 1
    end
    @@guessed_letters.push(lett)
    puts "\n#{@@blank_word.join(" ")}"
  end

  def hangman_values
    "@@secret_word = #{@@secret_word}

    @@guess_word = #{@@guess_word}
    
    @@blank_word = #{@@blank_word}

    @@guessed_letters = #{@@guessed_letters}

    @@turn = #{@@turn}

    @@tries = #{@@tries}"
  end

  def hangman_save
    {:secret_word => "#{@@secret_word}",
    :guess_word => "#{@@guess_word}",
    :blank_word => "#{@@blank_word}",
    :guessed_letters => "#{@@guessed_letters}",
    :turn => "#{@@turn}",
    :tries => "#{@@tries}"}.to_json
  end

  def hangman_load
    reading = File.read("/home/haiduk/odin_projects/hangman/savefile/save.rb")
    parsed = JSON.parse(reading)
    clean_p = parsed
    @@secret_word = clean_p["secret_word"].gsub("\"", "")
    @@guess_word = 
    clean_p["guess_word"].gsub("\"", "").gsub(" ", "")
    .gsub(",", "").gsub("[", "").gsub("]", "").chars
    @@blank_word = 
    clean_p["blank_word"].gsub("\"", "").gsub(" ", "")
    .gsub(",", "").gsub("[", "").gsub("]", "").chars
    @@guessed_letters = 
    clean_p["guessed_letters"].gsub("\"", "").gsub(" ", "")
    .gsub(",", "").gsub("[", "").gsub("]", "").chars
    @@turn = clean_p["turn"].to_i
    @@tries = clean_p["tries"].to_i
    puts @@blank_word.join(" ")
  end

  def make_save
    Dir.mkdir("savefile") unless Dir.exists?("savefile")

    filename = "savefile/save.rb"

    File.open(filename, 'w') do |file|
      file.puts hangman_save
    end
  end

  def status
    puts "Guessed Letters: #{@@guessed_letters.sort.join(", ")}"
    puts "Turn: #{@@turn}"
    puts "Incorrect Tries Remaining: #{@@tries}"
  end

  def guess
    puts "Please input a letter. Type 1 to solve or 2 to save."
    letter_input = gets.strip.upcase
    case letter_input
    when /[a-zA-Z]/
      if letter_input.length != 1
        puts "Please input only 1 letter"
      elsif @@guessed_letters.include?(letter_input)
        puts "Please select a letter that has not been selected"
      else
        @@letter_guess = letter_input
        letter_check(@@letter_guess)
        @@turn += 1
      end
    when "1"
      solve
    when "2"
      make_save
      puts "State saved"
      guess
    else 
      puts "Please input a letter or other option"
    end
    status
    gameOver == true ? gameOver : guess
  end
end

class Hangman 
include HangmanForms
  def initialize
    start
    status
    guess
  end

  def solve
    puts "Please type your guess"
    guess_input = gets.strip.upcase
    case guess_input
    when /[a-zA-Z]/
      if guess_input == @@secret_word
        puts "YOU WIN"
        return playAgain
      elsif guess_input != @@secret_word
        puts "YOU LOSE"
        return playAgain
      end
    else 
      "Please input only letters"
    end
  end

  def gameOver
    if @@blank_word.include?("_") == false
      puts "YOU WIN!"
      return playAgain
    elsif @@tries == 0
      puts "YOU LOSE. THE WORD WAS #{@@secret_word}!"
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

class LoadHangman < Hangman
include HangmanForms
  def initialize
    hangman_load
    status
    guess
  end
end