require 'JSON'
require 'rest-client'
require 'pry'

#puts char
# iterate ove the character hash to find the collection of `films` for the given
#   `character`
# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `parse_character_movies`
#  and that method will do some nice presentation stuff: puts out a list
#  of movies by title. play around with puts out other info about a given film.

def get_character_movies_from_api(character)
  #make the web request
  link = "http://www.swapi.co/api/people/"
  character_hash = parse_json(link)
  link = character_hash["next"]

  while link != nil
    character_hash["results"] = character_hash["results"].replace(parse_json(link)["results"])
    break if check_for_character(character_hash["results"], character)
    link = parse_json(link)["next"]
  end

  char = get_character_info(character_hash, character)

end

def get_character_info(character_hash, character)
  character_hash["results"].find {|entry| character == entry["name"].downcase}
end

def check_for_character(array, character)
  if array.find {|q_char|
    q_char["name"].downcase == character} then true
  else false end
end

def get_movies_from_api(movie)
  parse_json(movie)["title"]
end

def parse_json(link)
  a = RestClient.get(link)
  JSON.parse(a)
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash["films"].each_with_index do |film, index|
    puts "#{index + 1} #{get_movies_from_api(film)}"
  end

end

def show_character_movies(character)
  puts "#{character.split.map(&:capitalize).join(' ')} was in: \n"
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
