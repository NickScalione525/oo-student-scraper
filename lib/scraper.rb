require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    doc.css(".roster-cards-container .student-card").collect do |student|
      {name: student.css(".student-name").text, location: student.css(".student-location").text, profile_url: student.css("a").attr("href").text}
     end
    end

  def self.scrape_profile_page(profile_url)
    prof = Nokogiri::HTML(open(profile_url))
    prof2 = prof.css(".social-icon-container").css("a")
    prof3 = prof2.collect {|element| element.attributes["href"].value}
    hash = {}
    prof3.detect do |link|
      hash[:twitter] = link if link.include?("twitter")
      hash[:linkedin] = link if link.include?("linkedin")
      hash[:github] = link if link.include?("github")
    end
    hash[:blog] = prof3[3] if !prof3[3].nil?
    hash[:profile_quote] = prof.css(".profile-quote").text
    hash[:bio] = prof.css(".description-holder").css("p")[0].text
    hash
  end
    

end

