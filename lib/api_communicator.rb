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
  all_characters = RestClient.get(link)
  character_hash = JSON.parse(all_characters)
  link = character_hash["next"]

  while link != nil
    adding_characters = RestClient.get(link)
    add_character_hash = JSON.parse(adding_characters)
    character_hash["results"].concat add_character_hash["results"]
    link = add_character_hash["next"]
  end

  puts link

  char = character_hash["results"].each_with_object({}) do |entry, hash|
    if character == entry["name"].downcase
  #    puts entry["name"]
       hash.merge!(entry)
    end
  end
end

def get_movies_from_api(movie)
  this_movie = RestClient.get(movie)
  this_movie = JSON.parse(this_movie)
  this_movie["title"]
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash["films"].each_with_index do |film, index|
    puts "#{index + 1} #{get_movies_from_api(film)}"
  end

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
