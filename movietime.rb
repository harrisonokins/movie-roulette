require 'iso8601'
require 'json'
require 'open-uri'
require 'nokogiri'

def get_random_movie
  id = rand(2..812632)
  url = "https://www.themoviedb.org/movie/#{id}"

  begin
    movie = Nokogiri::HTML(URI.open(url))
  rescue OpenURI::HTTPError
    return get_random_movie
  end

  # Make sure there are ratings
  rating = movie.at_css('.user_score_chart')['data-percent']
  if rating == "0.0"
    puts "No ratings were present; trying again."
    return get_random_movie
  end

  # Make sure a poster exists
  if movie.at_css('.poster.no_image')
    puts "No poster found; trying again."
    return get_random_movie
  end

  { url: url }
end
