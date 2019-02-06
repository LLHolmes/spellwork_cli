class SpellworkCli::Scraper

  def self.scrape_fandom_wiki_index
    html = open('https://harrypotter.fandom.com/wiki/List_of_spells')
    doc = Nokogiri::HTML(html)

    doc.css('h3 .mw-headline').each.with_index do |element, i|
      # Scrape name - some names listed ()
      element.text[0] == "(" ? name = element.text[1...-1] : name = element.text
      name = element.text

      # Scrape url
      if element.css('a').attr('href') == nil
        url = nil
      else
        url = "https://harrypotter.fandom.com" + element.css('a').attr('href').text
      end

      # Scrape type & desc. - 1. find correct dd
      attributes = nil
      detail_array = []
      detail_hash = {}
      if element.parent.next_element.css('dd')[1]
        attributes = element.parent.next_element.css('dd')
      elsif element.parent.next_element.next_element.css('dd')[1]
        attributes = element.parent.next_element.next_element.css('dd')
      else
        attributes = element.parent.next_element.next_element.next_element.css('dd')
      end
      # Scrape type & desc. - 2. make array of dd text elements, then split them into a hash
      attributes.each do |list_item|
        detail_array << list_item.text.strip
      end
      # Scrape type & desc. - 3. split array items into key/value pairs and add to hash
      detail_array.each do|item|
        detail_hash[item.split(": ")[0]] = item.split(": ")[1]
      end
      type = detail_hash["Type"]
      description = detail_hash["Description"]

      SpellworkCli::Spell.new(name, type, description, url)
    end
    # WILL NEED TYPE TO DEFAULT TO "SPELL" IF NONE GIVEN.
    # WILL NEED TO CLEAN UP TYPE IF MORE THAN ONE GIVEN.
    "Encyclopedia loaded!"
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
