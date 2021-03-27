require 'iso8601'
require 'json'
require 'open-uri'
require 'nokogiri'

def get_latest_id
  recent_releases = Nokogiri::HTML(URI.open('https://www.imdb.com/list/ls016522954'))
  recent_releases.at_css('.lister-item-image')['data-tconst'].sub('tt', '').to_i
end

def get_random_movie(ceiling)
  id = rand(ceiling)

  begin
    movie = Nokogiri::HTML(URI.open("https://www.imdb.com/title/tt#{id}"))
  rescue OpenURI::HTTPError
    return get_random_movie(ceiling)
  end

  data = JSON.parse(movie.at_css('script[type="application/ld+json"]').text)

  # Get a new movie if we got a TV show
  if data['@type'] != 'Movie'
    puts "Got a TV show; trying again..."
    return get_random_movie(ceiling)
  end

  genres = Array(data['genre'])

  # Get a new movie if we got a short
  if genres.include?("Short")
    puts "Got a short; trying again..."
    return get_random_movie(ceiling)
  end

  # Get a new movie if we got a documentary
  if genres.include?("Documentary")
    puts "Got a documentary; trying again..."
    return get_random_movie(ceiling)
  end

  # Get a new movie if it's unrated
  if data['contentRating'] == "Not Rated"
    puts "Movie was unrated; trying again..."
    return get_random_movie(ceiling)
  end

  # Get a new movie if the runtime is too short
  if data['duration'].nil?
    puts "No duration provided; trying again..."
    puts data.inspect
    return get_random_movie(ceiling)
  end

  duration = ISO8601::Duration.new(data['duration'])

  if duration.to_seconds < 3600
    puts "Film was too short; trying again..."
    return get_random_movie(ceiling)
  end

  # TODO: Get a different film if there are no ratings

  data
end

latest_release_id = get_latest_id
puts "\nLatest ID: #{latest_release_id}"
movie = get_random_movie(latest_release_id)
puts movie['name']
puts "https://www.imdb.com/#{movie['url']}"

puts "\n Full data:"
puts movie.inspect
