class SpellworkCli::Scraper

  def self.scrape_fandom_wiki_index
    html = open('https://harrypotter.fandom.com/wiki/List_of_spells')
    doc = Nokogiri::HTML(html)


    doc.css('h3 .mw-headline').each.with_index do |element, i|
      array = []
      hash = {}


      name = element.text
      #=> "Accio (Summoning Charm)"
      url = "https://harrypotter.fandom.com" + element.css('a').attr('href').text
      #=> "/wiki/Summoning_Charm"
      doc.css('h3 + dl')[i].css('dd').each do |list_item|
        array << list_item.text
      end
      array.each do|item|
        hash[item.strip.split(": ")[0]] = item.strip.split(": ")[1]
      end
      type = hash["Type"]
      description = hash["Description"]

      binding.pry

    end
    # name = doc.css('h3 .mw-headline')[1].text
    # url = doc.css('h3 .mw-headline')[1].css('i a').attr('href').text
    # doc.css('h3 + dl').first.css('dd').first.text
      # => "Type: Charm\n"
      # => "Pronunciation: Ah-bare-toh\n"
      # => "Description: A spell presumably used to open objects such as doors or windows. \n"


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
