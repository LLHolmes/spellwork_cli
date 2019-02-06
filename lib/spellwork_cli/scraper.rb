class SpellworkCli::Scraper

  def self.scrape_fandom_wiki_index
    html = open('https://harrypotter.fandom.com/wiki/List_of_spells')
    doc = Nokogiri::HTML(html)

    doc.css('h3 .mw-headline').each.with_index do |element, i|
      array = []
      hash = {}

      # Scrape name - some names listed ()
      element.text[0] == "(" ? name = element.text[1...-1] : name = element.text
      name = element.text

      # Scrape url
      if element.css('a').attr('href') == nil
        url = nil
      else
        url = "https://harrypotter.fandom.com" + element.css('a').attr('href').text
      end

      # Scrape type & description
      doc.css('h3 + dl')[i].css('dd').each do |list_item|
        array << list_item.text
      end
      array.each do|item|
        hash[item.strip.split(": ")[0]] = item.strip.split(": ")[1]
      end
      type = hash["Type"]
      description = hash["Description"]

      # Create new instance for each element
      SpellworkCli::Spell.new(name, type, description, url)
    end
    # WILL NEED TYPE TO DEFAULT TO "SPELL" IF NONE GIVEN.
    # WILL NEED TO CLEAN UP TYPE IF MORE THAN ONE GIVEN.
  end

  def self.scrape_details(spell, url)
    html = open(url)
    doc = Nokogiri::HTML(html)

    attributes = {}

    doc.css('.pi-data').each do |element|
      attributes[element.('.pi-data-label').text] = element.('.pi_data-value').text
    end

    spell.add_details(attributes)
    # Go to specific spell page
    # Scrape incantation (if applicable)
    # Scrape hand_motion (if applicable)
    # Scrape effect
    # Scrape light (if applicable)

    # Possibly scrape creator (if applicable)
    # Possibly scrape practitioners (if applicable)
  end

end
