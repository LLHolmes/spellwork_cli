class SpellworkCli::Spell
  attr_accessor :name, :type, :description, :url, :effect, :light, :incantation, :hand_motion #, :creator, :practitioners

  @@all = []
  # Scrape website and return Spells based on that info

  def initialize(name, type, description, url)
    @name = name
    @type = type
    @description = description
    @url = url
    @@all << self
  end

  def add_details(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end

  def self.types
    # returns an array of unique types of spells
    self.all.collect { |spell| spell.type }.uniq.sort
  end

  def self.find_by_type(type)
    self.all.select { |spell| spell if spell.type == type }
  end

  def self.list_name_by_type(type)
    # returns an array of all spells with a specific type
    self.find_by_type.collect { |item| item.name }.sort
  end

  # def self.details_from_type_list(index)
  #   # returns casting information for the spell from the type list with the given index?????
  #   # VS HAVING TO CHANGE INDEX TO NAME FOR CASTING_INFO(NAME)????
  # end

  def self.find_by_name(name)
    self.all.detect { |spell| spell if spell.name == name }
  end

  def self.request_info_by_name(name)
    # adds casting information for a spell with a given name & returns spell
    requested_spell = self.find_by_name(name)
    spell_url = requested_spell.url
  # NEED FIX IF NO URL AVAILABLE
    SpellworkCli::Scraper.scrape_details(requested_spell, spell_url)
    requested_spell
  end

end

# spell1 = SpellworkCli::Spell.new
# spell1.name = "Alohamorra"
# spell1.type = "Charm"
# spell1.description = "opens door"
#
# spell2 = SpellworkCli::Spell.new
# spell2.name = "Accio"
# spell2.type = "Transfiguration"
# spell2.description = "calls object to wizard"
#
# spell3 = SpellworkCli::Spell.new
# spell3.name = "Wingardium Leviosa"
# spell3.type = "Counter-Spell"
# spell3.description = "levitates object"

# A spell has a name
# A spell has a type
# A spell needs a url

# A spell has a description

# A spell has an effect
# A spell has a light
# A spell has an incantation
# A spell possibly has a hand motion
