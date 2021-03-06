class SpellworkCli::Spell
  attr_accessor :name, :type, :description, :url, :subtype, :effect, :light, :incantation, :hand_movement, :creator

  @@all = []

  def initialize(name, type, description, url)
    @name = name
    @type = classify_type(type, name)
    if description
      @description = description
    else
      @description = "Details unknown"
    end
    @url = url
    @@all << self
  end

  def classify_type(type, name)
    if name == "Cornflake skin spell"
      "Dark Charm"
    elsif name == "Green Sparks" || name == "Morsmordre(Dark Mark)"
      "Transfiguration"
    elsif type
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
    if self.effect
      if self.type.include?("Spell")
        if self.type != self.subtype && self.subtype
          puts "\n#{self.name} is a #{self.subtype.downcase} form of a #{self.type.downcase} spell which #{self.effect.downcase}."
        else
          puts "\n#{self.name} is a #{self.type.downcase} that #{self.effect.downcase}."
        end
      elsif self.type != self.subtype && self.subtype
        puts "\n#{self.name} is a #{self.subtype.downcase} form of a #{self.type.downcase} spell which #{self.effect.downcase}."
      else
        puts "\n#{self.name} is a #{self.type.downcase} spell that #{self.effect.downcase}."
      end
    else
      if self.type.include?("Spell")
        if self.type != self.subtype && self.subtype
          puts "#{self.name} is a #{self.subtype.downcase} form of a #{self.type.downcase}."
        else
          puts "#{self.name} is a #{self.type.downcase}."
        end
      elsif self.type != self.subtype && self.subtype
        puts "#{self.name} is a #{self.subtype.downcase} form of a #{self.type.downcase} spell."
      else
        puts "#{self.name} is a #{self.type.downcase} spell."
      end
    end

    puts "#{self.description}" unless self.description == nil

    if self.incantation && self.hand_movement
      puts "To use the spell, #{self.hand_movement.downcase} and say the incantation: #{self.incantation.gsub("(", " (")}."
    elsif self.incantation
      puts "To use the spell, say the incantation: #{self.incantation.gsub("(", " (")}."
    elsif self.hand_movement
      puts "To use the spell, #{self.hand_movement.downcase}."
    end

    if self.light == "None"
      puts "It will produce no light."
    elsif self.light != nil
      puts "It will produce #{self.light.downcase} light."
    end
  end

  def self.all
    @@all
  end

  def self.types
  # returns an array of unique types of spells
    self.all.collect { |spell| spell.type }.uniq.sort
  end

  def self.find_by_type(type)
  # returns an array of spells of a specific type
    self.all.select { |spell| spell if spell.type == type }
  end

  def self.find_in_encyclopedia(letter)
  # returns an array of spells beginning with a specific letter
    self.all.select { |spell| spell if spell.name.downcase.start_with?(letter) }
  end

  def self.search(word)
  # returns an array of spells who's name or description contain a specific keyword
    self.all.select { |spell| spell if spell.name.downcase.include?(word.downcase) || spell.description.downcase.include?(word.downcase) }
  end

  def self.find_by_name(name)
  # returns a spell instance with specific name
    self.all.detect { |spell| spell if spell.name == name }
  end

  def self.request_info_by_spell(spell)
  # adds additional information for a spell
    if spell.url == nil || spell.effect
      spell.list_additional_details
    else
      spell.add_details(SpellworkCli::Scraper.scrape_details(spell.url))
      spell.list_additional_details
    end
  end

  # def self.request_all
  # # to test all 2nd level scraping
  #   self.all.each.with_index do |spell, i|
  #     if spell.url == nil || spell.effect
  #       puts "#{i}. No url for #{spell.name}."
  #     else
  #       spell.add_details(SpellworkCli::Scraper.scrape_details(spell.url))
  #       puts "#{i}. Added details to #{spell.name}."
  #     end
  #   end
  #   "All 2nd level scraping passing!"
  # end

end
