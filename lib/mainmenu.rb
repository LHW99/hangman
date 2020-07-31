require '/home/haiduk/odin_projects/hangman/lib/hangman'

puts "Welcome to Hangman! Please select from the following:"
case gets.strip
when "1"
  Hangman.new
when "2"
  puts "test"
when "3"
  exit!
end