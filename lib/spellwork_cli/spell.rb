class SpellworkCli::Spell
  attr_accessor :name, :type, :description, :url, :subtype, :effect, :light, :incantation, :hand_movement #, :creator, :practitioners

  @@all = []
  # Scrape website and return Spells based on that info

  def initialize(name, type, description, url)
    @name = name
    @type = classify_type(type, name)
    @description = description
    @url = url
    @@all << self
  end

  def classify_type(type, name)
    if type
      if type.include?("Healing")
        "Healing Spell"
      elsif type.include?("Counter") || type.include?("Untransfiguration")
        "Counter-Spell"
      elsif type.include?("Curse") || type == "Hex" || type == "Jinx"
        "Dark Charm"
      elsif type.include?("Transfiguration") || type.include?("Conjuration")
        "Transfiguration"
      elsif type == "Charm"
        "Charm"
      else
        "Spell"
      end
    elsif name == "Cornflake skin spell"
      "Dark Charm"
    elsif name == "Green Sparks" || name == "Morsmordre(Dark Mark)"
      "Transfiguration"
    else
      "Spell"
    end
  end

  def add_details(attributes)
    attributes.each do |key, value|
      if key == "type"
        @subtype = value
      elsif key == "hand_movement" && value == ""
        @hand_movement = nil
      else
        self.send(("#{key}="), value)
      end
    end
  end

  def list_additional_details
    if self.type != self.subtype && self.subtype
      puts "#{self.name} is a #{self.subtype.downcase} form of a #{self.type.downcase} spell that #{self.effect.downcase}."
    else
      puts "#{self.name} is a #{self.type.downcase} spell that #{self.effect.downcase}."
    end

    if self.description != nil
      puts "  #{self.description}"
    end

    if self.incantation && self.hand_movement
      puts "  To use the spell, #{self.hand_movement.downcase} and say the incantation: #{self.incantation.gsub("(", " (")}."
    elsif self.incantation
      puts "  To use the spell, say the incantation: #{self.incantation.gsub("(", " (")}."
    elsif self.hand_movement
      puts "  To use the spell, #{self.hand_movement.downcase}."
    end

    if self.light == "None"
      puts "  It will produce no light."
    elsif self.light != nil
      puts "  It will produce #{self.light.downcase} light."
    end
    # puts self.type
    # puts self.url
    # puts self.description
    # puts self.subtype
    # puts self.light
    # puts self.incantation
    # puts self.effect
    # puts self.hand_movement
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

  def self.request_info_by_spell(spell)
    # adds casting information for a spell with a given name & returns spell
    # requested_spell = spell
  # NEED FIX IF NO URL AVAILABLE
    # url = spell.url
    spell.add_details(SpellworkCli::Scraper.scrape_details(spell.url))
    spell.list_additional_details
  end

  def self.find_by_name(name)
    self.all.detect { |spell| spell if spell.name == name }
  end

  # def self.request_info_by_name(name)
  #   # adds casting information for a spell with a given name & returns spell
  #   requested_spell = self.find_by_name(name)
  #   spell_url = requested_spell.url
  # # NEED FIX IF NO URL AVAILABLE
  #   SpellworkCli::Scraper.scrape_details(requested_spell, spell_url)
  #   requested_spell
  # end

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
