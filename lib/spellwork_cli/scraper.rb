class SpellworkCli::Scraper

  def self.scrape_fandom_wiki_index
    html = open('https://harrypotter.fandom.com/wiki/List_of_spells#A')
    doc = Nokogiri::HTML(html)

    binding.pry

    # monster_elements = doc.css('ul.colum li ul li a;')

    # Go to index page
    # Scrape name
    # Scrape type
    # Scrape description
    # Scrape url

  # monster_elements.each do |monster_element|
  # 	monster = Monster.new
  # 	monster.name = monster_element.text
  # 	monster.url = “http://www.d20srd.org” + monster_element.attr('href')
  # 	doc = Nokogiri::HTML(open(monster.url))		#nests scraping to get a detail off the individual monster page
  # 	monster.challenge_rating = doc.css(“table tr td”)[34]
  # end
  end

  def self.scrape_details(spell)
    # Go to specific spell page
    # Scrape incantation
    # Scrape hand_motion (if applicable)
    # Scrape effect
    # Scrape light

    # Possibly scrape creator
    # Possibly scrape practitioners
  end

end


# spells have:
#  :name, :type, :description, :url, :effect, :light, :incantation, :hand_motion
# spells possibly have:
# :creator, :practitioners
