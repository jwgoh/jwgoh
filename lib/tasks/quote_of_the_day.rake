require "open-uri"

desc "Crawl website daily for quote of the day"
task qotd: :environment do
  website = "http://www.brainyquote.com/quotes_of_the_day.html"
  page = Nokogiri::HTML(open(website))
  quote = page.css(".bqQuoteLink")[0].text
  Quote.create(text: quote)
end
