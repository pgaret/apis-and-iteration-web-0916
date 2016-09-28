def welcome
  # puts out a welcome message here!
  puts "Welcome to this attempt to understand APIs through SWAPI!"
end

def get_character_from_user
  puts "Please enter a character: "
  # use gets to capture the user's input. This method should return that input, downcased.
  gets.chomp.downcase
end
