require '/home/haiduk/odin_projects/hangman/lib/hangman'
require 'json'

puts "Welcome to Hangman! Please select from the following:\n1. New Game"
puts "2. Load Game \n3. Exit"
case gets.strip
when "1"
  Hangman.new
when "2"
  LoadHangman.new
when "3"
  exit!
end